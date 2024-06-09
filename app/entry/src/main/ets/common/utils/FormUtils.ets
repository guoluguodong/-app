import formBindingData from '@ohos.app.form.formBindingData';
import formProvider from '@ohos.app.form.formProvider';
import RdbUtils from '../database/rdb/RdbUtils';
import FormInfoApi from '../dataBase/tables/FormInfoApi';
import DayInfoApi from '../dataBase/tables/DayInfoApi';
import AgencyCardInfo from '../../viewmodel/AgencyCardInfo';
import FormInfo from '../../viewmodel/FormInfo';
import Logger from '../utils/Logger';
import ProgressCardInfo from '../../viewmodel/ProgressCardInfo';
import { columnDayInfoList, columnTaskInfoInfoList, columnFormInfoList } from '../../model/RdbColumnModel';
import { CommonConstants as Const, Unit, TaskType } from '../constants/CommonConstants';
import DayInfo from '../../viewmodel/DayInfo';
import { GlobalContext } from './GlobalContext';
import AccountTable from '../../common/database/tables/AccountTable';
import AccountData from '../../common/database/AccountData';

class FormUtils {

  /**
   * Insert form data
   *
   * @param {Context} context Indicates the context of application or capability.
   * @param {FormInfo} formInfo Insert the form information to be saved.
   */
  public insertFormData(context: Context, formInfo: FormInfo): void {
    RdbUtils.initDb(context, Const.RDB_NAME.dbName ? Const.RDB_NAME.dbName : '');
    FormInfoApi.insertData(formInfo, (isDone: number) => {
      if (isDone) {
        this.queryForms();
        Logger.error(Const.TAG, 'insertFormData');
      }
    });
  }

  /**
   * Update card operation
   *
   * @param {Context} context Indicates the context of application or capability.
   */
  public updateCards(context: Context): void {
    RdbUtils.initDb(context, Const.RDB_NAME.dbName ? Const.RDB_NAME.dbName : '');
    let isCreatePromise = RdbUtils.isCreateTable(Const.FORM_INFO.tableName ?
    Const.FORM_INFO.tableName : '', columnFormInfoList);
    isCreatePromise.then((result: boolean) => {
      if (!result) {
        Logger.error(Const.TAG, 'updateCards form table create error');
        return;
      }
      this.queryForms();
    });
  }

  /**
   * Delete form data
   *
   * @param {Context} context Indicates the context of application or capability.
   * @param {string} formId delete form id
   */
  public deleteFormData(context: Context, formId: string): void {
    RdbUtils.initDb(context, Const.RDB_NAME.dbName ? Const.RDB_NAME.dbName : '');
    let isCreatePromise = RdbUtils.isCreateTable(Const.FORM_INFO.tableName ?
    Const.FORM_INFO.tableName : '', columnFormInfoList);
    isCreatePromise.then((result: boolean) => {
      if (!result) {
        Logger.error(Const.TAG, 'deleteFormData form table create error');
        return;
      }
      FormInfoApi.deleteFormData(formId);
    });
  }

  /**
   * Update form operation
   */
  public queryForms(): void {
    Logger.info(Const.RDB_TAG, '进入后台循环查询，查询form')
    FormInfoApi.queryFormData((resultSet: Array<FormInfo>) => {
      resultSet.forEach((item: FormInfo) => {
        Logger.info(Const.RDB_TAG, '进入后台循环查询，查询form成功')
        this.updateRectangleCards(item);

      });
    });
  }

  /**
   * Background update all card
   */
  public backgroundUpdateCard(taskListChange: boolean): void {
    Logger.info(Const.RDB_TAG, '进入后台循环查询')
    if (taskListChange) {
      Logger.info(Const.RDB_TAG, '进入后台循环查询，列表更新')
      GlobalContext.getContext().setObject('taskListChange', false);
      let timeId = setTimeout(() => {
        this.queryForms();
        clearInterval(timeId);
      }, Const.TIMES_100);
    }
  }

  private updateRectangleCards(formInfo: FormInfo): void {
    Logger.info(Const.RDB_TAG, '进入后台循环查询，updateRectangleCards')
    if ((formInfo.formName === Const.WIDGET_NAME_AGENCY) &&
    (formInfo.formDimension === Const.DEFAULT_DIMENSION_2X4)) {
      this.dateQueryTaskInfo(formInfo, new Date().toDateString());
      Logger.info(Const.RDB_TAG, '------------------查询')
    }
    if ((formInfo.formName === Const.WIDGET_NAME_PROGRESS) &&
    (formInfo.formDimension === Const.DEFAULT_DIMENSION_2X2)) {
      let createPromise = RdbUtils.isCreateTable(Const.DAY_INFO.tableName ?
      Const.DAY_INFO.tableName : '', columnDayInfoList);
      createPromise.then((result: boolean) => {
        if (!result) {
          Logger.error(Const.TAG, 'dayInfo create table error');
          return;
        }
        this.dateQueryDayInfo(formInfo, new Date().toDateString());
      }).catch((err: Error) => {
        Logger.error(Const.TAG, `dayInfo err : ${JSON.stringify(err)}`);
      });
    }
  }

  private dateQueryTaskInfo(formInfo: FormInfo, dateKey: string): void {
    Logger.info(Const.RDB_TAG, '进入后台循环查询，查询AccountTable')
    AccountTable.query((result: AccountData[]) => {
      Logger.error(Const.TAG, `进入后台循环查询，查询AccountTable成功 : ${JSON.stringify(result.length)}`);
      if (result.length === 0) {
        // Query task data based on the global field.
        this.globalQueryTaskInfo(formInfo, Const.GLOBAL_KEY);
        Logger.info(Const.RDB_TAG, '------------------查询0')
      } else {
        this.processTaskData(formInfo, result);
        Logger.info(Const.RDB_TAG, '------------------查询1')
      }
    });

  }

  private dateQueryDayInfo(formInfo: FormInfo, dateKey: string): void {
    DayInfoApi.query(dateKey, (data: DayInfo) => {
      if (data.date === '') {
        // Query day data based on the global field.
        this.globalQueryDayInfo(formInfo, Const.GLOBAL_KEY);
      } else {
        AccountTable.query((result: AccountData[]) => {
          this.processDayData(formInfo, result);
        });
      }
    });
  }

  private globalQueryTaskInfo(formInfo: FormInfo, dateKey: string): void {
    let AccountTable;
    AccountTable = new AccountTable(() => {
    });
    AccountTable.getRdbStore(() => {
      AccountTable.query((result: AccountData[]) => {
        this.processTaskData(formInfo, result);
      });
    });
  }

  private globalQueryDayInfo(formInfo: FormInfo, dateKey: string): void {
    AccountTable.query((result: AccountData[]) => {
      this.processDayData(formInfo, result);
    });
  }

  private processTaskData(formInfo: FormInfo, data: AccountData[]): void {
    let taskList: AgencyCardInfo[] = this.fetchResult(data);
    let obj: ProgressCardInfo = {};
    obj.taskList = taskList;
    obj.showWidget = taskList.length === 0 ? false : true;
    Logger.info(Const.TAG, `taskList.length ${taskList.length}`);
    let formData = formBindingData.createFormBindingData(obj);
    formProvider.updateForm(formInfo.formId, formData).catch((err: Error) => {
      Logger.error(Const.TAG, `processTaskData updateForm, err: ${JSON.stringify(err)}`);
    });
  }

  private processDayData(formInfo: FormInfo, data: AccountData[]): void {
    let finTaskNum: number = 0;
    let targetTaskNum: number = 0;
    let percent: string = '0';
    if (data.length > 0) {
      finTaskNum = 6-data.length
      targetTaskNum = 6
      percent = targetTaskNum === 0 ? '0' : Math.ceil(finTaskNum / targetTaskNum * Const.DEFAULT_100).toFixed();
    }
    let obj: ProgressCardInfo = new ProgressCardInfo();
    obj.numerator = finTaskNum;
    obj.denominator = targetTaskNum;
    obj.percent = percent;
    let formData = formBindingData.createFormBindingData(obj);
    formProvider.updateForm(formInfo.formId, formData).catch((err: Error) => {
      Logger.error(Const.TAG, `processDayData updateForm, err: ${JSON.stringify(err)}`);
    });
  }

  private getTemp(temp: AgencyCardInfo, taskType: string, unit: string,
                  dateType: boolean, isDone: boolean): AgencyCardInfo {
    let agencyCardInfo: AgencyCardInfo = new AgencyCardInfo();
    agencyCardInfo.targetValue = temp.targetValue;
    agencyCardInfo.finValue = temp.finValue;
    agencyCardInfo.finValueIsNull = temp.finValueIsNull;
    agencyCardInfo.taskType = taskType;
    agencyCardInfo.unit = unit;
    agencyCardInfo.dateType = dateType;
    agencyCardInfo.isDone = isDone;
    return agencyCardInfo;
  }

  private fetchResult(data: AccountData[]): Array<AgencyCardInfo> {
    let taskList: Array<AgencyCardInfo> = new Array<AgencyCardInfo>();
    data.forEach((item: AccountData) => {
      let temp: AgencyCardInfo = {
        targetValue: item.typeText,
        finValue: String(item.hour) + ':' + String(item.minute),
        finValueIsNull: false,
      };
      temp = this.getTemp(temp, TaskType.Getup, Unit.Empty, true, true);
      taskList.push(temp);
    });
    Logger.info(Const.TAG, 'fetchResult taskList ' + JSON.stringify(taskList));
    return taskList;
  }
}

export default new FormUtils();
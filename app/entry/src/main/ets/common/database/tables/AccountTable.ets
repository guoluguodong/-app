import relationalStore from '@ohos.data.relationalStore';
import AccountData from '../AccountData';
import { CommonConstants } from '../../constants/CommonConstants';
import dataRdb from '@ohos.data.relationalStore';
import Logger from '../../utils/Logger';
import RdbUtils from '../Rdb/RdbUtils';
class AccountTable {

  insertData(account: AccountData, callback: Function) {
    const valueBucket: relationalStore.ValuesBucket = generateBucket(account);
    Logger.info(CommonConstants.RDB_TAG, `accountTable insertData() try`);
    RdbUtils.insert('accountTable', valueBucket).then(result => {
      Logger.info(CommonConstants.RDB_TAG, `accountTable insertData() success: ${result}`);
      callback(result);
    });

  }

  deleteData(account: AccountData, callback: Function) {
    // let predicates = new relationalStore.RdbPredicates(CommonConstants.ACCOUNT_TABLE.tableName);
    // predicates.equalTo('id', account.id);
    // this.accountTable.deleteData(predicates, callback);
    let tableName = CommonConstants.AccountTable_INFO.tableName;
    if (!tableName) {
      return;
    }
    let predicates = new dataRdb.RdbPredicates(tableName);
    predicates.equalTo('id', account.id);
    RdbUtils.del(predicates).then(result => {
      callback(result);
    });
  }

  updateData(account: AccountData, callback: Function) {
    // const valueBucket: relationalStore.ValuesBucket = generateBucket(account);
    // let predicates = new relationalStore.RdbPredicates(CommonConstants.ACCOUNT_TABLE.tableName);
    // predicates.equalTo('id', account.id);
    // this.accountTable.updateData(predicates, valueBucket, callback);


    const valueBucket = generateBucket(account);
    let tableName = CommonConstants.AccountTable_INFO.tableName;
    if (!tableName) {
      return;
    }
    let predicates = new dataRdb.RdbPredicates(tableName);
    predicates.equalTo('id', account.id);
    RdbUtils.update(valueBucket, predicates).then((result: number) => {
      callback(result);
    });
  }

  query(callback: Function) {
    // let predicates = new relationalStore.RdbPredicates(CommonConstants.ACCOUNT_TABLE.tableName);
    // this.accountTable.query(predicates, (resultSet: relationalStore.ResultSet) => {
    let tableName = CommonConstants.AccountTable_INFO.tableName;
    Logger.info(CommonConstants.RDB_TAG, `query() ${tableName}`);
    if (!tableName) {
      return;
    }
    let predicates = new dataRdb.RdbPredicates(tableName);
    RdbUtils.query(predicates).then(resultSet => {
      let count: number = resultSet.rowCount;
      Logger.info(CommonConstants.RDB_TAG, `query() finished, count: ${count}`);
      if (count === 0 || typeof count === 'string') {
        console.log(`${CommonConstants.TABLE_TAG}` + 'Query no results!');
        callback([]);
      } else {
        resultSet.goToFirstRow();
        const result: AccountData[] = [];
        for (let i = 0; i < count; i++) {
          let tmp: AccountData = {
            id: 0,
            accountType: 0,
            typeText: '',
            amount: 0,
            year: 2000,
            month: 11,
            day: 11,
            hour: 0,
            minute: 0,
            endyear: 2001,
            endmonth: 1,
            endday: 1,
            endhour: 0,
            endminute: 0,
            note: '',
            typeWhereText:''
          };

          tmp.id = resultSet.getDouble(resultSet.getColumnIndex('id'));
          tmp.accountType = resultSet.getDouble(resultSet.getColumnIndex('accountType'));
          tmp.typeText = resultSet.getString(resultSet.getColumnIndex('typeText'));
          tmp.amount = resultSet.getDouble(resultSet.getColumnIndex('amount'));
          tmp.year = resultSet.getDouble(resultSet.getColumnIndex('year'));
          tmp.month = resultSet.getDouble(resultSet.getColumnIndex('month'));
          tmp.day = resultSet.getDouble(resultSet.getColumnIndex('day'));
          tmp.hour = resultSet.getDouble(resultSet.getColumnIndex('hour'));
          tmp.minute = resultSet.getDouble(resultSet.getColumnIndex('minute'));
          tmp.endyear = resultSet.getDouble(resultSet.getColumnIndex('endyear'));
          tmp.endmonth = resultSet.getDouble(resultSet.getColumnIndex('endmonth'));
          tmp.endday = resultSet.getDouble(resultSet.getColumnIndex('endday'));
          tmp.endhour = resultSet.getDouble(resultSet.getColumnIndex('endhour'));
          tmp.endminute = resultSet.getDouble(resultSet.getColumnIndex('endminute'));
          tmp.note = resultSet.getString(resultSet.getColumnIndex('note'));
          tmp.typeWhereText = resultSet.getString(resultSet.getColumnIndex('typeWhereText'));

          result[i] = tmp;
          resultSet.goToNextRow();
        }
        callback(result);
      }
    });
  }
}

function generateBucket(account: AccountData): relationalStore.ValuesBucket {
  let obj: relationalStore.ValuesBucket = {};
  obj.accountType = account.accountType;
  obj.typeText = account.typeText;
  obj.amount = account.amount;
  obj.year = account.year;
  obj.month = account.month;
  obj.day = account.day;

  obj.hour = account.hour;
  obj.minute = account.minute;
  obj.endyear = account.endyear;
  obj.endmonth = account.endmonth;
  obj.endday = account.endday;
  obj.endhour = account.endhour;
  obj.endminute = account.endminute;
  obj.note = account.note;
  obj.typeWhereText = account.typeWhereText;

  return obj;
}


let accountTable = new AccountTable();

export default accountTable as AccountTable;
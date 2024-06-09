import AccountTable from '../../common/database/tables/AccountTable';
import AccountData from '../../common/database/AccountData';
import { CommonConstants } from '../../common/constants/CommonConstants';
import { DialogComponent } from '../../view/DialogComponent';
import { ImageList } from '../../common/database/AccountList';
import Logger from '../../common/utils/Logger';
import { ScrollData } from '../../common/database/ScrollData'
import router from '@ohos.router';
import { GroupScroll } from '../../common/database/GroupScroll'
import HashMap from '@ohos.util.HashMap';
import { GlobalContext } from '../../common/utils/GlobalContext';
@Component
export default struct TaskList {
  @State accounts: Array<AccountData> = [];
  @State scroll_accounts: Array<ScrollData> = [];
  @State group_account: HashMap<String, GroupScroll> = new HashMap();
  @State group_account_arr: Array<GroupScroll> = [];
  @State searchText: string = '';
  @State isEdit: boolean = false;
  @State isInsert: boolean = false;
  @State bGC: Color = Color.White;
  @State newAccount: AccountData = {
    id: 0,
    accountType: 0,
    typeText: '',
    amount: 100,
    year: 2023,
    month: 11,
    day: 11,
    hour: 0,
    minute: 0,
    endyear: 2023,
    endmonth: 12,
    endday: 12,
    endhour: 0,
    endminute: 0,
    note: '',
    typeWhereText: ''
  };
  @State index: number = -1;
  scroller: Scroller = new Scroller()
  @State income: number = 0.00;
  @State outcome: number = 0.00;
  @State total: number = 0.00;
  @State isIncome: number = 0;
  @State curYear: number = 2000;
  @State curMonth: number = 1;
  @State curDay: number = 1;
  @State mode: number = 1;
  @State selectedDate: Date = new Date();
  private deleteList: Array<AccountData> = [];
  searchController: SearchController = new SearchController();
  private scroll2DeleteData: ScrollData = null;
  private downX = 0;
  private deleteWidth = 65;
  dialogController: CustomDialogController = new CustomDialogController({
    builder: DialogComponent({
      isInsert: $isInsert,
      newAccount: $newAccount,
      confirm: (isInsert: boolean, newAccount: AccountData) => this.accept(isInsert, newAccount)
    }),
    customStyle: true,
    alignment: DialogAlignment.Bottom
  });

  accept(isInsert: boolean, newAccount: AccountData): void {
    Logger.info(CommonConstants.RDB_TAG, `insertData() accept`);
    if (isInsert) {
      Logger.info(`${CommonConstants.INDEX_TAG}`, `The account inserted is:  ${JSON.stringify(newAccount)}`);
      AccountTable.insertData(newAccount, (id: number) => {
        newAccount.id = id;
        this.accounts.push(newAccount);
        this.accountData2ScrollData(this.accounts);
        GlobalContext.getContext().setObject('taskListChange', true);
        Logger.info(CommonConstants.RDB_TAG, `修改了taskListChange为真 `);
      });
    } else {
      AccountTable.updateData(newAccount, () => {
      });
      let list = this.accounts;
      this.accounts = [];
      list[this.index] = newAccount;
      this.accounts = list;
      this.index = -1;
      this.accountData2ScrollData(this.accounts);
      GlobalContext.getContext().setObject('taskListChange', true);
    }

  }

  aboutToAppear() {
    Logger.info(CommonConstants.RDB_TAG, 'aboutToAppear start');
      AccountTable.query((result: AccountData[]) => {
        this.accounts = result;
        this.accountData2ScrollData(this.accounts);
        GlobalContext.getContext().setObject('taskListChange', true);
        Logger.info(CommonConstants.RDB_TAG, `query() finished, accounts: ${this.accounts.length}`);
        Logger.info(CommonConstants.RDB_TAG, `query() finished, accounts: ${this.accounts}`);
      });
  }

  selectListItem(item: AccountData) {
    this.isInsert = false;
    this.index = this.accounts.indexOf(item);
    this.newAccount = {
      id: item.id,
      accountType: item.accountType,
      typeText: item.typeText,
      amount: item.amount,
      year: item.year,
      month: item.month,
      day: item.day,
      hour: item.hour,
      minute: item.minute,
      endyear: item.endyear,
      endmonth: item.endmonth,
      endday: item.endday,
      endhour: item.endhour,
      endminute: item.endminute,
      note: item.note,
      typeWhereText:item.typeWhereText,
    };
  }

  deleteListItem() {
    for (let i = 0; i < this.deleteList.length; i++) {
      let index = this.accounts.indexOf(this.deleteList[i]);
      this.accounts.splice(index, 1);
      AccountTable.deleteData(this.deleteList[i], () => {
      });
    }
    this.deleteList = [];
    this.isEdit = false;
    this.accountData2ScrollData(this.accounts);
    GlobalContext.getContext().setObject('taskListChange', true);
  }

  accountData2ScrollData(accounts: AccountData[]) {
    this.scroll_accounts = [];
    for (let i = 0;i < accounts.length; ++i) {
      this.scroll_accounts.push({ accountData: accounts[i], scroller: new Scroller() })
    }
    this.sortByYearAndMonth();
    this.divideByYearAndMonth();
    Logger.info(CommonConstants.RDB_TAG, `query() finished, accountData2ScrollData: ${this.scroll_accounts}`);
  }

  CompareCustom(a: ScrollData, b: ScrollData) {
    if (a.accountData.year > b.accountData.year) {
      return false;
    }
    else if (a.accountData.year < b.accountData.year) {
      return true;
    }
    else {
      if (a.accountData.month > b.accountData.month) {
        return false;
      }
      else if (a.accountData.month < b.accountData.month) {
        return true;
      }
      else {
        if (a.accountData.day > b.accountData.day) {
          return false;
        }
        else if (a.accountData.day <= b.accountData.day) {
          return true;
        }
      }
    }
  }

  sortByYearAndMonth() {
    for (let i = 0;i < this.scroll_accounts.length; i++) {
      let max: ScrollData = this.scroll_accounts[i];
      let maxIndex = i;
      for (let j = i + 1;j < this.scroll_accounts.length; j++)
        if (!this.CompareCustom(max, this.scroll_accounts[j])) {
          max = this.scroll_accounts[j];
          maxIndex = j;
        }
      let tmp: ScrollData = this.scroll_accounts[i];
      this.scroll_accounts[i] = this.scroll_accounts[maxIndex];
      this.scroll_accounts[maxIndex] = tmp;
    }
    Logger.info("sort")
  }

  divideByYearAndMonth() {
    this.group_account.clear();
    let titleList = [];
    for (let i = 0;i < this.scroll_accounts.length; i++) {
      let yearMonth: String =
        String(this.scroll_accounts[i].accountData.year) + '年' +
        String(this.scroll_accounts[i].accountData.month + 1) + '月'
      if (!this.group_account.hasKey(yearMonth)) {
        let tmp: Array<ScrollData> = [];
        tmp.push(this.scroll_accounts[i]);
        let gstmp: GroupScroll = new GroupScroll(yearMonth, tmp);
        this.group_account.set(yearMonth, gstmp);
        titleList.push(yearMonth);
      }
      else {
        let gstmp: GroupScroll = this.group_account.get(yearMonth);
        gstmp.scrollData.push(this.scroll_accounts[i]);
        this.group_account.set(yearMonth, gstmp);
      }
    }
    this.group_account_arr = [];
    for (let i = 0;i < titleList.length; i++) {
      this.group_account_arr.push(this.group_account.get(titleList[i]));
    }
  }

  @Builder CustomItem() {

    List({ space: 20 }) {

      ForEach(this.scroll_accounts, item => {
        ListItem() {
          Scroll(item.scroller) {
            Row() {
              Row() {
                Image(ImageList[item.accountData.typeText])
                  .width($r('app.float.component_size_M'))
                  .aspectRatio(1)
                  .margin({ right: $r('app.float.edge_size_MP') })

                Text(item.accountData.typeText)
                  .height($r('app.float.component_size_SM'))
                  .fontSize($r('app.float.font_size_M'))
                  .width(100)
                Divider()
                  .vertical(true)
                  .height(22)
                  .color('#182431')
                  .opacity(0.6)
                  .margin({ left: 0, right: 8 })
                Column() {

                  Row() {
                    Text('   ' + String(item.accountData.year) + '-' + String(item.accountData.month + 1) + '-' + String(item.accountData.day))
                      .height($r('app.float.component_size_SM'))
                      .fontSize($r('app.float.font_size_S'))
                      .fontColor(Color.Gray)
                    Text('   ' + String(item.accountData.hour) + ':' + String(item.accountData.minute))
                      .height($r('app.float.component_size_SM'))
                      .fontSize($r('app.float.font_size_S'))
                      .fontColor(Color.Gray)
                  }

                  Row() {
                    Text(' ~ ' + String(item.accountData.endyear) + '-' + String(item.accountData.endmonth + 1) + '-' + String(item.accountData.endday))
                      .height($r('app.float.component_size_SM'))
                      .fontSize($r('app.float.font_size_S'))
                      .fontColor(Color.Gray)
                    Text('   ' + String(item.accountData.endhour) + ':' + String(item.accountData.endminute))
                      .height($r('app.float.component_size_SM'))
                      .fontSize($r('app.float.font_size_S'))
                      .fontColor(Color.Gray)
                  }
                  Text("备注：" + item.accountData.note)
                    .height($r('app.float.component_size_SM'))
                    .fontSize($r('app.float.font_size_S'))
                    .fontColor(Color.Gray)
                }
                Divider()
                  .vertical(true)
                  .height(22)
                  .color('#182431')
                  .opacity(0.6)
                  .margin({ left: 4, right: 8 })
                Text(item.accountData.typeWhereText)
                  .height($r('app.float.component_size_SM'))
                  .fontSize($r('app.float.font_size_M'))
                  .width(120)
                Blank()
                  .layoutWeight(1)
                if (this.isEdit) {
                  Row() {
                    Toggle({ type: ToggleType.Checkbox })
                      .onChange((isOn) => {
                        if (isOn) {
                          this.deleteList.push(item.accountData);
                        } else {
                          let index = this.deleteList.indexOf(item.accountData);
                          this.deleteList.splice(index, 1);
                        }
                      })
                  }
                  .align(Alignment.End)
                  .flexGrow(1)
                  .justifyContent(FlexAlign.End)
                }

              }
              .width(CommonConstants.FULL_WIDTH)
              .padding({ left: $r('app.float.edge_size_M'), right: $r('app.float.edge_size_M') })

              Button() {
                Text('完成')
                  .height(40)
                  .fontSize($r('app.float.font_size_M'))
              }
              .type(ButtonType.Normal)
              .width(65)
              .backgroundColor($r('app.color.primaryRed'))
              .onClick(() => {
                // this.scroll_accounts.splice(this.scroll_accounts.indexOf(item),1)
                // this.accounts.splice(this.accounts.indexOf(item.accountData),1)
                this.deleteList.push(item.accountData)
                this.deleteListItem()
              })
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .onTouch((event: TouchEvent) => {
            if (this.scroll2DeleteData != null && this.scroll2DeleteData != null) {
              this.scroll2DeleteData.scroller.scrollTo({ xOffset: 0, yOffset: 0,
                animation: { duration: 100, curve: Curve.Linear } })
            }
            switch (event.type) {
              case TouchType.Down:
                this.downX = event.touches[0].x
                break;
              case TouchType.Up:
                let xOffset = event.touches[0].x - this.downX
                if (xOffset == 0) {
                  return
                }
                var toxOffset = 0
                this.scroll2DeleteData = null;
                if (Math.abs(xOffset) > vp2px(this.deleteWidth) / 2 && xOffset < 0) {
                  toxOffset = vp2px(this.deleteWidth)
                  this.scroll2DeleteData = item
                }
                item.scroller.scrollTo({ xOffset: toxOffset, yOffset: 0,
                  animation: { duration: 300, curve: Curve.Linear } })
                this.downX = 0;
                break;

            }
          })
        }
        .width(CommonConstants.FULL_WIDTH)
        // .height(20)
        .onClick(() => {
          this.selectListItem(item.accountData);
          this.dialogController.open();
        })
      })
    }
    .scrollBar(BarState.Auto)
    .width(CommonConstants.FULL_WIDTH)
    .height(350)
    .borderRadius($r('app.float.radius_size_L'))
    .backgroundColor(Color.White)
    .divider({
      strokeWidth: 1,
      startMargin: 60,
      endMargin: 10,
      color: '#ffe9f0f0'
    })

    Button() {
      Image($r('app.media.ic_home_add'))
    }
    .width($r('app.float.component_size_MP'))
    .height($r('app.float.component_size_MP'))
    .position({ x: 320, y: 280 })
    .onClick(() => {
      this.isInsert = true;
      this.newAccount = {
        id: 0,
        accountType: 0,
        typeText: '',
        amount: 100,
        year: 2023,
        month: 11,
        day: 11,
        hour: 0,
        minute: 0,
        endyear: 2023,
        endmonth: 12,
        endday: 12,
        endhour: 0,
        endminute: 0,
        note: '',
        typeWhereText:''
      };
      this.dialogController.open();
    })
  }

  build() {
    Stack() {
      Column() {
        this.CustomItem()
      }
      .backgroundColor(this.bGC)
      .height(350)
      .width(CommonConstants.FULL_WIDTH)
      .margin({ top: $r('app.float.edge_size_S'), bottom: $r('app.float.edge_size_S') })
      .alignItems(HorizontalAlign.Center)
    }
  }
}


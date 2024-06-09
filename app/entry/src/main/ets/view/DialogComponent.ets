import prompt from '@ohos.promptAction';
import AccountData from '../common/database/AccountData';
import AccountItem from '../common/database/AccountItem';
import { CommonConstants } from '../common/constants/CommonConstants';
import { PayList,WhereList } from '../common/database/AccountList';
import Logger from '../common/utils/Logger';
import ProgressCardInfo from '../viewmodel/ProgressCardInfo';
import formBindingData from '@ohos.app.form.formBindingData';
import formProvider from '@ohos.app.form.formProvider';
// import formInfo from '@ohos.app.form.formInfo';
import FormInfo from '../viewmodel/FormInfo';
@Preview
@CustomDialog
export struct DialogComponent {
  controller?: CustomDialogController;
  @Link isInsert: boolean;
  @Link newAccount: AccountData;
  confirm?: (isInsert: boolean, newAccount: AccountData) => void;
  private scroller: Scroller = new Scroller();
  private inputAmount = '';
  private inputNote: String = '';
  selectedDate: Date = new Date('2023-11-11T08:00:00');
  selectedeEndDate: Date = new Date('2023-11-11T08:00:00');
  @State payList: Array<AccountItem> = PayList;
  @State WhereList: Array<AccountItem> = WhereList;
  @State bgColor: string = '';
  @State curYear: number = 2023;
  @State curMonth: number = 11;
  @State curDay: number = 11;
  @State curHour: number = 0;
  @State curMinute: number = 0;
  @State endYear: number = 2023;
  @State endMonth: number = 11;
  @State endDay: number = 11;
  @State endHour: number = 0;
  @State endMinute: number = 0;
  @State curIndex: number = 0;
  @State curType: string = '';
  @State curWhere: string = '';

  @Builder
  TabBuilder(index: number) {
    Column() {
      Text(index === 0 ? $r('app.string.pay_text') : $r('app.string.income_text'))
        .fontSize($r('app.float.font_size_M'))
        .fontColor(this.curIndex === index ? $r('app.color.main_color') : Color.Gray)
    }
    .width($r('app.float.component_size_MP'))
    .padding({ top: $r('app.float.edge_size_LM'), bottom: $r('app.float.edge_size_S') })
    .margin({ bottom: $r('app.float.edge_size_S') })
    .border(this.curIndex === index ? {
                                        width: { bottom: $r('app.float.border_size_M') },
                                        color: $r('app.color.main_color')
                                      } : { color: Color.White })
  }

  aboutToAppear() {
    this.inputAmount = this.newAccount.amount.toString();
    this.inputNote = this.newAccount.note;
    this.selectedDate.setFullYear(this.newAccount.year, this.newAccount.month, this.newAccount.day);
    this.curYear = this.newAccount.year;
    this.curMonth = this.newAccount.month;
    this.curDay = this.newAccount.day;
    this.curIndex = this.newAccount.accountType;
    this.curType = this.newAccount.typeText;
    this.curWhere = this.newAccount.typeWhereText;
  }

  selectAccount(item: AccountItem) {
    this.newAccount.accountType = item.accountType;
    this.newAccount.typeText = item.typeText;
    this.curType = item.typeText;
  }

  selectAccountwhere(item: AccountItem) {
    this.curWhere = item.typeText;
    this.newAccount.typeWhereText = item.typeText;
  }

  build() {
    Column() {
      Image($r('app.media.ic_panel_down'))
        .width($r('app.float.component_size_L'))
        .height($r('app.float.component_size_S'))
        .onClick(() => {
          this.controller?.close();
        })

      Scroll(this.scroller) {
        Row() {
          ForEach(this.payList, (item: AccountItem) => {
            Column() {
              Image(this.curType === item.typeText ? item.iconSelected : item.icon)
                .width($r('app.float.image_size'))
                .aspectRatio(1)
              Text(item.typeText)
                .fontSize($r('app.float.font_size_S'))
                .fontColor(this.curType === item.typeText ? Color.White : $r('app.color.main_color'))
                .margin({ top: $r('app.float.edge_size_S') })
            }
            .width($r('app.float.component_size_LP'))
            .aspectRatio(1)
            .padding({ top: $r('app.float.edge_size_M') })
            .margin({ top: $r('app.float.edge_size_MP'), left: $r('app.float.edge_size_M') })
            .align(Alignment.TopStart)
            .backgroundColor(this.curType === item.typeText ? $r('app.color.main_color') : $r('app.color.background_color'))
            .borderRadius($r('app.float.radius_size_S'))
            .onClick(() => {
              this.selectAccount(item);
            })
          })
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)


      //时间
      Column() {
        Text('起始时间')
          .width(CommonConstants.FULL_WIDTH)
          .fontSize($r('app.float.font_size_MP'))
          .fontColor(Color.Black)
        Column() {
          Row() {
            Text(String(String(this.curYear) + "-" + String(this.curMonth + 1) + "-" + String(this.curDay))) {
            }
            .padding({ left: CommonConstants.MINIMUM_SIZE })
            .borderRadius(CommonConstants.MINIMUM_SIZE)
            .backgroundColor(Color.White)
            .onClick(() => {
              DatePickerDialog.show({
                start: new Date("2023-8-20"),
                end: new Date("2100-12-31"),
                selected: this.selectedDate,
                onAccept: (value: DatePickerResult) => {
                  // 通过Date的setFullYear方法设置按下确定按钮时的日期，这样当弹窗再次弹出时显示选中的是上一次确定的日期
                  this.selectedDate.setFullYear(value.year, value.month, value.day)
                  this.curYear = value.year
                  this.curMonth = value.month
                  this.curDay = value.day
                  console.info("DatePickerDialog:onAccept()" + JSON.stringify(value))
                },
                onCancel: () => {
                  console.info("DatePickerDialog:onCancel()")
                },
                onChange: (value: DatePickerResult) => {
                  console.info("DatePickerDialog:onChange()" + JSON.stringify(value))
                }
              })
            })

            Text("   " + String(String(this.curHour) + ":" + String(this.curMinute))) {
            }
            .padding({ left: CommonConstants.MINIMUM_SIZE })
            .borderRadius(CommonConstants.MINIMUM_SIZE)
            .backgroundColor(Color.White)
            .onClick(() => {
              TimePickerDialog.show({
                selected: this.selectedDate,
                useMilitaryTime: true,
                onAccept: (value: TimePickerResult) => {
                  // 设置selectTime为按下确定按钮时的时间，这样当弹窗再次弹出时显示选中的为上一次确定的时间
                  this.selectedDate.setHours(value.hour, value.minute)
                  this.curHour = value.hour
                  this.curMinute = value.minute
                  console.info("TimePickerDialog:onAccept()" + JSON.stringify(value))
                },
                onCancel: () => {
                  console.info("TimePickerDialog:onCancel()")
                },
                onChange: (value: TimePickerResult) => {
                  console.info("TimePickerDialog:onChange()" + JSON.stringify(value))
                }
              })
            })
          }

        }
        .height($r('app.float.component_size_MP'))
        .padding({ top: $r('app.float.edge_size_MPM'), bottom: $r('app.float.edge_size_MM') })
        .borderWidth({ bottom: 1 })
        .borderColor($r('app.color.border_color'))
      }
      .width(CommonConstants.FULL_WIDTH)
      .padding({ left: $r('app.float.edge_size_M'), right: $r('app.float.edge_size_M') })

      Column() {
        Text('结束时间')
          .width(CommonConstants.FULL_WIDTH)
          .fontSize($r('app.float.font_size_MP'))
          .fontColor(Color.Black)
        Column() {
          Row() {
            Text(String(String(this.endYear) + "-" + String(this.endMonth + 1) + "-" + String(this.endDay))) {
            }
            .padding({ left: CommonConstants.MINIMUM_SIZE })
            .borderRadius(CommonConstants.MINIMUM_SIZE)
            .backgroundColor(Color.White)
            .onClick(() => {
              DatePickerDialog.show({
                start: new Date("2023-8-20"),
                end: new Date("2100-12-31"),
                selected: this.selectedeEndDate,
                onAccept: (value: DatePickerResult) => {
                  // 通过Date的setFullYear方法设置按下确定按钮时的日期，这样当弹窗再次弹出时显示选中的是上一次确定的日期
                  this.selectedeEndDate.setFullYear(value.year, value.month, value.day)
                  this.endYear = value.year
                  this.endMonth = value.month
                  this.endDay = value.day
                  console.info("DatePickerDialog:onAccept()" + JSON.stringify(value))
                },
                onCancel: () => {
                  console.info("DatePickerDialog:onCancel()")
                },
                onChange: (value: DatePickerResult) => {
                  console.info("DatePickerDialog:onChange()" + JSON.stringify(value))
                }
              })
            })

            Text("   " + String(String(this.endHour) + ":" + String(this.endMinute))) {
            }
            .padding({ left: CommonConstants.MINIMUM_SIZE })
            .borderRadius(CommonConstants.MINIMUM_SIZE)
            .backgroundColor(Color.White)
            .onClick(() => {
              TimePickerDialog.show({
                selected: this.selectedeEndDate,
                useMilitaryTime: true,
                onAccept: (value: TimePickerResult) => {
                  // 设置selectTime为按下确定按钮时的时间，这样当弹窗再次弹出时显示选中的为上一次确定的时间
                  this.selectedeEndDate.setHours(value.hour, value.minute)
                  this.endHour = value.hour
                  this.endMinute = value.minute
                  console.info("TimePickerDialog:onAccept()" + JSON.stringify(value))
                },
                onCancel: () => {
                  console.info("TimePickerDialog:onCancel()")
                },
                onChange: (value: TimePickerResult) => {
                  console.info("TimePickerDialog:onChange()" + JSON.stringify(value))
                }
              })
            })
          }
        }
        .height($r('app.float.component_size_MP'))
        .padding({ top: $r('app.float.edge_size_MPM'), bottom: $r('app.float.edge_size_MM') })
        .borderWidth({ bottom: 1 })
        .borderColor($r('app.color.border_color'))
      }
      .width(CommonConstants.FULL_WIDTH)
      .padding({ left: $r('app.float.edge_size_M'), right: $r('app.float.edge_size_M') })
      //地点
      Text('地点')
        .width(CommonConstants.FULL_WIDTH)
        .fontSize($r('app.float.font_size_MP'))
        .fontColor(Color.Black)
      Scroll(this.scroller) {
        Row() {
          ForEach(this.WhereList, (item: AccountItem) => {
            Column() {
              Image(this.curWhere === item.typeText ? item.iconSelected : item.icon)
                .width($r('app.float.image_size'))
                .aspectRatio(1)
              Text(item.typeText)
                .fontSize($r('app.float.font_size_S'))
                .fontColor(this.curWhere === item.typeText ? Color.White : $r('app.color.main_color'))
                .margin({ top: $r('app.float.edge_size_S') })
            }
            .width($r('app.float.component_size_LP'))
            .aspectRatio(1)
            .padding({ top: $r('app.float.edge_size_M') })
            .margin({ top: $r('app.float.edge_size_MP'), left: $r('app.float.edge_size_M') })
            .align(Alignment.TopStart)
            .backgroundColor(this.curWhere === item.typeText ? $r('app.color.main_color') : $r('app.color.background_color'))
            .borderRadius($r('app.float.radius_size_S'))
            .onClick(() => {
              this.selectAccountwhere(item);
            })
          })
        }
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
      // 备注部分
      Column() {
        Text($r('app.string.note_text'))
          .width(CommonConstants.FULL_WIDTH)
          .fontSize($r('app.float.font_size_MP'))
          .fontColor(Color.Black)

        Column() {
          TextInput({
            placeholder: $r('app.string.input_note_text'),
            text: this.newAccount.note === '' ? this.inputNote.toString() : this.newAccount.note.toString()
          })
            .padding({ left: CommonConstants.MINIMUM_SIZE })
            .borderRadius(CommonConstants.MINIMUM_SIZE)
            .backgroundColor(Color.White)
            .type(InputType.Normal)
            .onChange((value: string) => {
              this.inputNote = value;
            })
        }
        .height($r('app.float.component_size_MP'))
        .padding({ top: $r('app.float.edge_size_MPM'), bottom: $r('app.float.edge_size_MM') })
        .borderWidth({ bottom: 1 })
        .borderColor($r('app.color.border_color'))
      }
      .width(CommonConstants.FULL_WIDTH)
      .padding({ left: $r('app.float.edge_size_M'), right: $r('app.float.edge_size_M') })

      Column() {
        Button() {
          Text($r('app.string.confirm_text'))
            .fontSize($r('app.float.font_size_M'))
            .fontColor(Color.White)
        }
        .width(CommonConstants.FULL_WIDTH)
        .height($r('app.float.component_size_M'))
        .onClick(() => {
          let regex: RegExp = new RegExp('[1-9][0-9]*');
          let matchValue: Array<string> | null = this.inputAmount.match(regex);
          this.newAccount.amount = Number(this.inputAmount);
          this.newAccount.note = String(this.inputNote);
          this.newAccount.year = Number(this.selectedDate.getFullYear());
          this.newAccount.month = Number(this.selectedDate.getMonth());
          this.newAccount.day = Number(this.selectedDate.getDate());
          this.newAccount.hour = Number(this.selectedDate.getHours());
          this.newAccount.minute = Number(this.selectedDate.getMinutes());
          this.newAccount.endyear = Number(this.selectedeEndDate.getFullYear());
          this.newAccount.endmonth = Number(this.selectedeEndDate.getMonth());
          this.newAccount.endday = Number(this.selectedeEndDate.getDate());
          this.newAccount.endhour = Number(this.selectedeEndDate.getHours());
          this.newAccount.endminute = Number(this.selectedeEndDate.getMinutes());
          this.confirm && this.confirm(this.isInsert, this.newAccount);
          this.controller?.close();

        })
      }
      .layoutWeight(1)
      .padding({
        bottom: $r('app.float.font_size_L'),
        left: $r('app.float.font_size_L'),
        right: $r('app.float.font_size_L')
      })
      .justifyContent(FlexAlign.End)
    }
    .width(CommonConstants.FULL_WIDTH)
    .height(600)
    .borderRadius({ topLeft: $r('app.float.font_size_L'), topRight: $r('app.float.font_size_L') })
    .backgroundColor(Color.White)
    .align(Alignment.BottomEnd)
  }
}
let agencyStorage = new LocalStorage();

@Entry(agencyStorage)
@Component
struct WidgetCard {
  @LocalStorageProp('taskList') taskList: AgencyCardInfo[] = [];
  @LocalStorageProp('showWidget') showWidget: boolean = false;
  private iconList = {
    getup: $r('app.media.ic_task_morning'),
    drink: $r('app.media.ic_task_water'),
    apple: $r('app.media.ic_task_apple'),
    smile: $r('app.media.ic_task_smile'),
    clean: $r('app.media.ic_task_brush'),
    sleep: $r('app.media.ic_task_night')
  } as iconInfo;
  /*
   * The action type.
   */
  readonly ACTION_TYPE: string = 'router';

  /*
   * The ability name.
   */
  readonly ABILITY_NAME: string = 'EntryAbility';

  /*
   * The with percentage setting.
   */
  readonly FULL_WIDTH_PERCENT: string = '100%';

  /*
   * The height percentage setting.
   */
  readonly FULL_HEIGHT_PERCENT: string = '100%';

  /*
   * The empty image width percentage setting.
   */
  readonly EMPTY_IMAGE_WIDTH: string = '31%';

  /*
   * The agency component height percentage setting.
   */
  readonly AGENCY_COMPONENT_HEIGHT: string = '31%';

  /*
   * The empty image height percentage setting.
   */
  readonly EMPTY_IMAGE_HEIGHT: string = '51%';

  /*
   * The empty data text component margin top.
   */
  readonly TEXT_MARGIN_TOP: string = '0.5%';

  /*
   * The cross bar symbol stitching
   */
  readonly CROSS_BAR_SYMBOL: string = '--';

  /*
   * The slashes splicing.
   */
  readonly SLASHES: string = '/';

  /*
   * The target value splicing
   */
  readonly TARGET_VALUE_SPLICING: string = this.CROSS_BAR_SYMBOL + this.SLASHES;

  /**
   * The list component space.
   */
  readonly LIST_SPACE: number = 5;

  /**
   * The list component two lanes.
   */
  readonly LIST_TWO_LANES: number = 2;

  /**
   * The empty data text opacity.
   */
  readonly TEXT_OPACITY: number = 0.4;

  /**
   * The target text opacity.
   */
  readonly TARGET_TEXT_OPACITY: number = 0.6;

  /**
   * The target text weight.
   */
  readonly TARGET_TEXT_WEIGHT: number = 1;

  /**
   * The text slightly bold.
   */
  readonly TEXT_SLIGHTLY_BOLD: number = 500;

  getIconByCardTaskType(key?: string): Resource {
    let result: Resource = $r('app.string.empty');
    switch (key) {
      case '宿舍入住办理':
        result = $r('app.media.ic_side_walk');
        break;
      case '学籍注册':
        result = $r('app.media.ic_library');
        break;
      case '物资领用':
        result = $r('app.media.ic_train_station');
        break;
      case '证件办理':
        result = $r('app.media.ic_mother_child');
        break;
      case '体检':
        result = $r('app.media.ic_restaurant');
        break;
      case '领取医保卡':
        result = $r('app.media.ic_gymnasium');
        break;
      case '自定义事项':
        result = $r('app.media.ic_no_data');
        break;
      default:
        break;
    }
    return result;
  }

  build() {
    Column() {
      if (this.showWidget) {
        List({ space: this.LIST_SPACE }) {
          ForEach(this.taskList, (taskItem: AgencyCardInfo) => {
            ListItem() {
              this.AgencyComponent(taskItem)
            }
            .margin({ right: $r("app.float.agency_item_margin") })
            .borderRadius($r("app.float.agency_item_radius"))
            .backgroundColor(Color.White)
          }, (taskItem: AgencyCardInfo) => JSON.stringify(taskItem))
        }
        .padding({
          left: $r('app.float.agency_padding_left'),
          top: $r('app.float.agency_padding_top'),
          right: $r('app.float.agency_padding_right'),
          bottom: $r('app.float.agency_padding_bottom')
        })
        .lanes(this.LIST_TWO_LANES)
        .backgroundColor($r("app.color.list_background_color"))
        .width(this.FULL_WIDTH_PERCENT)
        .height(this.FULL_HEIGHT_PERCENT)
      } else {
        this.AgencyNoData()
      }
    }
  }

  @Builder AgencyNoData() {
    Column() {
      Image($r('app.media.ic_no_data'))
        .width(this.EMPTY_IMAGE_WIDTH)
        .height(this.EMPTY_IMAGE_HEIGHT)
        .objectFit(ImageFit.Contain)
      Text($r('app.string.agencyNoTask'))
        .fontSize($r('app.float.empty_data_size'))
        .fontColor(Color.White)
        .fontWeight(FontWeight.Normal)
        .opacity(this.TEXT_OPACITY)
        .margin({ top: this.TEXT_MARGIN_TOP })
    }
    .justifyContent(FlexAlign.Center)
    .width(this.FULL_WIDTH_PERCENT)
    .height(this.FULL_HEIGHT_PERCENT)
    .backgroundColor($r("app.color.no_data_background"))
    .onClick(() => {
      this.jumpToAbility();
    })
  }

  @Builder AgencyComponent(taskItem: AgencyCardInfo) {
    Row() {
      Image(this.getIconByCardTaskType(taskItem.targetValue))
        .width($r('app.float.agency_image_size'))
        .height($r('app.float.agency_image_size'))
        .objectFit(ImageFit.Contain)
      if (taskItem.dateType) {
        // Text(taskItem.isDone ? taskItem.targetValue : this.TARGET_VALUE_SPLICING + taskItem.targetValue)

        Text(taskItem.isDone ? taskItem.targetValue : this.TARGET_VALUE_SPLICING + taskItem.targetValue)
        .fontSize($r("app.float.text_common_size"))
          .fontColor($r("app.color.text_common_color"))
          .opacity(this.TARGET_TEXT_OPACITY)
          .fontWeight(FontWeight.Normal)
          .layoutWeight(this.TARGET_TEXT_WEIGHT)
          .textAlign(TextAlign.End)
      }
    }
    .padding({
      left: $r('app.float.agency_row_padding'),
      right: $r('app.float.agency_row_padding')
    })
    .width(this.FULL_WIDTH_PERCENT)
    .height(this.AGENCY_COMPONENT_HEIGHT)
    .onClick(() => {
      this.jumpToAbility();
    })
  }

  jumpToAbility() {
    postCardAction(this, {
      'action': this.ACTION_TYPE,
      'abilityName': this.ABILITY_NAME
    });
  }
}

class AgencyCardInfo {
  taskType?: string;
  targetValue?: string;
  finValue?: string;
  unit?: string;
  dateType?: boolean;
  hasTargetValue?: boolean;
  finValueIsNull?:boolean;
  isDone?: boolean;
}

interface iconInfo {
  getup: Resource;
  drink: Resource;
  apple: Resource;
  smile: Resource;
  clean: Resource;
  sleep: Resource;
}
import CommonConstantsInfo from '../../viewmodel/CommonConstantsInfo';
import relationalStore from '@ohos.data.relationalStore';
import { AccountTable } from '../database/ConstantInterface';

export class CommonConstants {
  /**
   * Component size.
   */
  static readonly SWIPER_DEFAULT_WIDTH: string = '66%';
  static readonly FULL_PERCENT: string = '100%';
  static readonly HALF_PERCENT: string = '50%';
  static readonly IMAGE_CONTAINER_HEIGHT: string = '42%';
  static readonly FULL_SIZE: string = '100%';
  static readonly ICON_SIZE: string = '40%';
  static readonly BAR_WEIGHT: string = '25%';
  static readonly BAR_HEIGHT: string = '10%';
  static readonly CONTENT_WIDTH_PERCENT: string = '87%';
  static readonly SEARCHBAR_WIDTH: string = '91.1%'
  static readonly IMAGE_HEIGHT_MIN: string = '88%';
  static readonly RDB_NAME = { dbName: 'taskInfo.db' } as CommonConstantsInfo; // db name
  static readonly DEFAULT_2: number = 2;
  static readonly DEFAULT_6: number = 6;
  static readonly DEFAULT_8: number = 8;
  static readonly DEFAULT_12: number = 12;
  static readonly DEFAULT_10: number = 10;
  static readonly DEFAULT_16: number = 16;
  static readonly DEFAULT_18: number = 18;
  static readonly DEFAULT_20: number = 20;
  static readonly DEFAULT_24: number = 24;
  static readonly DEFAULT_28: number = 28;
  static readonly DEFAULT_32: number = 32;
  static readonly DEFAULT_48: number = 48;
  static readonly DEFAULT_56: number = 56;
  static readonly DEFAULT_60: number = 60;
  static readonly DEFAULT_100: number = 100;
  static readonly DEFAULT_180: number = 180;
  /** day info table */
  static readonly DAY_INFO = {
    tableName: 'dayInfo',
    columns: ['date', 'targetTaskNum', 'finTaskNum']
  } as CommonConstantsInfo

  /** global info table */
  static readonly GLOBAL_INFO = {
    tableName: 'globalInfo',
    columns: ['id', 'firstDate', 'lastDate', 'checkInDays', 'achievements']
  } as CommonConstantsInfo

  /** task info table */
  static readonly TASK_INFO = {
    tableName: 'taskInfo',
    columns: [
      'id',
      'date',
      'taskID',
      'targetValue',
      'isAlarm',
      'startTime',
      'endTime',
      'frequency',
      'isDone',
      'finValue',
      'isOpen'
    ]
  } as CommonConstantsInfo

  /** form info table */
  static readonly FORM_INFO = {
    tableName: 'formInfo',
    columns: ['id', 'formId', 'formName', 'formDimension']
  } as CommonConstantsInfo


  static readonly AccountTable_INFO = {
    tableName: 'accountTable',
    columns: ['id', 'accountType', 'typeText', 'amount', 'year', 'month', 'day', 'hour', 'minute', 'endyear', 'endmonth', 'endday', 'endhour', 'endminute', 'note','typeWhereText']
  } as CommonConstantsInfo

  /**
   * Component location.
   */
  static readonly PERCENTAGE_78: string = '88%';
  static readonly PERCENTAGE_15: string = '15%';
  static readonly PERCENTAGE_25: string = '25%';

  /**
   * Component constants.
   */
  static readonly OPACITY: number = 0.6;
  static readonly BORDER_WIDTH: number = 0.5;
  static readonly COUNTDOWN: number = 5;

  /**
   * Time constants.
   */
  static readonly TRANSITION_DURATION: number = 600;
  static readonly DURATION: number = 1000;
  static readonly MORNING_TIME: number = 6;
  static readonly EVENING_TIME: number = 18;
  static readonly NIGHT_TIME: number = 19;
  static readonly SPLASH_DURATION: number = 3000;
  static readonly WEEK_DAY_NUM: number = 7; // number days of one week

  static readonly WEEK_DAY_TIME: number = 7 * 24 * 60 * 60 * 1000;

  // duration
  static readonly AD_DURATION: number = 5; // 5s
  static readonly LAUNCHER_DELAY_TIME: number = 2000; // 2000ms
  static readonly DURATION_1000: number = 1000; // 1000ms
  static readonly DURATION_800: number = 800; // 700ms
  static readonly DURATION_100: number = 100; // 100ms
  /**
   * Color constants.
   */
  static readonly TRANSPARENT_COLOR: string = '#00ffffff';
  static readonly NAVIGATION_BAR_COLOR: string = '#00ff00';
  static readonly STATUS_BAR_CONTENT_COLOR: string = '#ffffff';
  static readonly NAVIGATION_BAR_CONTENT_COLOR: string = '#ffffff';
  static readonly THEME_COLOR: string = '#c82424';
  // THOUSANDTH
  static readonly THOUSANDTH_15: string = '1.5%'; // ‘1.5%’
  static readonly THOUSANDTH_12: string = '2.2%'; // ‘2.2%’
  static readonly THOUSANDTH_33: string = '3.3%'; // ‘3.3%’
  static readonly THOUSANDTH_50: string = '5%'; // ‘5%’
  static readonly THOUSANDTH_66: string = '6.6%'; // ‘6.6%’
  static readonly THOUSANDTH_80: string = '8%'; // ‘8%’
  static readonly THOUSANDTH_100: string = '10%'; // ‘10%’
  static readonly THOUSANDTH_120: string = '12%'; // ‘12%’
  static readonly THOUSANDTH_160: string = '16%'; // ‘16%’
  static readonly THOUSANDTH_400: string = '40%'; // ‘40%’
  static readonly THOUSANDTH_420: string = '42%'; // ‘42%’
  static readonly THOUSANDTH_500: string = '50%'; // ‘50%’
  static readonly THOUSANDTH_560: string = '56%'; // ‘56%’
  static readonly THOUSANDTH_800: string = '80%'; // ‘80%’
  static readonly THOUSANDTH_830: string = '83%'; // ‘83%’
  static readonly THOUSANDTH_880: string = '88%'; // ‘88%’
  static readonly THOUSANDTH_900: string = '90%'; // ‘90%’
  static readonly THOUSANDTH_940: string = '94%'; // ‘90%’
  static readonly THOUSANDTH_1000: string = '100%'; // ‘100%’
  // fontWeight
  static readonly FONT_WEIGHT_400: number = 400;
  static readonly FONT_WEIGHT_500: number = 500;
  static readonly FONT_WEIGHT_700: number = 700;
  static readonly FONT_WEIGHT_900: number = 900;
  static readonly BORDER_RADIUS_PERCENT_50: string = '50%';
  static readonly HOME_BTN_Z = 2;
  // opacity
  static readonly OPACITY_4: number = 0.4;
  static readonly OPACITY_6: number = 0.6;
  /**
   * Title text.
   */
  static readonly SPLASH_DES: string = '溪流背坡村';
  static readonly SPLASH_WELCOME: string = '溪村欢迎您';
  static readonly INTRODUCTION_TITLE: string = '区域导览';
  static readonly TRAIN_TITLE: string = "小火车";
  static readonly NICK_NAME = '李宽宇';
  static readonly SIGNATURE = '移动应用开发大作业';
  /**
   * Default content in the search box.
   */
  static readonly PANEL_PLACEHOLDER: string = '图书馆';
  /**
   * Number of columns.
   */
  static readonly GRID_COLUMNS: string = '1fr 1fr 1fr 1fr 1fr';

  /**
   * The start time of the line 1.
   */
  static readonly LINE_ONE_START_TIME: string = "08:00";
  /**
   * The end time of the line 1.
   */
  static readonly LINE_ONE_END_TIME: string = "18:30";
  /**
   * The start time of the line 2.
   */
  static readonly LINE_TWO_START_TIME: string = "08:00";
  /**
   * The end time of the line 2.
   */
  static readonly LINE_TWO_END_TIME: string = "18:32";
  /**
   * The weekday start time of the line 3.
   */
  static readonly LINE_THREE_START_TIME: string = "08:00";
  /**
   * The weekday end time of the line 3.
   */
  static readonly LINE_THREE_END_TIME: string = "17:55";
  /**
   * The weekend start time of the line 3.
   */
  static readonly LINE_THREE_WEEKEND_START_TIME: string = "07:57";
  /**
   * The weekend end time of the line 3.
   */
  static readonly LINE_THREE_WEEKEND_END_TIME: string = "18:30";
  /**
   * Introduction page url.
   */
  static readonly INTRODUCTION_URL: string = 'pages/IntroductionPage';
  /**
   * The arrow url of the train.
   */
  static readonly ARROW_URL: string = "common/images/ic_train_arrow.png";
  /**
   * The url of the train.
   */
  static readonly TRAIN_URL: string = "common/images/ic_train.png";
  /**
   * The circle url of the train.
   */
  static readonly CIRCLE_URL: string = "common/images/ic_circle.png";
  /**
   * Icon subtitle array.
   */
  static readonly ICON_SUBTITLE_ARRAY: Array<string> = ['DESIGN STYLE', 'BUILDING INFORMATION', 'GEOGRAPHIC LOCATION'];
  /**
   * Geography light.
   */
  static readonly GEOGRAPHY_LIGHT: string = 'geography_light';
  /**
   * Geography dark.
   */
  static readonly GEOGRAPHY_DARK: string = 'geography_dark';
  /**
   * Building text.
   */
  static readonly BUILDING_TEXT: string = 'building';
  /**
   * Page transition exit delay.
   */
  static readonly EXIT_DELAY: number = 100;
  /**
   * Swiper transition duration.
   */
  static readonly SWIPER_DURATION: number = 300;
  /**
   * Shared transition duration.
   */
  static readonly SHARED_DURATION: number = 800;
  /**
   * Image item shadow radius.
   */
  static readonly SHADOW_RADIUS: number = 50;
  /**
   * Double number.
   */
  static readonly DOUBLE_NUM: number = 50;
  /**
   * Max scale.
   */
  static readonly MAX_SCALE: number = 4;
  /**
   * Color scale.
   */
  static readonly COLOR_SCALE_1: number = 0.8;
  /**
   * Color scale.
   */
  static readonly COLOR_SCALE_2: number = 1.0;
  /**
   * Swiper aspect ratio.
   */
  static readonly SWIPER_ASPECT_RATIO: number = 6 / 5;
  /**
   * Constant used to convert angles to radians.
   */
  static readonly RADIAN_CONSTANT: number = Math.PI / 180.0;
  /**
   * Bottom Latitude.
   */
  static readonly SOUTH_LATITUDE: number = 22.875142;
  /**
   * Top Latitude.
   */
  static readonly NORTH_LATITUDE: number = 22.885136;
  /**
   * Left Longitude.
   */
  static readonly WEST_LONGITUDE: number = 113.882035;
  /**
   * Right Longitude.
   */
  static readonly EAST_LONGITUDE: number = 113.890274;
  /**
   * Pixel width of the base map.
   */
  static readonly MAP_WIDTH: number = 2744;
  /**
   * Pixel height of the base map.
   */
  static readonly MAP_HEIGHT: number = 1826;
  /**
   * X-axis adjustment value.
   */
  static readonly X_ADJ: number = -480;
  /**
   * Y-axis adjustment value.
   */
  static readonly Y_ADJ: number = -78;
  /**
   * Quarter circle.
   */
  static readonly QUARTER_CIRCLE: number = Math.PI / 4;
  /**
   * Operation constant.
   */
  static readonly DOUBLE_OR_HALF: number = 2;
  /**
   * Number of landmarks on the map
   */
  static MAP_LANDMARKS_LENGTH: number = 10;
  /**
   * Map Zoom Ratio.
   */
  static readonly MAP_ZOOM_RATIO: number = 1.1;
  /**
   * Maximum number of magnifications.
   */
  static readonly ZOOM_MAX_TIMES: number = 4;
  /**
   * Coordinate dimension.
   */
  static readonly MAP_LANDMARKS_SIZE: number = 40;
  /**
   * Scale precision of kneading gestures.
   */
  static readonly MAP_SCALE_ACCURACY: number = 2;
  /**
   * Map font horizontal offset.
   */
  static readonly MAP_TEXT_OFFSET_X: number = 42;
  /**
   * Map font vertical offset.
   */
  static readonly MAP_TEXT_OFFSET_Y: number = 8;
  /**
   * Map Operation Finger Count.
   */
  static readonly MAP_FINGER_COUNT: number = 2;
  /**
   *  Transparency at presentation.
   */
  static readonly PANEL_HIGH_OPACITY: number = 0.8;
  /**
   * Transparency when folded.
   */
  static readonly PANEL_LOW_OPACITY: number = 0.3;
  /**
   * Height when unfolded.
   */
  static readonly PANEL_FULL_HEIGHT: number = 258;
  /**
   * Animation duration.
   */
  static readonly ANIMATION_DURATION: number = 750;
  /**
   * Normal font color opacity.
   */
  static readonly FONT_COLOR_OPACITY_NORMAL: number = 0.6;
  /**
   * Full percent number.
   */
  static readonly FULL_PERCENT_NUMBER: number = 100;
  /**
   * Image swiper cache count.
   */
  static readonly IMAGE_SWIPER_CACHE_COUNT: number = 3;
  /**
   * Animation duration normal.
   */
  static readonly ANIMATION_DURATION_NORMAL: number = 1000;
  /**
   * List position begin.
   */
  static readonly LIST_POSITION_BEGIN: number = 0;
  /**
   * List position middle.
   */
  static readonly LIST_POSITION_MIDDLE: number = 1;
  /**
   * List position end.
   */
  static readonly LIST_POSITION_END: number = 2;
  /**
   * Opacity min.
   */
  static readonly OPACITY_MIN: number = 0;
  /**
   * Opacity max.
   */
  static OPACITY_MAX: number = 1;
  /**
   * List scroll down threshold.
   */
  static readonly LIST_SCROLL_DOWN_THRESHOLD: number = -40;
  /**
   * Home icon margin top.
   */
  static readonly HOME_ICON_MARGIN_TOP: number = 80;
  /**
   * Device dpi.
   */
  static readonly DEVICE_DPI: number = 160;
  /**
   * Offset sum threshold.
   */
  static readonly OFFSET_SUM_THRESHOLD: number = 10;
  /**
   * Offset divide ratio.
   */
  static readonly OFFSET_DIVIDE_RATIO: number = 5;
  /**
   * Scroll up top threshold.
   */
  static readonly SCROLL_UP_TOP_THRESHOLD: number = -100;
  /**
   * Star icon margin.
   */
  static readonly STAR_ICON_MARGIN: number = 80;

  /**
   * Fixed item Height.
   */
  static readonly FIXED_ITEM_HEIGHT: number = 500;
  /**
   * Sticky height.
   */
  static readonly STICKY_HEIGHT: number = 229;
  /**
   * Second list item height.
   */
  static readonly SECOND_LIST_ITEM_HEIGHT: number = 350;
  /**
   * Min image height.
   */
  static readonly MIN_IMAGE_HEIGHT: number = 40;
  /**
   * Introduction image count.
   */
  static readonly INTRODUCTION_IMAGE_COUNT: number = 5;
  /**
   * Image animation duration.
   */
  static readonly IMAGE_ANIMATION_DURATION: number = 300;
  /**
   * Image divide number.
   */
  static readonly HALF_COUNT = Math.floor(CommonConstants.INTRODUCTION_IMAGE_COUNT / CommonConstants.DOUBLE_OR_HALF);
  /**
   * Image width offset.
   */
  static readonly IMAGE_WIDTH_OFFSET: number = 6.7;
  /**
   * Image x offset max.
   */
  static readonly IMAGE_X_OFFSET_MAX: number = 70;
  /**
   * Image x offset min.
   */
  static readonly IMAGE_x_OFFSET_MIN: number = 45;
  /**
   * Image opacity reduce.
   */
  static readonly IMAGE_OPACITY_REDUCE: number = 0.1;
  /**
   * Image aspect ratio.
   */
  static readonly IMAGE_ASPECT_RATIO: number = 16 / 21;
  /**
   * Image blur reduce.
   */
  static readonly IMAGE_BLUR_REDUCE: number = 10;
  /**
   * Title icon animation duration.
   */
  static readonly TITLE_ICON_ANIMATION_DURATION: number = 500;
  /**
   * The space of the train component.
   */
  static readonly TRAIN_SPACE: number = 12;
  /**
   * The aspectRatio of the train map image.
   */
  static readonly TRAIN_ASPECT_RATIO: number = 1.75;
  /**
   * The borderRadius of the train map image.
   */
  static readonly TRAIN_BORDER_RADIUS: number = 8;
  /**
   * The fontWeight of the train operation.
   */
  static readonly OPERATION_FONT_WEIGHT: number = 500;
  /**
   * The fontWeight of the train interval.
   */
  static readonly INTERVAL_FONT_WEIGHT: number = 400;
  /**
   * The padding left of the train.
   */
  static readonly TRAIN_PADDING_LEFT: number = 12;
  /**
   * The padding right of the train.
   */
  static readonly TRAIN_PADDING_RIGHT: number = 12;
  /**
   * The padding top of the train.
   */
  static readonly TRAIN_PADDING_TOP: number = 17;
  /**
   * The padding bottom of the train.
   */
  static readonly TRAIN_PADDING_BOTTOM: number = 18;
  /**
   * The aspectRatio of the canvas.
   */
  static readonly CANVAS_ASPECT_RADIO: number = 2.22;
  /**
   * The borderRadius of the canvas.
   */
  static readonly CANVAS_BORDER_RADIUS: number = 4;
  /**
   * The width of the canvas.
   */
  static readonly CANVAS_WIDTH: number = 865;
  /**
   * The height of the canvas.
   */
  static readonly CANVAS_HEIGHT: number = 494;
  /**
   * The width of the arrow.
   */
  static readonly ARROW_WIDTH: number = 28;
  /**
   * The height of the arrow.
   */
  static readonly ARROW_HEIGHT: number = 28;
  /**
   * The offset x of the arrow.
   */
  static readonly ARROW_OFFSET_X: number = 28 / 2;
  /**
   * The offset y of the arrow.
   */
  static readonly ARROW_OFFSET_Y: number = 28 / 2;
  /**
   * The width of the train.
   */
  static readonly TRAIN_WIDTH: number = 10;
  /**
   * The height of the train.
   */
  static readonly TRAIN_HEIGHT: number = 10;
  /**
   * The offset x of the train.
   */
  static readonly TRAIN_OFFSET_X: number = 5;
  /**
   * The offset y of the train.
   */
  static readonly TRAIN_OFFSET_Y: number = 5.5;
  /**
   * The width of the circle.
   */
  static readonly CIRCLE_WIDTH: number = 32;
  /**
   * The height of the circle.
   */
  static readonly CIRCLE_HEIGHT: number = 32;
  /**
   * The offset x of the circle.
   */
  static readonly CIRCLE_OFFSET_X: number = 16;
  /**
   * The offset y of the circle.
   */
  static readonly CIRCLE_OFFSET_Y: number = 16;
  /**
   * The init rotate angle of the train.
   */
  static readonly INIT_ROTATE_ANGLE: number = -115 - 90;
  /**
   * The millisecond of line 1.
   */
  static readonly LINE_ONE_TIME: number = 10 * 60 * 1000;
  /**
   * The millisecond of line 2.
   */
  static readonly LINE_TWO_TIME: number = 17 * 60 * 1000;
  /**
   * The millisecond of line 3.
   */
  static readonly LINE_THREE_TIME: number = 37 * 60 * 1000;
  /**
   * The Horizontal threshold of canvas.
   */
  static readonly HORIZONTAL_THRESHOLD: number = 20;
  /**
   * The vertical threshold of canvas.
   */
  static readonly VERTICAL_THRESHOLD: number = 10;
  /**
   * The average error of position.
   */
  static readonly AVERAGE_ERROR: number = 2;
  /**
   * The basic rotate angle of the train.
   */
  static readonly BASIC_ROTATE_ANGLE: number = -115;
  /**
   * The direction angle of the train.
   */
  static readonly DIRECTION: number = 90;
  /**
   * The PI angle of the train.
   */
  // TaskNum
  static readonly TASK_NUM = 6;
  // global data key
  static readonly GLOBAL_KEY: string = 'global';
  static readonly PI_ANGLE: number = 180;
  // RemindContent
  static readonly GET_UP_TASK_NAME: string = '早起';
  static readonly DRINK_TASK_NAME: string = '喝水';
  static readonly EAT_APPLE_TASK_NAME: string = '吃苹果';
  static readonly SMILE_TASK_NAME: string = '每日微笑';
  static readonly BRUSH_TEETH_TASK_NAME: string = '每日刷牙';
  static readonly SLEEP_TASK_NAME: string = '早睡';
  static readonly GET_UP_CONTENT: string = '该早起啦';
  static readonly DRINK_CONTENT: string = '该喝水啦';
  static readonly EAT_APPLE_CONTENT: string = '该吃苹果啦';
  static readonly SMILE_CONTENT: string = '请保持微笑';
  static readonly BRUSH_TEETH_CONTENT: string = '每日刷牙';
  static readonly SLEEP_CONTENT: string = '早睡';
  // navigation title
  static readonly ADD_TASK_TITLE: string = '添加任务';
  static readonly EDIT_TASK_TITLE: string = '编辑任务';
  // frequency Dialog
  static readonly EVERYDAY: string = '每天';
  static readonly NO_LENGTH: number = 0;
  static readonly INIT_WEEK_IDS: string = '1, 2, 3, 4, 5, 6, 7';
  // targetSetting Range
  static readonly DRINK_STEP: number = 25;
  static readonly DRINK_MAX_RANGE: number = 500;
  static readonly TIMES_50: number = 50;
  static readonly TIMES_100: number = 100;
  static readonly EAT_APPLE_RANGE: number = 100;
  static readonly LIST_ITEM_SPACE: number = 2;
  // unit
  static readonly PER_DAY: string = '/ 天';
  // time range
  static readonly DEFAULT_TIME: string = '08:00';
  static readonly GET_UP_TIME_RANGE: string = '(06:00 - 09:00)';
  static readonly SLEEP_TIME_RANGE: string = '(20:00 - 23:00)';
  static readonly GET_UP_EARLY_TIME: string = '06:00';
  static readonly GET_UP_LATE_TIME: string = '09:00';
  static readonly SLEEP_EARLY_TIME: string = '20:00';
  static readonly SLEEP_LATE_TIME: string = '23:00';
  // prompt message
  static readonly SETTING_FINISHED_MESSAGE = '设置完成！！！';
  static readonly SETTING_FINISH_FAILED_MESSAGE = '网络连接错误';
  static readonly CHOOSE_TIME_OUT_RANGE: string = '选择时间超出范围';
  // offset
  static readonly ZERO: number = 0;
  static readonly MINUS_20: number = -20;
  static readonly HAS_NO_INDEX: number = -1;
  static readonly OFFSET_24: number = -24;
  static readonly H_STORE: string = 'healthAppStore';
  static readonly REMINDER_AGENT_TAG: string = 'reminderAgent';
  static readonly PACKAGE_NAME: string = 'com.example.healthy_life';
  static readonly ENTRY_ABILITY: string = 'EntryAbility';
  // Card Constants
  static readonly TAG = "UpdateFormUtils";
  static readonly FORM_PARAM_IDENTITY_KEY = "ohos.extra.param.key.form_identity";
  static readonly FORM_PARAM_DIMENSION_KEY = "ohos.extra.param.key.form_dimension";
  static readonly FORM_PARAM_NAME_KEY = "ohos.extra.param.key.form_name";
  static readonly DEFAULT_DIMENSION_2X2 = 2;
  static readonly DEFAULT_DIMENSION_2X4 = 3;
  static readonly WIDGET_NAME_AGENCY = "agency";
  static readonly WIDGET_NAME_PROGRESS = "progress";
  /**
   * Log tag.
   */
  static readonly RDB_TAG = '[Debug.Rdb]';
  static readonly TABLE_TAG = '[Debug.AccountTable]';
  static readonly INDEX_TAG = '[Debug.Index]';
  static readonly FULL_WIDTH: string = '100%';
  static readonly FULL_HEIGHT: string = '100%';
  /**
   * toast text of prompt component.
   */
  static readonly TOAST_TEXT_1 = '账目类型不能为空';
  static readonly TOAST_TEXT_2 = '账目金额不为正整数';
  /**
   * Component size.
   */
  static readonly DIALOG_HEIGHT = '70%';
  static readonly TABS_HEIGHT = '45%';
  static readonly MINIMUM_SIZE = 0;
  static readonly PROMPT_BOTTOM = '70vp';
  static readonly LETTER_1: number = 0.1;
  static readonly LETTER_34: number = 3.4;
  // list space

  static readonly SPACE_4: number = 4;
  /**
   * Component location.
   */
  static readonly EDIT_POSITION_X = '80%';
  static readonly EDIT_POSITION_Y = '90%';
  static readonly DELETE_POSITION_X = '50%';
  static readonly DELETE_POSITION_Y = '90%';
  static readonly FILTRATE_POSITION_X = '60%';
  static readonly FILTRATE_POSITION_Y = '90%';
  static readonly ACCOUNT_TABLE: AccountTable = {
    tableName: 'accountTable',
    sqlCreate: 'CREATE TABLE IF NOT EXISTS accountTable(id INTEGER PRIMARY KEY AUTOINCREMENT, accountType INTEGER, ' +
    'typeText TEXT, amount INTEGER, year INTEGER,month INTEGER,day INTEGER,hour INTEGER,minute INTEGER,endyear INTEGER,' +
    'endmonth INTEGER,endday INTEGER,endhour INTEGER,endminute INTEGER,note TEXT,typeWhereText TEXT)',
    columns: ['id', 'accountType', 'typeText', 'amount', 'year', 'month', 'day', 'hour', 'minute', 'endyear', 'endmonth', 'endday', 'endhour', 'endminute', 'note','typeWhereText']

  };
  // rdb const
  static readonly STORE_CONFIG: relationalStore.StoreConfig = {
    name: 'database.db',
    securityLevel: relationalStore.SecurityLevel.S1
  };
}

/**
 * Train route.
 */
export enum TrainsLine {
  LINE_ONE = 0,
  LINE_TWO = 1,
  LINE_THREE = 2,
}


/**
 * Landmark type.
 */
export enum PositionType {
  TRAIN_STATION = 1,
  MOTHER_CHILD_ROOM = 2,
  CAR_ROAD = 3,
  CAFE = 4,
  SMOKING_AREA = 5,
  CONVENIENCE_STORE = 6,
  GYMNASIUM = 7,
  RESTAURANT = 8,
  SIDE_WALK = 9,
  LIBRARY = 10
}

export enum TaskType {
  Getup = 'getup',
  Drink = 'drink',
  Apple = 'apple',
  Smile = 'smile',
  Clean = 'clean',
  Sleep = 'sleep'
}

export enum Unit {
  Liter = 'L',
  Pcs = '个',
  Times = '次',
  Empty = ''
}

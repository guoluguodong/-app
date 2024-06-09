import { AddressItem, Location } from '../viewmodel/AddressItem';
import { PositionItem } from '../viewmodel/PositionItem';
import { CommonConstants as Const } from '../common/constants/CommonConstants';
import Logger from '../common/utils/Logger';
import MapController from './MapController';
import MapModel from '../viewmodel/MapModel';
import { PositionList } from '../viewmodel/MapModel';
import router from '@ohos.router';
import ZonesItem from '../viewmodel/ZonesItem';
import ZonesViewModel from '../viewmodel/ZonesViewModel';

@Preview
@Component
export struct DMap {
  private panOption: PanGestureOptions = new PanGestureOptions({ direction: PanDirection.All });
  @State screenMapWidth: number = 0;
  @State screenMapHeight: number = 0;
  @State mapWidth: number = 0;
  @State mapHeight: number = 0;
  @State mapX: number = 0;
  @State mapY: number = 0;
  @Provide data: AddressItem = new AddressItem();
  @State textValue: string = ''
  @State zoneId: number = 0
  @State inputValue: string = 'click me'
  private zonesList: ZonesItem[] = ZonesViewModel.getZonesList();
  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({
      cancel: this.onCancel,
      confirm: this.onAccept,
      zoneId: this.zoneId,
      textValue: $textValue,
      inputValue: $inputValue
    }),
    cancel: this.existApp,
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: -20 },
    gridCount: 4,
    customStyle: false
  })

  // 在自定义组件即将析构销毁时将dialogController置空
  aboutToDisappear() {
    this.dialogController = undefined // 将dialogController置空
  }

  onCancel() {
    console.info('Callback when the first button is clicked')
  }

  onAccept() {
    console.info('Callback when the second button is clicked')
  }

  existApp() {
    console.info('Click the callback in the blank area')
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Stack({ alignContent: Alignment.TopStart }) {
          ForEach(this.data.locations, (item: Location) => {
            Image(this.data.icon)
              .width(Const.MAP_LANDMARKS_SIZE)
              .height(Const.MAP_LANDMARKS_SIZE)
              .offset({
                x: item.positionX,
                y: item.positionY
              })
              .onClick(() => {
                if (this.dialogController != undefined) {
                  // for(let i=0;i<4;i++){
                    if(this.data.nameStr=='第一教学楼'){
                      this.zoneId=0;
                    }
                  if(this.data.nameStr=='综合楼'){
                    this.zoneId=1;
                  }
                  if(this.data.nameStr=='图书馆'){
                    this.zoneId=2;
                  }
                  if(this.data.nameStr== '缙湖云湖'){
                    this.zoneId=3;
                  }

                  // }

                  this.dialogController.open()
                }
              })
            Text(this.data.name)
              .fontSize($r('app.float.map_text_size'))
              .fontColor(this.data.textColor)
              .fontWeight(FontWeight.Bold)
              .offset({
                x: item.positionX + Const.MAP_TEXT_OFFSET_X,
                y: item.positionY + Const.MAP_TEXT_OFFSET_Y
              })
          }, (item: Location) => JSON.stringify(item))
        }
        .backgroundImage($r('app.media.ic_nav_map'))
        .backgroundImageSize(ImageSize.Cover)
        .width(this.mapWidth)
        .height(this.mapHeight)
        .offset({ x: this.mapX, y: this.mapY })
      }
      .height(Const.FULL_PERCENT)
      .width(Const.FULL_PERCENT)
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
      .onAreaChange((oldVal: Area, newVal: Area) => {
        if (this.screenMapWidth === 0 || this.screenMapHeight === 0) {
          this.screenMapWidth = Number(newVal.width);
          this.screenMapHeight = Number(newVal.height);
          this.mapHeight = this.screenMapHeight;
          this.mapWidth = Const.MAP_WIDTH * this.mapHeight / Const.MAP_HEIGHT;
          this.mapX = (this.screenMapWidth - this.mapWidth) / Const.DOUBLE_OR_HALF;
          MapController.initLeftTop(this.screenMapWidth, this.mapWidth);
        }
      })
      .gesture(
        GestureGroup(GestureMode.Exclusive,
          PinchGesture({ fingers: Const.MAP_FINGER_COUNT })
            .onActionUpdate((event: GestureEvent) => {
              MapController.pinchUpdate(event, (ratio: number) => {
                Logger.info(`======pinchUpdate====mapx: ${this.mapX},===mapy: ${this.mapY}`);
                this.mapWidth *= ratio;
                this.mapHeight *= ratio;
                let offsetX = (1 - ratio) * (this.screenMapWidth /
                Const.DOUBLE_OR_HALF - this.mapX);
                let offsetY = (1 - ratio) * (this.mapHeight /
                Const.MAP_ZOOM_RATIO / Const.DOUBLE_OR_HALF - this.mapY);
                this.mapX += offsetX;
                this.mapY += offsetY;
                this.data.locations = this.data.locations.map((item: Location) => {
                  item.positionX = item.oriPositionX * MapController.mapMultiples() -
                  Const.MAP_LANDMARKS_SIZE * Const.MAP_ZOOM_RATIO / Const.DOUBLE_OR_HALF;
                  item.positionY = item.oriPositionY * MapController.mapMultiples() -
                  Const.MAP_LANDMARKS_SIZE * Const.MAP_ZOOM_RATIO;
                  return item;
                })
                this.zoomOutCheck();
              });
            })
            .onActionEnd(() => {
              MapController.pinchEnd(this.screenMapWidth, this.mapWidth, this.mapHeight);
            }),
          TapGesture({ count: Const.MAP_FINGER_COUNT })
            .onAction(() => {
              MapController.tapAction((isMaxTime: boolean) => {
                if (isMaxTime) {
                  return [];
                }
                this.mapWidth *= Const.MAP_ZOOM_RATIO;
                this.mapHeight *= Const.MAP_ZOOM_RATIO;
                let offsetX = (1 - Const.MAP_ZOOM_RATIO) *
                (this.screenMapWidth / Const.DOUBLE_OR_HALF - this.mapX);
                let offsetY = (1 - Const.MAP_ZOOM_RATIO) * (this.mapHeight /
                Const.MAP_ZOOM_RATIO / Const.DOUBLE_OR_HALF - this.mapY);
                this.mapX += offsetX;
                this.mapY += offsetY;
                this.data.locations = this.data.locations.map((item: Location) => {
                  item.positionX = item.oriPositionX * MapController.mapMultiples() -
                  Const.MAP_LANDMARKS_SIZE * Const.MAP_ZOOM_RATIO / Const.DOUBLE_OR_HALF;
                  item.positionY = item.oriPositionY * MapController.mapMultiples() -
                  Const.MAP_LANDMARKS_SIZE * Const.MAP_ZOOM_RATIO;
                  return item;
                })
                // Calculate the farthest coordinate of the upper left corner.
                let minX = (this.screenMapWidth - this.mapWidth);
                let minY = this.mapHeight / MapController.mapMultiples() - this.mapHeight;
                return [minX, minY];
              });
            }),
          PanGesture(this.panOption)
            .onActionUpdate((event: GestureEvent) => {
              MapController.panUpdate(event, (mapPanX: number, mapPanY: number, leftTop: Array<number>) => {
                this.mapX += mapPanX;
                this.mapY += mapPanY;
                if (this.mapX < leftTop[0]) {
                  this.mapX = leftTop[0];
                }
                if (this.mapX > 0) {
                  this.mapX = 0;
                }
                if (this.mapY < leftTop[1]) {
                  this.mapY = leftTop[1];
                }
                if (this.mapY > 0) {
                  this.mapY = 0;
                }
              });
            })
            .onActionEnd(() => {
              MapController.panEnd();
            })
        )
      )

      CustomPanel({
        mapWidth: $mapWidth,
        mapHeight: $mapHeight,
        screenMapWidth: $screenMapWidth,
        screenMapHeight: $screenMapHeight,
        mapX: $mapX,
        mapY: $mapY,
      })
    }
  }

  zoomOutCheck(): void {
    // Top left corner.
    if (this.mapX > 0) {
      this.mapX = 0;
    }
    if (this.mapY > 0) {
      this.mapY = 0;
    }
    // Lower right corner.
    if ((this.mapX + this.mapWidth) < this.screenMapWidth) {
      this.mapX = this.screenMapWidth - this.mapWidth;
    }
    if ((this.mapY + this.mapHeight) < (this.mapHeight / MapController.mapMultiples())) {
      this.mapY = this.mapHeight / MapController.mapMultiples() - this.mapHeight;
    }
  }
}

@Component
struct PositionGridView {
  positionItem: PositionItem = new PositionItem();

  build() {
    Column() {
      Image(this.positionItem.icon)
        .width($r('app.float.navigation_panel_icon_size'))
        .height($r('app.float.navigation_panel_icon_size'))
        .margin($r('app.float.navigation_panel_icon_margin'))
      Text(this.positionItem.text)
        .fontSize($r('app.float.navigation_icon_text'))
    }
  }
}

@Component
struct CustomPanel {
  @State positionList: Array<PositionItem> = PositionList;
  @State panelOpacity: number = Const.PANEL_HIGH_OPACITY;
  @State panelHeight: number = Const.PANEL_FULL_HEIGHT;
  @State flag: boolean = true;
  @State isDownImage: boolean = true;
  @State imageEnable: boolean = true;
  @State iconOpacity: number = Const.PANEL_HIGH_OPACITY;
  @Consume data: AddressItem;
  @Link mapWidth: number;
  @Link mapHeight: number;
  @Link screenMapWidth: number;
  @Link screenMapHeight: number;
  @Link mapX: number;
  @Link mapY: number;

  build() {
    Column() {
      Column() {
        Image(this.isDownImage ? $r('app.media.ic_panel_down') : $r('app.media.ic_panel_up'))
          .enabled(this.imageEnable)
          .height($r('app.float.navigation_icon_down'))
          .onClick(() => {
            this.upAndDown();
          })
      }
      .opacity(this.iconOpacity)
      .backgroundColor($r('app.color.custom_panel_background'))
      .borderRadius({
        topLeft: $r('app.float.navigation_panel_radius'),
        topRight: $r('app.float.navigation_panel_radius')
      })
      .width(Const.FULL_PERCENT)

      Column() {
        Search({ placeholder: Const.PANEL_PLACEHOLDER })
          .width(Const.SEARCHBAR_WIDTH)
          .height($r('app.float.navigation_search_height'))
          .onSubmit((value: string) => {
            this.positionList.forEach((item: PositionItem) => {
              if (MapController.getResourceString(item.text) === value) {
                this.data = MapModel.calCoordinateByLonAndLat(item.lngLat, item.type, this.mapWidth, this.mapHeight);
                MapController.calLandmarksPosition(this.data);
                this.setFirstLandmarksCenter();
                this.upAndDown();
              }
            }, (item: PositionItem) => JSON.stringify(item));
          })
        Grid() {
          ForEach(this.positionList, (item: PositionItem) => {
            GridItem() {
              PositionGridView({ positionItem: item })
                .enabled(this.imageEnable)
                .onClick(() => {
                  this.data = MapModel.calCoordinateByLonAndLat(item.lngLat, item.type, this.mapWidth, this.mapHeight);
                  MapController.calLandmarksPosition(this.data);
                  Logger.info(`=====before setFirstLandmarksCenter=====mapx: ${this.mapX},===mapy: ${this.mapY}`);
                  this.setFirstLandmarksCenter();
                  Logger.info(`=====after setFirstLandmarksCenter=====mapx: ${this.mapX},===mapy: ${this.mapY}`);
                  this.upAndDown();
                })
            }
          }, (item: PositionItem) => JSON.stringify(item))
        }
        .columnsTemplate(Const.GRID_COLUMNS)
        .columnsGap($r('app.float.navigation_column_gap'))
        .rowsGap($r('app.float.navigation_row_gap'))
        .padding($r('app.float.navigation_grid_padding'))
      }
      .opacity(this.panelOpacity)
      .height(this.panelHeight)
      .animation({
        duration: Const.ANIMATION_DURATION,
        curve: Curve.EaseOut,
        iterations: 1,
        playMode: PlayMode.Normal
      })
      .backgroundColor($r('app.color.custom_panel_background'))
    }
    .width(Const.FULL_PERCENT)
    .borderRadius($r('app.float.navigation_panel_radius'))
  }

  upAndDown() {
    // Prevents repeated clicks during fade-down.
    this.imageEnable = false;
    if (this.isDownImage) {
      this.panelOpacity = 0;
      this.panelHeight = 0;
      this.iconOpacity = Const.PANEL_LOW_OPACITY;
    } else {
      this.panelHeight = Const.PANEL_FULL_HEIGHT;
      this.panelOpacity = Const.PANEL_HIGH_OPACITY;
      this.iconOpacity = Const.PANEL_HIGH_OPACITY;
    }
    this.isDownImage = !this.isDownImage;
    this.imageEnable = true;
  }

  setFirstLandmarksCenter(): void {
    let locations: Location[] = this.data.locations;
    if (locations.length > 0) {
      // Horizontally centered.
      this.mapX = this.screenMapWidth / Const.DOUBLE_OR_HALF - locations[0].positionX;
      if (this.mapX > 0) {
        this.mapX = 0;
      }
      if (this.mapX < (this.screenMapWidth - this.mapWidth)) {
        this.mapX = this.screenMapWidth - this.mapWidth;
      }
      // Vertically centered.
      this.mapY = this.screenMapHeight / Const.DOUBLE_OR_HALF - locations[0].positionY;
      if (this.mapY > 0) {
        this.mapY = 0;
      }
      if (this.mapY < (this.screenMapHeight - this.mapHeight)) {
        this.mapY = this.screenMapHeight - this.mapHeight;
      }
    }
  }
}

// xxx.ets
@CustomDialog
struct CustomDialogExample {
  @Link textValue: string
  @Link inputValue: string
  @Prop zoneId : number
  controller: CustomDialogController
  // 若尝试在CustomDialog中传入多个其他的Controller，以实现在CustomDialog中打开另一个或另一些CustomDialog，那么此处需要将指向自己的controller放在最后
  cancel: () => void
  confirm: () => void
  @State zoneList: ZonesItem[] = ZonesViewModel.getZonesList();
  @State introductionData: ZonesItem = ZonesViewModel.getZonesList()[0];
  /**
   * Get the introduction by currentZoneId.
   */
  aboutToAppear() {
    this.getIntroductionData();
  }
  getIntroductionData() {
    this.introductionData = this.zoneList.filter((item) => item.id === this.zoneId)[0];
  }
  build() {
    Column() {
      Text(this.introductionData.title).fontSize(20).margin({ top: 10, bottom: 10 })
      // TextInput({ placeholder: '', text: this.textValue }).height(60).width('90%')
      //   .onChange((value: string) => {
      //     this.textValue = value
      //   })
      Image(this.introductionData.swiperPic).width(300).height(150)
      Text(this.introductionData.content[0])  .textAlign(TextAlign.Center)
        .fontSize(12).border({ width: 1 }).padding(10).width('100%')
      // Text('Whether to change a text?').fontSize(16).margin({ bottom: 10 })
      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('cancel')
          .onClick(() => {
            this.controller.close()
            this.cancel()
          }).backgroundColor(0xffffff).fontColor(Color.Black)
        Button('查看详情')
          .onClick(() => {
            this.inputValue = this.textValue
            this.controller.close()
            this.confirm()
            router.pushUrl({ url: Const.INTRODUCTION_URL, params: { id: this.zoneId } });
          }).backgroundColor(0xffffff).fontColor(Color.Blue)
      }.margin({ bottom: 10 })
    }
    // dialog默认的borderRadius为24vp，如果需要使用border属性，请和borderRadius属性一起使用。
  }
}

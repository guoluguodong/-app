import { CommonConstants as Const } from '../common/constants/CommonConstants';
import { Map } from '../view/MapComponent';
import { MapComponentJS } from '../view/MapComponentJS';
import { Zones } from '../view/ZonesComponent';
import { MineIndex } from '../view/MyPage';
import { BottomTabsList } from '../viewmodel/BottomTabsModel';
import router from '@ohos.router';
import { ITaskItem } from '../model/TaskInitList';
import { GlobalContext } from '../common/utils/GlobalContext';
import GlobalInfoApi from '../common/database/tables/GlobalInfoApi';
import common from '@ohos.app.ability.common';
import notificationManager from '@ohos.notificationManager';
import GlobalInfo from '../viewmodel/GlobalInfo';
import { HomeStore } from '../viewmodel/HomeViewModel';
import HomeIndex from '../view/HomeComponent';

@Entry
@Component
struct MainPage {
  @State @Watch('onIndexChange') bottomTabIndex: number = 1;
  private controller: TabsController = new TabsController();
  @State homeStore: HomeStore = new HomeStore(new Date());
  @State editedTaskInfo: ITaskItem = router.getParams() ? (router.getParams() as Record<string, Object>).editTask as ITaskItem : {} as ITaskItem;
  @State editedTaskID: string = '0';
  private tabController: TabsController = new TabsController();
  @Builder TabBuilder(index: number, _name: string) {
    Column() {
      Image(this.bottomTabIndex === index ? BottomTabsList[index].iconSelected : BottomTabsList[index].icon)
        .width(Const.ICON_SIZE)
        .height(Const.ICON_SIZE)
        .objectFit(ImageFit.Contain)

      Text(BottomTabsList[index].text)
        .fontSize($r('app.float.bottom_font_size'))
        .opacity(Const.OPACITY)
        .fontColor(this.bottomTabIndex === index ?
        $r('app.color.bottom_tabs_font_color_selected') : $r('app.color.bottom_tabs_font_color'))
    }
    .width(Const.FULL_PERCENT)
    .height(Const.FULL_PERCENT)
    .justifyContent(FlexAlign.Center)
    .border({ width: { top: Const.BORDER_WIDTH }, color: $r('app.color.color_border') })
    .backgroundColor($r('app.color.bottom_tabs_background_color'))
  }

  onIndexChange() {
    this.controller.changeIndex(this.bottomTabIndex);
  }

  pageTransition() {
    PageTransitionEnter({ duration: Const.SHARED_DURATION })
      .slide(SlideEffect.Top)
    PageTransitionExit({ delay: Const.EXIT_DELAY })
      .opacity(0)
  }
  onPageShow() {
    let params = (router.getParams() ? router.getParams() : {}) as Record<string, Object>;
    let result = params.editTask ? params.editTask as string : '{}';
    this.editedTaskInfo = JSON.parse(result);
    this.editedTaskID = JSON.stringify(this.editedTaskInfo);
    if ((GlobalContext.getContext().getObject('isForeground') as boolean)) {
      GlobalContext.getContext().setObject('isForeground', false);
      if (this.homeStore.currentDate.getDate() !== (new Date()).getDate()) {
        GlobalContext.getContext().setObject('taskListChange', true);
        this.homeStore = new HomeStore(new Date());
      }
      this.checkCurrentTime();
    }
  }

  checkCurrentTime() {
    GlobalInfoApi.query((result: GlobalInfo) => {
      let predate = new Date(result.lastDate);
      let date = new Date();
      if (result && date.getTime() < predate.getTime()) {
        AlertDialog.show(
          {
            title: $r('app.string.alert'),
            message: $r('app.string.alert_message'),
            autoCancel: false,
            alignment: DialogAlignment.Bottom,
            offset: { dx: 0, dy: -20 },
            gridCount: 3,
            confirm: {
              value: $r('app.string.alert_button'),
              action: () => {
                (getContext(this) as common.UIAbilityContext).terminateSelf();
                console.info('Button-clicking callback');
              }
            },
            cancel: () => {
              console.info('Closed callbacks');
            }
          });
      } else {
        this.homeStore.initData();
      }
    });
  }

  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.End, justifyContent: FlexAlign.End }) {
      Tabs({ barPosition: BarPosition.End, index: 0, controller: this.controller }) {
        TabContent() {
          HomeIndex({ homeStore: $homeStore, editedTaskInfo: $editedTaskInfo })
            .borderWidth({ bottom: 1 })
            .borderColor($r('app.color.primaryBgColor'))
        }.tabBar(this.TabBuilder(0, 'MapGD'))

        TabContent() {
          Map()
        }.tabBar(this.TabBuilder(1, 'MapCS'))
        TabContent() {
          MapComponentJS()
        }.tabBar(this.TabBuilder(2, 'MapCS'))
        TabContent() {
          Zones()
        }.tabBar(this.TabBuilder(3, 'Zones'))
        TabContent() {
          MineIndex()
        }.tabBar(this.TabBuilder(4, 'Mine'))
      }
      .width(Const.FULL_PERCENT)
      .height(Const.FULL_PERCENT)
      .vertical(false)
      .scrollable(false)
      .barHeight(Const.BAR_HEIGHT)
      .onChange((index: number) => {
        this.bottomTabIndex = index;
      })
    }
    .width(Const.FULL_PERCENT)
  }
}


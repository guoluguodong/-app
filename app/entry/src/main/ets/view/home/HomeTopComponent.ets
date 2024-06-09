import { HomeStore } from '../../viewmodel/HomeViewModel';
import { WeekCalendar } from './WeekCalendarComponent';
import { CommonConstants as Const } from '../../common/constants/CommonConstants';
import HealthText from '../TextComponent';

@Extend(Text) function titleTextStyle() {
  .fontSize($r('app.float.default_16'))
  .fontWeight(Const.FONT_WEIGHT_500)
  .width(Const.THOUSANDTH_1000)
  .fontFamily($r('app.string.HarmonyHeiTi_Medium'))
  .fontColor($r(`app.element.color.titleColor`))
}

@Component
export default struct HomeTopView {
  @Link homeStore: HomeStore;

  build() {
    Column() {
      Text($r('app.string.target_progress'))
        .titleTextStyle()
          .opacity(Const.OPACITY_4)
        .fontSize(30)
        .padding({ left: $r('app.float.default_24') })
        .width(Const.THOUSANDTH_1000)
        .padding({ left: $r('app.float.default_24') })
      Text('程前启后')
        .titleTextStyle()
          .opacity(Const.OPACITY_6)
        .fontSize(30)
        .fontColor(Color.Blue)
        .padding({ left: $r('app.float.default_24') })
      Text('   计往开来')
        .titleTextStyle()
          .opacity(Const.OPACITY_6)
        .fontColor(Color.Blue)
        .fontSize(30)
        .padding({ left: $r('app.float.default_24') })
      WeekCalendar({ homeStore: $homeStore })
    }
    .height(Const.THOUSANDTH_500)
    .backgroundImagePosition({ x: 0, y: 0 })
    .backgroundImage($r('app.media.ic_home_bg'))
    .backgroundImageSize({ width: Const.THOUSANDTH_1000, height: Const.THOUSANDTH_900 })
    .justifyContent(FlexAlign.End)
  }
}
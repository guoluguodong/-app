
import { CommonConstants as Const } from '../common/constants/CommonConstants';

@Observed
export class AnimationItem {
  screenHeight: number = 0;
  offsetSum: number = 0;
  scrollerForList: Scroller = new Scroller();
  arrowIconOpacity: number = Const.OPACITY_MAX;
  imageHeight: number = Const.FULL_PERCENT_NUMBER;
  listPosition: number = Const.LIST_POSITION_BEGIN;
  geographicPicType: string = Const.GEOGRAPHY_LIGHT;
  currentListIndex: number = Const.LIST_POSITION_BEGIN;
  iconTitle: string = Const.ICON_SUBTITLE_ARRAY[0];
  scaleIcon: Array<number> = [Const.OPACITY_MAX, Const.OPACITY_MIN, Const.OPACITY_MIN];
}
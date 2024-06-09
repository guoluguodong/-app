/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import display from '@ohos.display';
import WeekCalendarMethods, { ScrollTo } from '../../viewmodel/CalendarViewModel';
import { HomeStore } from '../../viewmodel/HomeViewModel';
import HealthText from '../TextComponent';
import { WeekDateModel } from '../../model/WeekCalendarModel';
import { sameDate } from '../../common/utils/Utils';
import { CommonConstants as Const } from '../../common/constants/CommonConstants';
import Logger from '../../common/utils/Logger';

export const WEEK_DAY_WIDTH: number = 100 / Const.WEEK_DAY_NUM;

const DEFAULT_SCROLL_WIDTH = 336; // default calendar width
const DEFAULT_SCROLL_PERCENT = 0.934; // default calendar width percent

@Component
export struct WeekCalendar {
  @Link homeStore: HomeStore;
  currentPage: number = 1;
  private scroller: Scroller = new Scroller();
  scrollWidth: number = DEFAULT_SCROLL_WIDTH;
  private isLoadMore: boolean = false;
  private isPageScroll: boolean = false;

  aboutToAppear() {
    try {
      let displayClass = display.getDefaultDisplaySync();
      this.scrollWidth = displayClass.width / displayClass.densityPixels * DEFAULT_SCROLL_PERCENT;
      Logger.info('HomeIndex', 'get the window scrollWidth: ' + this.scrollWidth);
    } catch (err) {
      Logger.error('HomeIndex->onScrollEnd', JSON.stringify(err));
    }
    this.homeStore.setSelectedShowDate(new Date().getTime());
  }

  getProgressImg(item: WeekDateModel): Resource {
    let finNum = item.dayInfo?.finTaskNum || 0;
    if (finNum === 0) {
      return $r('app.media.ic_home_undone');
    }
    if (finNum === (item.dayInfo?.targetTaskNum || 0)) {
      return $r('app.media.ic_home_all_done');
    }
    return $r('app.media.ic_home_half_done');
  }

  build() {
    Row() {
      Column() {
        Row() {
          // this.ArrowIcon(false)
          HealthText({ title: this.homeStore.dateTitle, fontSize: $r('app.float.default_14') })
            .margin($r('app.float.default_56'))
          // this.ArrowIcon(true)
        }
        .justifyContent(FlexAlign.Center)

      }
      .borderRadius($r('app.float.default_24'))
      .backgroundColor($r('app.color.white'))
      .width(Const.THOUSANDTH_1000)
      .height(Const.THOUSANDTH_1000)
      .padding({ top: Const.THOUSANDTH_50, bottom: Const.THOUSANDTH_120 })

    }
    .width(Const.THOUSANDTH_1000)
    .height(Const.THOUSANDTH_420)
    .padding(Const.THOUSANDTH_33)
  }

}
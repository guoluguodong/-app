

import ZonesItem from './ZonesItem';

class ZonesViewModel {
  getZonesList(): ZonesItem[] {
    return defaultList;
  }

  getZonesByIndex(index: number): ZonesItem {
    return defaultList[index];
  }
}

let zonesViewModel = new ZonesViewModel();

export default zonesViewModel as ZonesViewModel;

const defaultList: ZonesItem[] = [
  {
    id: 0,
    title: $r('app.string.area_name_a'),
    subTitle: $r('app.string.area_sub_name_a'),
    thumbnail: $r('app.media.ic_thumbnail_a'),
    swiperPic: $r('app.media.ic_A'),
    createTime: $r('app.string.create_year_2015'),
    content: [$r('app.string.introduction_paragraph_first_a'),
    $r('app.string.introduction_paragraph_second_a')],
    subPicTop: $r('app.media.ic_A_photo_top'),
    subPicBottom: $r('app.media.ic_A_photo_bottom'),
    titleIcon: $r('app.media.ic_title_top_A'),
    imageList: [$r('app.media.ic_A_1'), $r('app.media.ic_A_2'), $r('app.media.ic_A_3'), $r('app.media.ic_A_4'),
    $r('app.media.ic_A_5')],
    buildingInformation: $r('app.string.build_information_a'),
    buildingPic: $r("app.media.ic_building_A"),
    geographyPic: $r("app.media.ic_geography_dark_A"),
    geographyPicLight: $r("app.media.ic_geography_lighter_A"),
    backgroundColor: $r('app.color.introduction_page_green'),
    starLinePic: [$r("app.media.ic_starLine_A_light"), $r("app.media.ic_starLine_A_dark")]
  },
  {
    id: 1,
    title: $r('app.string.area_name_b'),
    subTitle: $r('app.string.area_sub_name_b'),
    thumbnail: $r('app.media.ic_thumbnail_b'),
    swiperPic: $r('app.media.ic_B'),
    createTime: $r('app.string.create_year_2015'),
    content: [$r('app.string.introduction_paragraph_first_b'),
    $r('app.string.introduction_paragraph_second_b')],
    subPicTop: $r("app.media.ic_B_photo_top"),
    subPicBottom: $r("app.media.ic_B_photo_bottom"),
    titleIcon: $r('app.media.ic_title_top_B'),
    imageList: [$r('app.media.ic_B_1'), $r('app.media.ic_B_2'), $r('app.media.ic_B_3'), $r('app.media.ic_B_4'),
    $r('app.media.ic_B_5')],
    buildingInformation: $r('app.string.build_information_b'),
    buildingPic: $r('app.media.ic_building_B'),
    geographyPic: $r("app.media.ic_geography_dark_B"),
    geographyPicLight: $r("app.media.ic_geography_lighter_B"),
    backgroundColor: $r('app.color.introduction_b_page_blue'),
    starLinePic: [$r("app.media.ic_starLine_B_light"), $r("app.media.ic_starLine_B_dark")]
  },
  {
    id: 2,
    title: $r('app.string.area_name_c'),
    subTitle: $r('app.string.area_sub_name_c'),
    thumbnail: $r('app.media.ic_thumbnail_c'),
    swiperPic: $r("app.media.ic_C"),
    createTime: $r('app.string.create_year_2015'),
    content: [$r('app.string.introduction_paragraph_first_c'),
    $r('app.string.introduction_paragraph_second_c')],
    subPicTop: $r("app.media.ic_C_photo_top"),
    subPicBottom: $r("app.media.ic_C_photo_bottom"),
    titleIcon: $r('app.media.ic_title_top_C'),
    imageList: [$r('app.media.ic_C_1'), $r('app.media.ic_C_2'), $r('app.media.ic_C_3'), $r('app.media.ic_C_4'),
    $r('app.media.ic_C_5')],
    buildingInformation: $r('app.string.build_information_c'),
    buildingPic: $r('app.media.ic_building_C'),
    geographyPic: $r("app.media.ic_geography_dark_C"),
    geographyPicLight: $r("app.media.ic_geography_lighter_C"),
    backgroundColor: $r('app.color.introduction_c_page_blue'),
    starLinePic: [$r("app.media.ic_starLine_C_light"), $r("app.media.ic_starLine_C_dark")]
  },
  {
    id: 3,
    title: $r('app.string.area_name_d'),
    subTitle: $r('app.string.area_sub_name_d'),
    thumbnail: $r('app.media.ic_thumbnail_d'),
    swiperPic: $r("app.media.ic_D"),
    createTime: $r('app.string.create_year_2015'),
    content: [$r('app.string.introduction_paragraph_first_d'),
    $r('app.string.introduction_paragraph_second_d')],
    subPicTop: $r("app.media.ic_D_photo_top"),
    subPicBottom: $r("app.media.ic_D_photo_bottom"),
    titleIcon: $r('app.media.ic_title_top_D'),
    imageList: [$r('app.media.ic_D_1'), $r('app.media.ic_D_2'), $r('app.media.ic_D_3'), $r('app.media.ic_D_4'),
    $r('app.media.ic_D_5')],
    buildingInformation: $r('app.string.build_information_d'),
    buildingPic: $r('app.media.ic_building_D'),
    geographyPic: $r("app.media.ic_geography_dark_D"),
    geographyPicLight: $r("app.media.ic_geography_lighter_D"),
    backgroundColor: $r('app.color.introduction_d_page_blue'),
    starLinePic: [$r("app.media.ic_starLine_D_light"), $r("app.media.ic_starLine_D_dark")]
  },

]
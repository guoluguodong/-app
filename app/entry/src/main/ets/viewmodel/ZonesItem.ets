
export default class ZonesItem {
  id: number = 0;
  title: ResourceStr = $r('app.string.area_name_a');
  subTitle: ResourceStr = $r('app.string.area_sub_name_a');
  createTime: ResourceStr = $r('app.string.create_year_2015');
  content: ResourceStr[] = [];
  thumbnail: ResourceStr = $r('app.media.ic_thumbnail_a');
  swiperPic: ResourceStr = $r('app.media.ic_A');
  subPicTop: ResourceStr = $r('app.media.ic_A_photo_top');
  subPicBottom: ResourceStr = $r('app.media.ic_A_photo_bottom');
  titleIcon: ResourceStr = $r('app.media.ic_title_top_A');
  imageList: ResourceStr[] = [];
  buildingInformation: ResourceStr = $r('app.string.build_information_a');
  buildingPic: ResourceStr = $r('app.media.ic_building_A');
  geographyPic: ResourceStr = $r('app.media.ic_geography_dark_A');
  geographyPicLight: ResourceStr = $r('app.media.ic_geography_lighter_A');
  backgroundColor: ResourceStr = $r('app.color.introduction_page_green');
  starLinePic: ResourceStr[] = [];
}
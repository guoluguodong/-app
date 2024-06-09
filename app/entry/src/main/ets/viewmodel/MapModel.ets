import { AddressItem, Location } from './AddressItem';
import { PositionItem, GeoCoordinates } from './PositionItem';
import { CommonConstants as Const, PositionType } from '../common/constants/CommonConstants';
import { Geography } from '../common/utils/Geography';
import MapController from '../view/MapController';


export class MapModel {
  private data?: AddressItem;
  private addressArray: Array<AddressItem> = new Array(Const.MAP_LANDMARKS_LENGTH).fill(undefined);


  calCoordinateByLonAndLat(geoCoordinates: Array<GeoCoordinates>, type: number, mapWidth: number, mapHeight: number): AddressItem {
    this.data = undefined;
    if (!this.addressArray[type - 1]) {
      let addressItem = new AddressItem();
      addressItem.name = mapLandmarksName[type-1];
      addressItem.icon = mapLandmarksIcon[type - 1];
      addressItem.nameStr = mapLandmarksNameStr[type-1];
      addressItem.locations = this.initLocationData(geoCoordinates, mapWidth, mapHeight);
      addressItem.textColor = mapLandmarksTextColor[type - 1];
      this.addressArray[type - 1] = addressItem;
    }
    this.data = this.addressArray[type - 1];
    return this.data;
  }

  /**
   * Initialize the coordinates of landmarks on the map.
   *
   * @param geoCoordinates Longitude and latitude data.
   * @returns Coordinates of landmarks on the map.
   */
  initLocationData(geoCoordinates: Array<GeoCoordinates>, mapWidth: number, mapHeight: number): Array<Location> {
    let locations: Array<Location> = [];
    geoCoordinates.forEach((item: GeoCoordinates) => {
      let pixelCoordinates = Geography.toPixelCoordinates(item.latitude, item.longitude);
      let positionX = pixelCoordinates.coordinateX * mapWidth / MapController.mapMultiples() / Const.MAP_WIDTH;
      let positionY = pixelCoordinates.coordinateY / Const.MAP_HEIGHT * mapHeight / MapController.mapMultiples();
      locations.push(new Location(positionX, positionY));
    })
    return locations;
  }
}

let mapModel = new MapModel();

export default mapModel as MapModel;

export const PositionList: Array<PositionItem> = [
  {
    icon: $r('app.media.ic_train_station'),
    text: $r('app.string.library'),
    type: PositionType.TRAIN_STATION,
    lngLat: [
      {
        longitude:113.887654,
        latitude: 22.877413
      }
    ]
  },
  {
    icon: $r('app.media.ic_mother_child'),
    text: $r('app.string.first_teaching_building'),
    type: PositionType.MOTHER_CHILD_ROOM,
    lngLat: [
      {
        longitude:113.888914,
        latitude: 22.878160
      }
    ]
  },
  {
    icon: $r('app.media.ic_car_road'),
    text: $r('app.string.comprehensive_building'),
    type: PositionType.CAR_ROAD,
    lngLat: [
      {
        longitude:113.889614,
        latitude: 22.877543
      }
    ]
  },
  {
    icon: $r('app.media.ic_cafe'),
    text: $r('app.string.lake'),
    type: PositionType.CAFE,
    lngLat: [
      {
        longitude:113.888614,
        latitude: 22.877543
      },
      {
        longitude:113.887214,
        latitude: 22.878543
      },
    ]
  },
  {
    icon: $r('app.media.ic_smoking_area'),
    text: $r('app.string.backetball_playground'),
    type: PositionType.SMOKING_AREA,
    lngLat: [
      {
        longitude:113.889614,
        latitude: 22.879043
      }
    ]
  },
  {
    icon: $r('app.media.ic_convenience_store'),
    text: $r('app.string.likelou'),
    type: PositionType.CONVENIENCE_STORE,
    lngLat: [
      {
        longitude:113.885614,
        latitude: 22.878543
      }
    ]
  },
  {
    icon: $r('app.media.ic_gymnasium'),
    text: $r('app.string.playground'),
    type: PositionType.GYMNASIUM,
    lngLat: [
      {
        longitude:113.890400,
        latitude: 22.878643
      }
    ]
  },
  {
    icon: $r('app.media.ic_restaurant'),
    text: $r('app.string.restaurant'),
    type: PositionType.RESTAURANT,
    lngLat: [
      {
        longitude: 113.888400,
        latitude: 22.880450
      },
      {
        longitude: 113.887000,
        latitude: 22.881000
      },
      {
        longitude:113.884800,
        latitude: 22.877000
      }
    ]
  },
  {
    icon: $r('app.media.ic_side_walk'),
    text: $r('app.string.dormitory'),
    type: PositionType.SIDE_WALK,
    lngLat: [
      {
        longitude: 113.888000,
        latitude: 22.880850
      }
    ]
  },
  {
    icon: $r('app.media.ic_library'),
    text: $r('app.string.north_gate'),
    type: PositionType.LIBRARY,
    lngLat: [
      {
        longitude:113.889900,
        latitude: 22.880000
      }
    ]
  }
]

const mapLandmarksName: Array<Resource> = [
$r('app.string.library'),
$r('app.string.first_teaching_building'),
$r('app.string.comprehensive_building'),
$r('app.string.lake'),
$r('app.string.backetball_playground'),
$r('app.string.likelou'),
$r('app.string.playground'),
$r('app.string.restaurant'),
$r('app.string.dormitory'),
$r('app.string.north_gate')
]
const mapLandmarksNameStr: Array<string> = [
'图书馆',
  '第一教学楼',
'第一实验楼',
'缙湖云湖',
'篮球场',
'理科楼',
  '操场',
  '食堂',
  '宿舍',
  '北门'
]
const mapLandmarksTextColor: Array<Resource> = [
$r('app.color.train_station_color'),
$r('app.color.mother_child_room_color'),
$r('app.color.car_road_color'),
$r('app.color.cafe_color'),
$r('app.color.smoking_area_color'),
$r('app.color.convenience_store_color'),
$r('app.color.gymnasium_color'),
$r('app.color.restaurant_color'),
$r('app.color.side_walk_color'),
$r('app.color.library_color')
]

const mapLandmarksIcon: Array<Resource> = [
$r('app.media.ic_location_train'),
$r('app.media.ic_location_train'),
$r('app.media.ic_location_train'),
$r('app.media.ic_location_train'),
$r('app.media.ic_location_train'),
$r('app.media.ic_location_train'),
$r('app.media.ic_location_train'),
$r('app.media.ic_location_train'),
$r('app.media.ic_location_train'),
$r('app.media.ic_location_train')
];
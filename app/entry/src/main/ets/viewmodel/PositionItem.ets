
import { PositionType } from '../common/constants/CommonConstants';

/**
 * Landmark location data.
 */
export class PositionItem {
  icon: Resource = $r('app.media.ic_train_station');
  text: Resource = $r('app.string.library');

  /**
   * Facility Category.
   */
  type: PositionType = PositionType.TRAIN_STATION;

  /**
   * Facility Point Coordinates.
   */
  lngLat: Array<GeoCoordinates> = [];
}

/**
 * Geographical coordinates, longitude and latitude.
 */
export class GeoCoordinates {
  longitude: number = 0;
  latitude: number = 0;
}

/**
 * PixelCoordinates.
 */
export class PixelCoordinates{
  coordinateX: number = 0;
  coordinateY: number = 0;
}
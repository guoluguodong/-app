

import display from '@ohos.display';
import window from '@ohos.window';
import { CommonConstants as Const } from '../constants/CommonConstants';

export class DeviceScreen {
  /**
   * Get the device size.
   *
   * @returns promise of window.
   */
  public static getDeviceSize(context: Context): Promise<window.Window> {
    return window.getLastWindow(context);
  }

  /**
   * Get the screen height.
   *
   * @returns screen height.
   */
  public static getDeviceHeight(): number {
    let displayObject = display.getDefaultDisplaySync();
    let screenPixelHeight = displayObject.height;
    let screenDensityDPI = displayObject.densityDPI;
    return screenPixelHeight * (Const.DEVICE_DPI / screenDensityDPI);
  }
}
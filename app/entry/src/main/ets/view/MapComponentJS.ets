import web_webview from '@ohos.web.webview'

web_webview.once("webInited", () => {
  console.log("setCookie")
  web_webview.WebCookieManager.setCookie("https://map.baidu.com/@11837574.16400545,3429243.1373088,15z", "a=b")
})
@Preview
@Component
export struct MapComponentJS {
  controller: web_webview.WebviewController = new web_webview.WebviewController();
  build() {
    Column() {
      Web({ src: 'https://map.baidu.com/@11837574.16400545,3429243.1373088,15z', controller: this.controller })
    }
  }
}
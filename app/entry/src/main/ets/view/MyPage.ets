import { ListInfo } from './ListInfo';
import { UserBaseInfo } from './UserBaseInfo';
import { CommonConstants as Const } from '../common/constants/CommonConstants';

@Component
export struct MineIndex {
  @State nickname: string = Const.NICK_NAME;
  @State signature: string = Const.SIGNATURE;
  @State videoSrc: Resource = $rawfile('aaaa.mp4')
  @State previewUri: Resource = $r('app.media.ic_A')
  @State curRate: PlaybackSpeed = PlaybackSpeed.Speed_Forward_1_00_X
  @State isAutoPlay: boolean = false
  @State showControls: boolean = true
  controller: VideoController = new VideoController()
  @State viedoNum: number = 0;

  build() {
    Column() {
      UserBaseInfo({
        nickname: this.nickname,
        signature: this.signature
      });
      ListInfo();
      if(this.viedoNum==0) {
        Text('重庆大学宣传片')
          .fontSize($r('app.float.default_28'))
          .fontWeight(FontWeight.Bolder)
          .fontColor($r('app.color.leveColor'))
      }
      else {
        Text('重庆大学校歌')
          .fontSize($r('app.float.default_28'))
          .fontWeight(FontWeight.Bolder)
          .fontColor($r('app.color.leveColor'))
      }
      Video({
        src: this.videoSrc,
        previewUri: this.previewUri,
        currentProgressRate: this.curRate,
        controller: this.controller
      })
        .width('90%')
        .height(210)
        .autoPlay(this.isAutoPlay)
        .controls(this.showControls)
        .onStart(() => {
          console.info('onStart')
        })
        .onPause(() => {
          console.info('onPause')
        })
        .onFinish(() => {.0
          console.info('onFinish')
        })
        .onError(() => {
          console.info('onError')
        })
        .onPrepared((e) => {
          console.info('onPrepared is ' + e.duration)
        })
        .onSeeking((e) => {
          console.info('onSeeking is ' + e.time)
        })
        .onSeeked((e) => {
          console.info('onSeeked is ' + e.time)
        })
        .onUpdate((e) => {
          console.info('onUpdate is ' + e.time)
        })
      Row() {
        Button('下一条视频').onClick(() => {
          if (this.viedoNum == 0) {
            this.videoSrc = $rawfile('bbbb.mp4') // 切换视频源
            this.previewUri = $r('app.media.ic_B')
            this.viedoNum = 1;
          }
          else {
            this.videoSrc = $rawfile('aaaa.mp4') // 切换视频源
            this.previewUri = $r('app.media.ic_A')
            this.viedoNum = 0;
          }
        }).margin(5).width(120).backgroundColor(Color.White).fontColor(Color.Black)
        Button('显示控制栏').onClick(() => {
          this.showControls = !this.showControls // 切换是否显示视频控制栏
        }).margin(5).width(120).backgroundColor(Color.White).fontColor(Color.Black)
      }
    }
    .height(Const.FULL_PERCENT)
    .backgroundColor(Color.White)
  }
}
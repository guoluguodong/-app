import AccountItem from './AccountItem';

export const PayList: Array<AccountItem> = [
  {
    icon: $r('app.media.ic_side_walk'),
    iconSelected: $r('app.media.ic_side_walk'),
    accountType: 0,
    typeText: '宿舍入住办理'
  },
  {
    icon: $r('app.media.ic_library'),
    iconSelected: $r('app.media.ic_library'),
    accountType: 0,
    typeText: '学籍注册'
  },
  {
    icon: $r('app.media.ic_train_station'),
    iconSelected: $r('app.media.ic_train_station'),
    accountType: 0,
    typeText: '物资领用'
  },
  {
    icon: $r('app.media.ic_mother_child'),
    iconSelected: $r('app.media.ic_mother_child'),
    accountType: 0,
    typeText: '证件办理'
  },
  {
    icon: $r('app.media.ic_restaurant'),
    iconSelected: $r('app.media.ic_restaurant'),
    accountType: 0,
    typeText: '体检'
  },
  {
    icon: $r('app.media.ic_gymnasium'),
    iconSelected: $r('app.media.ic_gymnasium'),
    accountType: 0,
    typeText: '领取医保卡'
  },
  {
    icon: $r('app.media.ic_no_data'),
    iconSelected: $r('app.media.ic_no_data'),
    accountType: 0,
    typeText: '自定义事项'
  }
]


export const ImageList: Record<string,Resource> = {
  '宿舍入住办理':$r('app.media.ic_side_walk'),
  '学籍注册': $r('app.media.ic_library'),
  '物资领用': $r('app.media.ic_train_station'),
  '证件办理': $r('app.media.ic_mother_child'),
  '体检': $r('app.media.ic_restaurant'),
  '领取医保卡': $r('app.media.ic_gymnasium'),
  '自定义事项': $r('app.media.ic_no_data')
}

export const WhereList: Array<AccountItem> = [
  {
    icon:  $r('app.media.ic_train_station'),
    iconSelected: $r('app.media.ic_train_station'),
    accountType: 0,
    typeText: '图书馆'
  },
  {
    icon:  $r('app.media.ic_mother_child'),
    iconSelected:  $r('app.media.ic_mother_child'),
    accountType: 0,
    typeText: '第一教学楼'
  },
  {
    icon:  $r('app.media.ic_car_road'),
    iconSelected:  $r('app.media.ic_car_road'),
    accountType: 0,
    typeText: '第一实验楼'
  },
  {
    icon:   $r('app.media.ic_cafe'),
    iconSelected:  $r('app.media.ic_cafe'),
    accountType: 0,
    typeText: '缙湖云湖'
  },
  {
    icon:  $r('app.media.ic_smoking_area'),
    iconSelected:  $r('app.media.ic_smoking_area'),
    accountType: 0,
    typeText: '篮球场'
  },
  {
    icon:  $r('app.media.ic_convenience_store'),
    iconSelected: $r('app.media.ic_convenience_store'),
    accountType: 0,
    typeText: '理科楼'
  },
  {
    icon:  $r('app.media.ic_gymnasium'),
    iconSelected: $r('app.media.ic_gymnasium'),
    accountType: 0,
    typeText: '操场'
  },
  {
    icon: $r('app.media.ic_restaurant'),
    iconSelected: $r('app.media.ic_restaurant'),
    accountType: 0,
    typeText: '食堂'
  },
  {
    icon:  $r('app.media.ic_gymnasium'),
    iconSelected: $r('app.media.ic_gymnasium'),
    accountType: 0,
    typeText: '宿舍'
  },
  {
    icon:  $r('app.media.ic_library'),
    iconSelected:$r('app.media.ic_library'),
    accountType: 0,
    typeText: '北门'
  },

]
export const ImageListwhere: Record<string,Resource> = {
  '图书馆': $r('app.media.ic_train_station'),
  '第一教学楼': $r('app.media.ic_mother_child'),
  '第一实验楼': $r('app.media.ic_car_road'),
  '缙湖云湖': $r('app.media.ic_cafe'),
  '篮球场': $r('app.media.ic_smoking_area'),
  '理科楼': $r('app.media.ic_convenience_store'),
  '操场': $r('app.media.ic_gymnasium'),
  '食堂': $r('app.media.ic_restaurant'),
  '宿舍':$r('app.media.ic_side_walk'),
  '北门':$r('app.media.ic_library')
}

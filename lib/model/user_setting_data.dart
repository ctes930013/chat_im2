/*
* 创建者：eric
* 個人中心列表的資料
* */
class UserSettingData {
  String img;   //圖片位置
  String title;   //標題
  Function? onClick;    //點擊事件

  UserSettingData({ required this.img, required this.title, this.onClick});
}
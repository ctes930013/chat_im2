class ChatListData {
  late int id;
  late String imgUrl; //大頭貼圖片網址
  late String name; //用戶暱稱
  late String finalMsg; //最後一筆對話訊息
  late String time; //建立時間
  late bool isTop; //是否置頂
  late bool isOnline; //是否在線
  late int unReadNum; //未讀訊息數量

  ChatListData(
    this.id,
    this.imgUrl,
    this.name,
    this.finalMsg,
    this.time, {
    this.isTop = false,
    this.isOnline = false,
    this.unReadNum = 0,
  });

  //設置是否置頂
  setIsTop(bool isTop) {
    this.isTop = isTop;
  }
}

class ChatRoomData {
  late int id;
  late int userId;
  late String imgUrl; //大頭貼圖片網址
  late String name; //用戶暱稱
  late String msg; //對話訊息
  late String time; //建立時間
  ChatRoomData(
    this.id,
    this.userId,
    this.imgUrl,
    this.name,
    this.msg,
    this.time,
  );
}

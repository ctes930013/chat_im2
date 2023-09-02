import 'package:chat_im/model/chat_room_data.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/*
* 创建者：eric
* 聊天室房間的view model
* */
class ChatRoomViewModel extends ChangeNotifier {
  //聊天列表
  List<ChatRoomData> chatList = [];

  //下拉刷新的控制器
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  RefreshController get refreshController => _refreshController;
  set refreshController(RefreshController i) {
    _refreshController = i;
  }

  init() {
    final List<ChatRoomData> items = [
      ChatRoomData(
        0,
        1,
        "https://pic4.zhimg.com/v2-19dced236bdff0c47a6b7ac23ad1fbc3.jpg",
        "柠檬精",
        "是的，我觉得你非常好看我觉得你非常好看我觉得你非常好看",
        "05:32 PM",
      ),
      ChatRoomData(
        1,
        2,
        "https://pic4.zhimg.com/v2-19dced236bdff0c47a6b7ac23ad1fbc3.jpg",
        "屁精",
        "你\n王八蛋",
        "02:51 AM",
      ),
      ChatRoomData(
        2,
        2,
        "https://pic4.zhimg.com/v2-19dced236bdff0c47a6b7ac23ad1fbc3.jpg",
        "屁精",
        "是的，我觉得你真的很會放屁你真的很會放屁你真的很會放屁",
        "07:04 AM",
      ),
    ];
    chatList.addAll(items);
    notifyListeners();
  }

  @override
  void dispose() {
    removeAll();
    super.dispose();
  }

  //取得所有資料
  List<ChatRoomData> getData() {
    return chatList;
  }

  //根據id取得資料
  ChatRoomData? getDataById(int id) {
    ChatRoomData? chatData;
    for (var element in getData()) {
      if (element.id == id) {
        chatData = element;
        break;
      }
    }
    return chatData;
  }

  //新增一筆資料
  void addData(ChatRoomData data) {
    chatList.insert(0, data);
    notifyListeners();
  }

  //加載下一筆資料
  loadMore() async {
    await Future.delayed(const Duration(seconds: 2));
    refreshController.loadComplete();
    notifyListeners();
  }

  //移除所有資料
  removeAll() {
    chatList.clear();
  }
}

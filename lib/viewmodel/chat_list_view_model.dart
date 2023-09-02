import 'package:chat_im/model/chat_list_data.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/*
* 创建者：eric
* 聊天室長列表的view model
* */
class ChatListViewModel extends ChangeNotifier {
  //所有聊天室列表
  List<ChatListData> chatList = [];
  //搜尋聊天室列表
  List<ChatListData> searchChatList = [];
  //紀錄當前是否為搜尋模式
  bool isSearchMode = false;
  //紀錄用戶搜尋的文字
  String searchKey = "";

  //下拉刷新的控制器
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  RefreshController get refreshController => _refreshController;
  set refreshController(RefreshController i) {
    _refreshController = i;
  }

  init() {
    final List<ChatListData> items = [
      ChatListData(
          0,
          "https://pic4.zhimg.com/v2-19dced236bdff0c47a6b7ac23ad1fbc3.jpg",
          "柠檬精",
          "是的，我觉得你非常好看我觉得你非常好看我觉得你非常好看",
          "05:32 PM",
          isTop: true,
          isOnline: true),
      ChatListData(
          1,
          "https://pic4.zhimg.com/v2-19dced236bdff0c47a6b7ac23ad1fbc3.jpg",
          "屁精",
          "是的，我觉得你真的很會放屁你真的很會放屁你真的很會放屁",
          "07:04 AM",
          unReadNum: 8),
      ChatListData(
          2,
          "https://pic4.zhimg.com/v2-19dced236bdff0c47a6b7ac23ad1fbc3.jpg",
          "郵件",
          "快收郵件",
          "10:00 AM"),
      ChatListData(
          3,
          "https://pic4.zhimg.com/v2-19dced236bdff0c47a6b7ac23ad1fbc3.jpg",
          "三小啦",
          "是的，我觉得你在幹三小啦",
          "02:33 PM",
          isOnline: true),
      ChatListData(
          4,
          "https://pic4.zhimg.com/v2-19dced236bdff0c47a6b7ac23ad1fbc3.jpg",
          "測試人員",
          "永無止盡的測試~~~",
          "11:56 PM"),
    ];
    chatList.addAll(items);
    notifyListeners();
  }

  @override
  void dispose() {
    removeAll();
    super.dispose();
  }

  //根據當前模式取得資料
  List<ChatListData> getData() {
    if (isSearchMode) {
      return searchChatList;
    }
    return chatList;
  }

  //根據id取得資料
  ChatListData? getDataById(int id) {
    ChatListData? chatData;
    for (var element in getData()) {
      if (element.id == id) {
        chatData = element;
        break;
      }
    }
    return chatData;
  }

  //刷新資料
  refresh() async {
    await Future.delayed(const Duration(seconds: 2));
    refreshController.refreshCompleted();
  }

  //加載下一筆資料
  loadMore() async {
    await Future.delayed(const Duration(seconds: 2));
    refreshController.loadComplete();
  }

  //移除所有資料
  removeAll() {
    chatList.clear();
    searchChatList.clear();
  }

  //移除某項資料
  void removeItem(ChatListData data) {
    chatList.remove(data);
    if (isSearchMode) {
      searchData(searchKey);
    }
    notifyListeners();
  }

  //設置是否置頂
  void setIsTop(ChatListData data, bool isTop) {
    data.setIsTop(isTop);
    sortByTop();
    if (isSearchMode) {
      searchData(searchKey);
    }
    notifyListeners();
  }

  //按照置頂排序
  void sortByTop() {
    chatList.sort((a, b) {
      if (b.isTop) {
        return 1;
      }
      return -1;
    });
  }

  //設置是否搜尋模式
  void setIsSearchMode(bool isSearchMode) {
    if (this.isSearchMode != isSearchMode) {
      this.isSearchMode = isSearchMode;
      searchChatList.clear();
      notifyListeners();
    }
  }

  //根據用戶輸入資訊找尋對應的資料
  void searchData(String searchStr) {
    if (searchStr.isEmpty) {
      return;
    }
    searchKey = searchStr;
    searchChatList.clear();
    for (var element in chatList) {
      if (element.name.contains(searchStr) ||
          element.finalMsg.contains(searchStr)) {
        searchChatList.add(element);
      }
    }
    notifyListeners();
  }
}

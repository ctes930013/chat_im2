import 'package:chat_im/page/chat_list.dart';
import 'package:chat_im/page/chat_room.dart';
import 'package:chat_im/page/lobby.dart';
import 'package:chat_im/page/login.dart';
import 'package:chat_im/utils/data_manager.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

//Handler配置
//首頁
var rootHandler = Handler(handlerFunc: (BuildContext? context, params) {
  if (dataManager.getUserToken() != "") {
    return const Lobby();
  } else {
    return const Login();
  }
});

//首頁大廳
var lobbyHandler = Handler(handlerFunc: (BuildContext? context, params) {
  return const Lobby();
});

//聊天室房間
var chatRoomHandler = Handler(handlerFunc: (BuildContext? context, params) {
  final String? roomId = params['room_id']?.first;
  final String? userName = params['user_name']?.first;
  return ChatRoom(
    roomId: roomId!,
    userName: userName!,
  );
});

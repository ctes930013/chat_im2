import 'package:chat_im/route/router_handler.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

//Fluro路由配置
class Application {
  static late final FluroRouter router;
}

// 路由配置
class Routers {
  static const String root = "/";
  static const String lobby = "/lobby";
  static const String chatRoom = "/chatRoom";

  static void configureRoutes(FluroRouter router) {
    //找不到路由
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });

    //路由定義
    //首頁
    router.define(root, handler: rootHandler);
    //聊天列表
    router.define(lobby,
        handler: lobbyHandler, transitionType: TransitionType.fadeIn);
    //聊天室房間
    router.define(chatRoom,
        handler: chatRoomHandler, transitionType: TransitionType.fadeIn);
  }
}

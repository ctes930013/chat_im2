import 'package:chat_im/page/chat_list.dart';
import 'package:chat_im/page/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Lobby extends ConsumerStatefulWidget {
  const Lobby({super.key});

  @override
  ConsumerState<Lobby> createState() => _LobbyState();
}

class _LobbyState extends ConsumerState<Lobby> {

  //所有的子页面
  List<Widget> pgeList = [
    const ChatList(),
    const Profile(),
  ];
  //當前用戶選擇的頁面
  int selectPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pgeList[selectPage],
      bottomNavigationBar: buildBottom(),
    );
  }

  //底部導航
  buildBottom() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "聊天室"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "個人中心"),
      ],
      currentIndex: selectPage,
      //点击菜单栏的回调
      onTap: (int index) {
        setState(() {
          selectPage = index;
        });
      },
    );
  }
}
import 'package:chat_im/model/chat_room_data.dart';
import 'package:chat_im/page/chat_room_item.dart';
import 'package:chat_im/utils/keyboard_hide_widget.dart';
import 'package:chat_im/viewmodel/chat_room_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatRoom extends ConsumerStatefulWidget {
  const ChatRoom({super.key, required this.roomId, required this.userName});

  final String userName;
  final String roomId;

  @override
  ConsumerState<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends ConsumerState<ChatRoom> {
  //註冊聊天室房間的provider
  final chatRoomProvider =
      ChangeNotifierProvider<ChatRoomViewModel>((ref) => ChatRoomViewModel());
  //輸入框控制器
  late TextEditingController textEditingController;

  late int roomId;
  late String userName;
  @override
  void initState() {
    textEditingController = TextEditingController();
    roomId = int.parse(widget.roomId);
    userName = widget.userName;
    //先取得初始化資料
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read<ChatRoomViewModel>(chatRoomProvider.notifier).init();
    });
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(userName),
      ),
      body: SizedBox(
        height: double.infinity,
        child: Column(
          children: [
            //聊天列表
            Expanded(
              child: KeyboardHideWidget(
                child: Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    //監聽list變化
                    final List<ChatRoomData> items = ref.watch(chatRoomProvider
                        .select((provider) => provider.getData().toList()));
                    return SmartRefresher(
                      controller:
                          ref.read(chatRoomProvider.notifier).refreshController,
                      enablePullDown: false,
                      enablePullUp: true,
                      onLoading: ref.read(chatRoomProvider.notifier).loadMore,
                      reverse: true, //重要，翻轉list，由底部開始加載
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          ChatRoomData data = items[index];
                          return ChatRoomItem(
                            id: data.id,
                            userId: data.userId,
                            imgUrl: data.imgUrl,
                            name: data.name,
                            msg: data.msg,
                            time: data.time,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 4.w,
            ),
            //輸入框
            Align(
              alignment: Alignment.bottomCenter,
              child: getTextFieldWidget(),
            ),
          ],
        ),
      ),
    );
  }

  //取得輸入框元件
  Widget getTextFieldWidget() {
    return TextField(
      controller: textEditingController,
      //文字超出範圍自動換行
      maxLines: 5,
      minLines: 1,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Write a message...",
          prefix: SizedBox(
            width: 8.w,
          ),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              //發送訊息
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  String msg = textEditingController.text;
                  if (msg.isEmpty) {
                    return;
                  }
                  ChatRoomData data = ChatRoomData(
                    0,
                    1,
                    "https://pic4.zhimg.com/v2-19dced236bdff0c47a6b7ac23ad1fbc3.jpg",
                    "柠檬精",
                    msg,
                    DateFormat('kk:mm').format(DateTime.now()),
                  );
                  ref.read(chatRoomProvider.notifier).addData(data);
                  textEditingController.clear();
                },
              ),
            ],
          )),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*
* 创建者：eric
* 聊天對話內容
* id: id
* userId: 會員id
* imgUrl: 大頭貼圖片網址
* name: 會員名稱
* msg: 最後一筆訊息
* time: 訊息建立時間
* */
class ChatRoomItem extends ConsumerStatefulWidget {
  final int id;
  final int userId;
  final String imgUrl;
  final String name;
  final String msg;
  final String time;
  const ChatRoomItem({
    super.key,
    required this.id,
    required this.userId,
    required this.imgUrl,
    required this.name,
    required this.msg,
    required this.time,
  });

  @override
  ConsumerState<ChatRoomItem> createState() => _ChatRoomItemState();
}

class _ChatRoomItemState extends ConsumerState<ChatRoomItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //TODO:這裡之後要改掉
    return getMsgBubble(widget.name, widget.msg, widget.time, widget.imgUrl,
        widget.userId == 1);
  }

  //對話泡泡
  Widget getMsgBubble(
      String name, String msg, String time, String imgUrl, bool isMe) {
    return Container(
      margin: EdgeInsets.all(4.w),
      child: Row(
        children: [
          //間距
          isMe
              ? const Expanded(
                  flex: 1,
                  child: SizedBox(),
                )
              : const SizedBox(),
          //對話內容
          Expanded(
            flex: 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment:
                  isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                //大頭貼
                !isMe
                    ? Flexible(
                        flex: 1,
                        child: Container(
                            margin: EdgeInsets.only(right: 4.w),
                            child: getUserImg(imgUrl)))
                    : const SizedBox(),
                //主要對話
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      //用戶名稱
                      isMe
                          ? const SizedBox()
                          : Text(
                              name,
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.grey,
                              ),
                            ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.w)),
                          color: isMe ? Colors.blue : Colors.black12,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: Text(
                            msg,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: isMe ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.w,
                      ),
                      //時間
                      Align(
                        alignment:
                            isMe ? Alignment.bottomRight : Alignment.bottomLeft,
                        child: getTimeTxt(time),
                      ),
                    ],
                  ),
                ),
                //大頭貼
                isMe
                    ? Flexible(
                        flex: 1,
                        child: Container(
                            margin: EdgeInsets.only(left: 4.w),
                            child: getUserImg(widget.imgUrl)))
                    : const SizedBox(),
              ],
            ),
          ),
          //間距
          !isMe
              ? const Expanded(
                  flex: 1,
                  child: SizedBox(),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  //取得訊息發送時間元件
  Widget getTimeTxt(String time) {
    return Container(
      margin: EdgeInsets.only(left: 3.w, right: 3.w),
      child: Text(
        time,
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.grey,
        ),
      ),
    );
  }

  //取得用戶大頭貼元件
  Widget getUserImg(String imgUrl) {
    return Container(
      width: 40.w,
      height: 40.w,
      margin: EdgeInsets.only(left: 2.w, right: 2.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.w), //設定圓角
        child: CachedNetworkImage(
          imageUrl: imgUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

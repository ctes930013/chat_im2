import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_im/utils/msg_num_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

/*
* 创建者：eric
* 聊天對話長列表
* id: id
* index: 第幾項
* imgUrl: 圖片網址
* name: 會員名稱
* finalMsg: 最後一筆訊息
* time: 訊息建立時間
* isTop: 該對話紀錄是否置頂
* isOnline: 是否在線上
* unReadNum: 未讀訊息數量
* onDeleteClick: 側滑刪除點擊動作
* onTopClick: 側滑是否置頂點擊動作
* */
class ChatListItem extends ConsumerStatefulWidget {
  final int id;
  final int index;
  final String imgUrl;
  final String name;
  final String finalMsg;
  final String time;
  final bool isTop;
  final bool isOnline;
  final int unReadNum;
  final Function onDeleteClick;
  final Function onTopClick;
  const ChatListItem({
    super.key,
    this.isTop = false,
    this.isOnline = false,
    this.unReadNum = 0,
    required this.id,
    required this.index,
    required this.imgUrl,
    required this.name,
    required this.finalMsg,
    required this.time,
    required this.onDeleteClick,
    required this.onTopClick,
  });

  @override
  ConsumerState<ChatListItem> createState() => _ChatListItemState();
}

class _ChatListItemState extends ConsumerState<ChatListItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //支援滑動選單
    return Slidable(
      key: ValueKey(widget.index),
      endActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),
        // 禁止滑動過頭的移除
        dragDismissible: false,
        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {}),
        // 側邊選單的內容
        children: [
          // A SlidableAction can have an icon and/or a label.
          //是否置頂
          SlidableAction(
            onPressed: (BuildContext context) {
              widget.onTopClick();
            },
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            label: widget.isTop ? '解除\n置顶' : '置顶',
          ),
          //移除
          SlidableAction(
            onPressed: (BuildContext context) {
              widget.onDeleteClick();
            },
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            label: '删除',
          ),
        ],
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.w),
        child: Row(
          children: [
            //未讀消息數量以及圖片(大頭像)
            MsgNumWidget(
              width: 50.w,
              height: 50.w,
              num: widget.unReadNum,
              isOnline: widget.isOnline,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.w), //設定圓角
                child: CachedNetworkImage(
                  imageUrl: widget.imgUrl,
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
            ),
            SizedBox(
              width: 5.w,
            ),
            Expanded(
              child: Row(
                children: [
                  //名字及最後一筆訊息
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          widget.finalMsg,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //是否置頂及時間
                  Container(
                    width: 100.w,
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.isTop ? "置顶" : "",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 4.w,
                        ),
                        Text(
                          widget.time,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

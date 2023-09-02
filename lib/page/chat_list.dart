import 'package:chat_im/route/router.dart';
import 'package:chat_im/utils/keyboard_hide_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../model/chat_list_data.dart';
import '../../viewmodel/chat_list_view_model.dart';
import 'chat_list_item.dart';
import 'chat_list_search.dart';

class ChatList extends ConsumerStatefulWidget {
  const ChatList({super.key});

  @override
  ConsumerState<ChatList> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  //註冊聊天室長列表的provider
  final chatListProvider =
      ChangeNotifierProvider<ChatListViewModel>((ref) => ChatListViewModel());
  //搜尋鍵盤的觸發控制
  FocusNode searchFocusNode = FocusNode();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    //先取得初始化資料
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read<ChatListViewModel>(chatListProvider.notifier).init();
    });
    searchFocusNode.addListener(onSearchFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    searchFocusNode.removeListener(onSearchFocusChange);
    searchFocusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  //偵測搜尋鍵盤的觸發
  onSearchFocusChange() {
    if (searchFocusNode.hasFocus) {
      //當搜尋鍵盤觸發有所變化時改為搜尋模式
      ref
          .read<ChatListViewModel>(chatListProvider.notifier)
          .setIsSearchMode(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("聊天室"),
      ),
      body: KeyboardHideWidget(
        child: Column(
          children: [
            //搜尋輸入框
            Container(
                margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.w),
                child: Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    //監聽搜尋模式變化
                    final bool isSearchMode = ref.watch(chatListProvider
                        .select((provider) => provider.isSearchMode));
                    return ChatListSearch(
                        focusNode: searchFocusNode,
                        controller: searchController,
                        isSearch: isSearchMode,
                        searchClick: (String value) {
                          //點擊搜尋按鈕
                          if (value.isNotEmpty) {
                            ref
                                .read<ChatListViewModel>(
                                    chatListProvider.notifier)
                                .searchData(value);
                          }
                        },
                        cancelClick: () {
                          //點擊取消搜尋
                          //關閉鍵盤
                          FocusScope.of(context).requestFocus(FocusNode());
                          //清除輸入的文字
                          searchController.clear();
                          //點擊取消回到非搜尋模式
                          ref
                              .read<ChatListViewModel>(
                                  chatListProvider.notifier)
                              .setIsSearchMode(false);
                        });
                  },
                )),
            SizedBox(
              height: 5.w,
            ),
            //長列表
            Expanded(
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  //監聽list變化
                  final List<ChatListData> items = ref.watch(chatListProvider
                      .select((provider) => provider.getData().toList()));
                  return SmartRefresher(
                    controller:
                        ref.read(chatListProvider.notifier).refreshController,
                    enablePullDown: true,
                    enablePullUp: true,
                    onRefresh: ref.read(chatListProvider.notifier).refresh,
                    onLoading: ref.read(chatListProvider.notifier).loadMore,
                    child: ListView.separated(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        ChatListData data = items[index];
                        return InkWell(
                          onTap: () {
                            Application.router.navigateTo(context,
                                '${Routers.chatRoom}?room_id=${data.id.toString()}&user_name=${Uri.encodeComponent(data.name)}');
                          },
                          child: ChatListItem(
                            id: data.id,
                            index: index,
                            imgUrl: data.imgUrl,
                            name: data.name,
                            finalMsg: data.finalMsg,
                            time: data.time,
                            isTop: data.isTop,
                            isOnline: data.isOnline,
                            unReadNum: data.unReadNum,
                            onDeleteClick: () {
                              ref
                                  .read<ChatListViewModel>(
                                      chatListProvider.notifier)
                                  .removeItem(data);
                            },
                            onTopClick: () {
                              ref
                                  .read<ChatListViewModel>(
                                      chatListProvider.notifier)
                                  .setIsTop(data, !data.isTop);
                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 1,
                          color: Colors.black12,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

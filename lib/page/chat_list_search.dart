import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatListSearch extends StatelessWidget {
  final FocusNode focusNode;
  final bool isSearch;
  final Function cancelClick;
  final Function searchClick;
  final TextEditingController controller;

  const ChatListSearch(
      {super.key,
      required this.focusNode,
      required this.controller,
      this.isSearch = false,
      required this.cancelClick,
      required this.searchClick});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 38.w,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: double.infinity,
              padding: EdgeInsets.only(left: 15.w, right: 15.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.w)),
                  border: Border.all(
                      color: !isSearch
                          ? const Color(0xFFE7E7E7)
                          : const Color(0xFFEDEDED),
                      width: 1.w),
                  color:
                      !isSearch ? Colors.transparent : const Color(0xFFEDEDED)),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      searchClick(controller.text);
                    },
                    child: Image.asset(
                      "assets/img/search.png",
                      width: 20.w,
                      height: 20.w,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        searchClick(value);
                      },
                      focusNode: focusNode,
                      decoration: InputDecoration.collapsed(
                        hintText: !isSearch ? '搜索消息或者用户' : '请输入',
                        hintStyle:
                            TextStyle(fontSize: 15.sp, color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Visibility(
              visible: isSearch,
              child: Container(
                margin: EdgeInsets.only(left: 10.w),
                child: InkWell(
                  onTap: () {
                    cancelClick();
                  },
                  child: Text(
                    '取消',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: const Color(0xFFDD4F72),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

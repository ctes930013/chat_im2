import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*
* 创建者：eric
* 個人中心設定長列表
* index: 第幾項
* imgUrl: 圖片位置
* title: 標題名稱
* onClick: 點擊動作
* */
class UserSettingListItem extends StatelessWidget {
  final int index;
  final String imgUrl;
  final String title;
  final Function? onClick;
  const UserSettingListItem({
    super.key,
    required this.index,
    required this.imgUrl,
    required this.title,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onClick != null) {
          onClick!();
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 10.w, bottom: 10.w, left: 16.w, right: 16.w),
        color: Colors.white,
        child: Row(
          children: [
            Image.asset(
              imgUrl,
              width: 24.w,
              height: 24.w,
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

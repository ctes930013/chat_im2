import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*
* 创建者：eric
* 未讀訊息或是在線提示的小圓點
* num: 未讀訊息數量
* isOnline: 會員是否在線上
* width: 子元件寬度
* height: 子元件高度
* child: 子元件(通常是用戶頭像)，注意: 子原件無須在外部給定寬高
* */
class MsgNumWidget extends StatelessWidget {
  final int num;
  final double width;
  final double height;
  final Widget child;
  final bool isOnline;
  const MsgNumWidget(
      {super.key,
      this.num = 0,
      this.isOnline = false,
      required this.width,
      required this.height,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width + 5.w,
      height: height,
      child: Stack(
        children: [
          SizedBox(width: width, height: height, child: child),
          //未讀消息小紅點
          num == 0
              ? const SizedBox()
              : Positioned(
                  //根據不同的位數要有不同的間距
                  right: num.toString().length < 10
                      ? 4.w
                      : num.toString().length >= 10 &&
                              num.toString().length < 100
                          ? 3.w
                          : num.toString().length >= 100 &&
                                  num.toString().length < 1000
                              ? 2.w
                              : 0,
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 4.w, right: 4.w, top: 1.w, bottom: 1.w),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.all(Radius.circular(20.w)),
                    ),
                    child: Text(
                      num > 999 ? '999+' : num.toString(),
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
          //是否在線的小綠點
          !isOnline
              ? const SizedBox()
              : Positioned(
                  right: 6.w,
                  bottom: 2.w,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF6DD400),
                      borderRadius: BorderRadius.all(Radius.circular(20.w)),
                    ),
                    child: SizedBox(
                      width: 10.w,
                      height: 10.w,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

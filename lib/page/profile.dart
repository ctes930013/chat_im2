import 'package:chat_im/model/user_setting_data.dart';
import 'package:chat_im/page/user_setting_list_item.dart';
import 'package:chat_im/route/router.dart';
import 'package:chat_im/viewmodel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {

  //註冊用戶的provider
  final userProvider =
    ChangeNotifierProvider<UserViewModel>((ref) => UserViewModel());
  List<UserSettingData> userSettingData = [];

  @override
  void initState() {
    userSettingData = [
      UserSettingData(
        img: "assets/img/logout.png",
        title: "登出",
        onClick: () async {
          //呼出登入api
          await UserViewModel().logout(
            context,
            successEvent: (){
              //跳轉回首頁
              if (mounted) {
                Application.router.navigateTo(context, Routers.root,
                    clearStack: true);
              }
            },
          );
        },
      ),
    ];
    //先取得用戶資料
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read<UserViewModel>(userProvider.notifier).init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: const Color(0xFFE5E7E9),
          child: Column(
            children: [
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  //取得用戶名稱
                  final String userName = ref.watch(userProvider
                      .select((provider) => provider.userName ?? ""));
                  return Column(
                    children: [
                      SizedBox(
                        height: 50.w,
                      ),
                      //用戶頭像
                      Image.asset(
                        "assets/img/user.png",
                        width: 80.w,
                        height: 80.w,
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      //用戶名稱
                      Text(
                        userName,
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  );
                }
              ),
              SizedBox(
                height: 15.w,
              ),
              //設置列表
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(left: 40.w, right: 40.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.w)),
                      color: Colors.white
                  ),
                  child: getSettingList(userSettingData),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //取得用戶設置列表
  Widget getSettingList(List<UserSettingData> settingData) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: settingData.length,
      itemBuilder: (BuildContext context, int index) {
        UserSettingData data = settingData[index];
        return UserSettingListItem(
          index: index,
          imgUrl: data.img,
          title: data.title,
          onClick: data.onClick,
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          height: 1,
          color: Colors.black12,
        );
      },
    );
  }
}
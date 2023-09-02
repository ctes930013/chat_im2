import 'package:chat_im/bean/response_bean.dart';
import 'package:chat_im/model/login_data.dart';
import 'package:chat_im/network/user_api.dart';
import 'package:chat_im/route/router.dart';
import 'package:chat_im/utils/data_manager.dart';
import 'package:chat_im/utils/keyboard_hide_widget.dart';
import 'package:chat_im/utils/toast.dart';
import 'package:chat_im/viewmodel/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  //是否顯示輸入框的密碼
  bool isShowPwd = false;
  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    accountController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  //設置是否顯示或隱藏密碼
  void setPwdVisible() {
    setState(() {
      isShowPwd = !isShowPwd;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: KeyboardHideWidget(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/login_bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            padding: EdgeInsets.all(10.w),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //帳號輸入框
                TextField(
                  controller: accountController,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: "帳號",
                  ),
                ),
                //密碼輸入框
                TextField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !isShowPwd,
                  enableSuggestions: false,
                  autocorrect: false,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: "密碼",
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setPwdVisible();
                      },
                      child: Icon(
                        isShowPwd ? Icons.visibility : Icons.visibility_off,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.w,
                ),
                ElevatedButton(
                  child: Text(
                    '登入',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    String account = accountController.text;
                    String password = passwordController.text;
                    if (account.isEmpty) {
                      showToast("請輸入帳號");
                      return;
                    }
                    if (password.isEmpty) {
                      showToast("請輸入密碼");
                      return;
                    }
                    //呼叫登入api
                    await UserViewModel().login(
                      context,
                      account,
                      password,
                      successEvent: (){
                        //跳轉聊天列表
                        if (mounted) {
                          Application.router.navigateTo(context, Routers.lobby,
                              clearStack: true);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

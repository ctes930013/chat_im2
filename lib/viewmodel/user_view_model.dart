import 'package:chat_im/bean/response_bean.dart';
import 'package:chat_im/model/login_data.dart';
import 'package:chat_im/model/user_info_data.dart';
import 'package:chat_im/network/user_api.dart';
import 'package:chat_im/utils/data_manager.dart';
import 'package:chat_im/utils/process_dialog.dart';
import 'package:chat_im/utils/toast.dart';
import 'package:flutter/material.dart';

/*
* 创建者：eric
* 用戶相關操作的view model
* */
class UserViewModel extends ChangeNotifier {

  String? id;  //用戶id
  String? userName;    //用戶名稱
  String? address;    //用戶住址
  String? avatar;   //用戶大頭貼
  String? createTime;    //用戶建立時間
  String? role;    //用戶腳色
  String? updateTime;    //用戶最近更新時間

  /*
  * 创建者：eric
  * 初始化
  * */
  init() {
    callUserInfoApi();
  }

  @override
  void dispose() {
    removeAll();
    super.dispose();
  }

  /*
  * 创建者：eric
  * 登入
  * context: BuildContext
  * account: 帳號
  * password: 密碼
  * successEvent: 登入成功的事件
  * */
  login(BuildContext context, String account,
      String password, {Function? successEvent}) async {
    final ProcessDialog pd = ProcessDialog(context, message: "登入中...");
    await pd.show();
    ResponseBean res = await UserApi.login(account, password);
    if (res.success()) {
      //登入成功
      LoginData loginData = LoginData.fromJson(res.data);
      //儲存token及id
      await dataManager.setUserToken(loginData.jwtToken!);
      await dataManager.setUserId(loginData.userId!);
      await pd.cancel();
      if (successEvent != null) {
        successEvent();
      }
    } else {
      //登入失敗
      await pd.cancel();
      showToast(res.message);
    }
  }

  /*
  * 创建者：eric
  * 登出
  * context: BuildContext
  * */
  logout(BuildContext context, {Function? successEvent}) async {
    final ProcessDialog pd = ProcessDialog(context, message: "登出中...");
    await pd.show();
    ResponseBean res = await UserApi.logout();
    if (res.success()) {
      //登出成功
      //清除token及id
      await dataManager.logout();
      await pd.cancel();
      if (successEvent != null) {
        successEvent();
      }
    } else {
      //登出失敗
      await pd.cancel();
      showToast(res.message);
    }
  }

  /*
  * 创建者：eric
  * 呼叫取得用戶資訊的api
  * */
  callUserInfoApi() async {
    ResponseBean res = await UserApi.getUserInfo();
    if (res.success()) {
      UserInfoData userInfoData = UserInfoData.fromJson(res.data);
      id = userInfoData.id;
      userName = userInfoData.userName;
      address = userInfoData.address;
      avatar = userInfoData.avatar;
      createTime = userInfoData.createTime;
      role = userInfoData.role;
      updateTime = userInfoData.updateTime;
      notifyListeners();
    } else {
      showToast(res.message);
    }
  }

  //移除所有資料
  removeAll() {
    id = null;
    userName = null;
    address = null;
    avatar = null;
    createTime = null;
    role = null;
    updateTime = null;
  }
}
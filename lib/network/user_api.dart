import 'package:chat_im/bean/login_bean.dart';
import 'package:chat_im/bean/response_bean.dart';
import 'package:chat_im/network/api_path.dart';
import 'package:chat_im/network/http_utils.dart';
import 'package:chat_im/utils/data_manager.dart';
import 'package:dio/dio.dart';

/*
* 创建者：eric
* 關於用戶的api
* */
class UserApi {

  /*
  * 创建者：eric
  * 登入
  * userName: 帳號
  * password: 密碼
  * */
  static Future<ResponseBean> login (String userName, String password) async {
    LoginBean bean = LoginBean(userName: userName, password: password);
    Response response = await HttpUtils.post(
      ApiPath.loginPath,
      query: bean.toJson(),
      isSendToken: false,
    );

    ResponseBean responseBean = ResponseBean.fromJson(response.data);
    return responseBean;
  }

  /*
  * 创建者：eric
  * 登出
  * */
  static Future<ResponseBean> logout () async {
    Response response = await HttpUtils.post(
      ApiPath.logoutPath,
    );

    ResponseBean responseBean = ResponseBean.fromJson(response.data);
    return responseBean;
  }

  /*
  * 创建者：eric
  * 取得用戶詳情
  * */
  static Future<ResponseBean> getUserInfo () async {
    Response response = await HttpUtils.get(
      ApiPath.userInfoPath + dataManager.getUserId(),
    );

    ResponseBean responseBean = ResponseBean.fromJson(response.data);
    return responseBean;
  }
}
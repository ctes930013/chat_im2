/*
* 创建者：eric
* api路徑
* */
import 'package:chat_im/network/api_domain.dart';

class ApiPath {

  //登入路徑
  static const String loginPath = "$domainName/user/user/login";
  //登出路徑
  static const String logoutPath = "$domainName/user/user/logout";
  //查詢用戶詳情
  static const String userInfoPath = "$domainName/user/user/";
}
import 'package:chat_im/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

final DataManager dataManager = DataManager();

/*
* 创建者：eric
* 偏好資料儲存及讀取中心
* */
class DataManager {

  late SharedPreferences prefs;

  /*
  * 创建者：eric
  * 初始化
  * */
  init() async {
    // Obtain shared preferences.
    prefs = await SharedPreferences.getInstance();
  }

  /*
  * 创建者：eric
  * 儲存用戶token
  * token: jwt token
  * */
  setUserToken(String token) async {
    await prefs.setString(Constants.userToken, token);
  }

  /*
  * 创建者：eric
  * 取得用戶token
  * */
  String getUserToken() {
    return prefs.getString(Constants.userToken) ?? "";
  }

  /*
  * 创建者：eric
  * 儲存用戶id
  * id: 用戶id
  * */
  setUserId(String id) async {
    await prefs.setString(Constants.userId, id);
  }

  /*
  * 创建者：eric
  * 取得用戶id
  * */
  String getUserId() {
    return prefs.getString(Constants.userId) ?? "";
  }

  /*
  * 创建者：eric
  * 登出
  * */
  logout() async {
    await dataManager.setUserToken("");
    await dataManager.setUserId("");
  }
}
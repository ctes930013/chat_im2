import 'package:chat_im/bean/response_bean.dart';
import 'package:chat_im/main.dart';
import 'package:chat_im/utils/constants.dart';
import 'package:chat_im/utils/data_manager.dart';
import 'package:chat_im/utils/event_bus_extend.dart';
import 'package:chat_im/utils/toast.dart';
import 'package:dio/dio.dart';

/*
* 创建者：eric
* 連結http api的底層網路庫
* */
class HttpUtils {

  /*
  * 创建者：eric
  * get請求
  * url: 目標網址
  * query: 參數
  * header: header
  * isSendToken: 是否要於header中帶入token
  * */
  static Future<Response> get(String url, {Map<String, dynamic>? query,
            Map<String, dynamic>? header, bool isSendToken = true}) async {
    Dio dio = Dio();
    print("GET URL: $url");
    print("Parameters: $query");
    print("Headers: $header");
    Map<String, dynamic>? headerMap = {};
    if (isSendToken) {
      headerMap["Authorization"] = dataManager.getUserToken();
    }
    if (header != null) {
      header.forEach((key, value) {
        headerMap[key] = value;
      });
    }
    Response response = await dio.get(
      url,
      queryParameters: query,
      options: Options(
        headers: headerMap,
      ),
    );
    print("statusCode: ${response.statusCode}");
    if (response.statusCode != 200) {
      showToast("連線異常");
    } else if (response.statusCode == 1004 || response.statusCode == 401) {
      tokenExpire();
    } else {
      ResponseBean responseBean = ResponseBean.fromJson(response.data);
      if (responseBean.code == 1004 || response.statusCode == 401) {
        tokenExpire();
      }
      print("Response: ${response.data.toString()}");
    }

    return response;
  }

  /*
  * 创建者：eric
  * post請求
  * url: 目標網址
  * query: 參數
  * header: header
  * isSendToken: 是否要於header中帶入token
  * */
  static Future<Response> post(String url, {Map<String, dynamic>? query,
    Map<String, dynamic>? header, bool isSendToken = true}) async {
    Dio dio = Dio();
    print("POST URL: $url");
    print("Parameters: $query");
    print("Headers: $header");
    Map<String, dynamic>? headerMap = {};
    if (isSendToken) {
      headerMap["Authorization"] = dataManager.getUserToken();
    }
    if (header != null) {
      header.forEach((key, value) {
        headerMap[key] = value;
      });
    }
    Response response = await dio.post(
      url,
      data: query,
      options: Options(
        headers: headerMap,
      ),
    );
    print("statusCode: ${response.statusCode}");
    if (response.statusCode != 200) {
      showToast("連線異常");
    } else if (response.statusCode == 1004 || response.statusCode == 401) {
      tokenExpire();
    } else {
      print("Response: ${response.data.toString()}");
    }

    return response;
  }

  /*
  * 创建者：eric
  * token失效要登出
  * */
  static tokenExpire() async {
    showToast("token失效");
    await dataManager.logout();
    eventBus.emit(Constants.tokenExpire, true);
  }
}
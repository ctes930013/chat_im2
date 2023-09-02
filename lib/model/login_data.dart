/*
* 创建者：eric
* 登入api回傳的資訊
* */
class LoginData{
  String? userId;   //用戶id
  String? jwtToken;    //用戶token

  LoginData({ required this.userId, required this.jwtToken});

  LoginData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    jwtToken = json['jwtToken'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = userId;
    json['jwtToken'] = jwtToken;
    return json;
  }
}
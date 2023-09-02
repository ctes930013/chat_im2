/*
* 创建者：eric
* 登入要傳給api的資訊
* */
class LoginBean{
  String? userName;     //帳號
  String? password;     //密碼

  LoginBean({ required this.userName, required this.password});

  LoginBean.fromJson(Map<String, dynamic> json) {
    userName = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['username'] = userName;
    json['password'] = password;
    return json;
  }
}
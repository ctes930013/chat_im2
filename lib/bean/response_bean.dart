/*
* 创建者：eric
* api回傳的通用格式
* */
class ResponseBean<T> {
  int code;
  String message;
  T? data;

  ResponseBean({this.code = -1, this.message = '', this.data});

  bool success() => code == 0;

  factory ResponseBean.fromJson(Map<String, dynamic>? json) => ResponseBean<T>(
    code: json?["statusCode"] ?? -1,
    message: json?["mst"] ?? "fail",
    data: json?["data"] as T,
  );

  @override
  String toString() => message;
}
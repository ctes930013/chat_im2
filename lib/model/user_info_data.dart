class UserInfoData {
  String? id;  //用戶id
  String? userName;    //用戶名稱
  String? address;    //用戶住址
  String? avatar;   //用戶大頭貼
  String? createTime;    //用戶建立時間
  String? role;    //用戶腳色
  String? updateTime;    //用戶最近更新時間

  UserInfoData({
    required this.id,
    required this.userName,
    required this.address,
    required this.avatar,
    required this.createTime,
    required this.role,
    required this.updateTime,
  });

  UserInfoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['username'];
    address = json['address'];
    avatar = json['avatarPth'];
    createTime = json['createTime'];
    role = json['role'];
    updateTime = json['updateTime'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['username'] = userName;
    json['address'] = address;
    json['avatarPth'] = avatar;
    json['createTime'] = createTime;
    json['role'] = role;
    json['updateTime'] = updateTime;
    return json;
  }
}
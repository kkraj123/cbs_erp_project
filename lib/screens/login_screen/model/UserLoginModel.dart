class UserLoginPinModel {
  String branchCode;
  String userName;
  String password;
  String deviceToken;

  UserLoginPinModel({
    required this.branchCode,
    required this.userName,
    required this.password,
    required this.deviceToken,
  });

  Map<String, dynamic> toJson() {
    return {
      "branchCode": branchCode,
      "userName": userName,
      "password": password,
      "deviceToken": deviceToken,
    };
  }

  factory UserLoginPinModel.fromJson(Map<String, dynamic> json) {
    return UserLoginPinModel(
      branchCode: json["branchCode"] ?? "",
      userName: json["userName"] ?? "",
      password: json["password"] ?? "",
      deviceToken: json["deviceToken"] ?? "",
    );
  }
}
class CategorySaveItemResponse {
  bool? success;
  int? code;
  String? msg;

  CategorySaveItemResponse({
    this.success,
    this.code,
    this.msg,
  });

  CategorySaveItemResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'code': code,
      'msg': msg,
    };
  }
}
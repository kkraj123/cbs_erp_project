class ItemSaveResponse {
  bool? success;
  int? code;
  String? msg;

  ItemSaveResponse({
    this.success,
    this.code,
    this.msg,
  });

  ItemSaveResponse.fromJson(Map<String, dynamic> json) {
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
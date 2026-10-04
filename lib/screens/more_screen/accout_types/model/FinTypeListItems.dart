class FinTypeListResponse {
  final bool? success;
  final int? code;
  final String? msg;
  final List<FinTypeListItems>? data;

  FinTypeListResponse({
    this.success,
    this.code,
    this.msg,
    this.data,
  });

  factory FinTypeListResponse.fromJson(Map<String, dynamic> json) {
    return FinTypeListResponse(
      success: json['success'] as bool?,
      code: json['code'] as int?,
      msg: json['msg'] as String?,
      data: json['data'] != null
          ? (json['data'] as List)
          .map(
            (item) => FinTypeListItems.fromJson(
          item as Map<String, dynamic>,
        ),
      )
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'code': code,
      'msg': msg,
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }
}

class FinTypeListItems {
  final int? id;
  final String? finCategoryAlias;
  final String? finCategoryName;
  final String? finCategoryLocale;
  final bool? status;
  final String? remarks;
  final int? insertUser;
  final DateTime? insertDate;
  final int? editUser;
  final DateTime? editDate;

  FinTypeListItems({
    this.id,
    this.finCategoryAlias,
    this.finCategoryName,
    this.finCategoryLocale,
    this.status,
    this.remarks,
    this.insertUser,
    this.insertDate,
    this.editUser,
    this.editDate,
  });

  factory FinTypeListItems.fromJson(Map<String, dynamic> json) {
    return FinTypeListItems(
      id: json['id'] as int?,
      finCategoryAlias: json['fin_category_alias'] as String?,
      finCategoryName: json['fin_category_name'] as String?,
      finCategoryLocale: json['fin_category_locale'] as String?,
      status: json['status'] as bool?,
      remarks: json['remarks'] as String?,
      insertUser: json['insert_user'] as int?,
      insertDate: json['insert_date'] != null
          ? DateTime.tryParse(json['insert_date'].toString())
          : null,
      editUser: json['edit_user'] as int?,
      editDate: json['edit_date'] != null
          ? DateTime.tryParse(json['edit_date'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fin_category_alias': finCategoryAlias,
      'fin_category_name': finCategoryName,
      'fin_category_locale': finCategoryLocale,
      'status': status,
      'remarks': remarks,
      'insert_user': insertUser,
      'insert_date': insertDate?.toIso8601String(),
      'edit_user': editUser,
      'edit_date': editDate?.toIso8601String(),
    };
  }
}
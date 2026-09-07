class CategoryItemsResponse {
  bool? success;
  int? code;
  String? msg;
  List<CategoryItemsType>? data;

  CategoryItemsResponse({
    this.success,
    this.code,
    this.msg,
    this.data,
  });

  CategoryItemsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    msg = json['msg'];

    if (json['data'] != null) {
      data = <CategoryItemsType>[];
      json['data'].forEach((v) {
        data!.add(CategoryItemsType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'code': code,
      'msg': msg,
      'data': data?.map((v) => v.toJson()).toList(),
    };
  }
}

class CategoryItemsType {
  int? id;
  String? itemTypeName;
  String? itemTypeLocale;
  String? description;
  bool? status;
  String? remarks;
  int? recCount;
  int? rowNo;
  int? insertUser;
  String? insertDate;
  int? editUser;
  String? editDate;

  CategoryItemsType({
    this.id,
    this.itemTypeName,
    this.itemTypeLocale,
    this.description,
    this.status,
    this.remarks,
    this.recCount,
    this.rowNo,
    this.insertUser,
    this.insertDate,
    this.editUser,
    this.editDate,
  });

  CategoryItemsType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemTypeName = json['item_type_name'];
    itemTypeLocale = json['item_type_locale'];
    description = json['description'];
    status = json['status'];
    remarks = json['remarks'];
    recCount = json['rec_count'];
    rowNo = json['row_no'];
    insertUser = json['insert_user'];
    insertDate = json['insert_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item_type_name': itemTypeName,
      'item_type_locale': itemTypeLocale,
      'description': description,
      'status': status,
      'remarks': remarks,
      'rec_count': recCount,
      'row_no': rowNo,
      'insert_user': insertUser,
      'insert_date': insertDate,
      'edit_user': editUser,
      'edit_date': editDate,
    };
  }
}
class UnitResponse {
  bool? success;
  int? code;
  String? msg;
  List<Unit>? data;

  UnitResponse({
    this.success,
    this.code,
    this.msg,
    this.data,
  });

  UnitResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    msg = json['msg'];

    if (json['data'] != null) {
      data = <Unit>[];
      json['data'].forEach((v) {
        data!.add(Unit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['success'] = success;
    data['code'] = code;
    data['msg'] = msg;

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Unit {
  int? id;
  String? unitAlias;
  String? unitAliasLocale;
  String? unitName;
  String? unitNameLocale;
  int? baseUnitId;
  double? conversionFactor;
  String? description;
  bool? status;
  String? remarks;
  int? insertUser;
  String? insertDate;
  int? editUser;
  String? editDate;
  int? rowNo;
  String? baseUnitName;

  Unit({
    this.id,
    this.unitAlias,
    this.unitAliasLocale,
    this.unitName,
    this.unitNameLocale,
    this.baseUnitId,
    this.conversionFactor,
    this.description,
    this.status,
    this.remarks,
    this.insertUser,
    this.insertDate,
    this.editUser,
    this.editDate,
    this.rowNo,
    this.baseUnitName,
  });

  Unit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitAlias = json['unit_alias'];
    unitAliasLocale = json['unit_alias_locale'];
    unitName = json['unit_name'];
    unitNameLocale = json['unit_name_locale'];
    baseUnitId = json['base_unit_id'];
    conversionFactor = json['conversion_factor']?.toDouble();
    description = json['description'];
    status = json['status'];
    remarks = json['remarks'];
    insertUser = json['insert_user'];
    insertDate = json['insert_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    rowNo = json['row_no'];
    baseUnitName = json['base_unit_name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'unit_alias': unitAlias,
      'unit_alias_locale': unitAliasLocale,
      'unit_name': unitName,
      'unit_name_locale': unitNameLocale,
      'base_unit_id': baseUnitId,
      'conversion_factor': conversionFactor,
      'description': description,
      'status': status,
      'remarks': remarks,
      'insert_user': insertUser,
      'insert_date': insertDate,
      'edit_user': editUser,
      'edit_date': editDate,
      'row_no': rowNo,
      'base_unit_name': baseUnitName,
    };
  }
}
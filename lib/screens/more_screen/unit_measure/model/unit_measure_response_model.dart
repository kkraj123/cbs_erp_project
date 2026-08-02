class UnitMeasureResponseModel {
  final bool? success;
  final int? code;
  final String? msg;
  final List<UnitMeasureData>? data;

  UnitMeasureResponseModel({
    this.success,
    this.code,
    this.msg,
    this.data,
  });

  factory UnitMeasureResponseModel.fromJson(Map<String, dynamic> json) {
    return UnitMeasureResponseModel(
      success: json['success'] as bool?,
      code: json['code'] as int?,
      msg: json['msg'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => UnitMeasureData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'code': code,
      'msg': msg,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class UnitMeasureData {
  final int? id;
  final String? unitAlias;
  final String? unitAliasLocale;
  final String? unitName;
  final String? unitNameLocale;
  final int? baseUnitId;
  final double? conversionFactor;
  final String? description;
  final bool? status;
  final String? remarks;
  final int? insertUser;
  final String? insertDate;
  final int? editUser;
  final String? editDate;
  final int? rowNo;
  final String? baseUnitName;

  UnitMeasureData({
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

  factory UnitMeasureData.fromJson(Map<String, dynamic> json) {
    return UnitMeasureData(
      id: json['id'] as int?,
      unitAlias: json['unit_alias'] as String?,
      unitAliasLocale: json['unit_alias_locale'] as String?,
      unitName: json['unit_name'] as String?,
      unitNameLocale: json['unit_name_locale'] as String?,
      baseUnitId: json['base_unit_id'] as int?,
      conversionFactor: (json['conversion_factor'] as num?)?.toDouble(),
      description: json['description'] as String?,
      status: json['status'] as bool?,
      remarks: json['remarks'] as String?,
      insertUser: json['insert_user'] as int?,
      insertDate: json['insert_date'] as String?,
      editUser: json['edit_user'] as int?,
      editDate: json['edit_date'] as String?,
      rowNo: json['row_no'] as int?,
      baseUnitName: json['base_unit_name'] as String?,
    );
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
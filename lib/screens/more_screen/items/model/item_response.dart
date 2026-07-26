class ItemResponse {
  bool? success;
  int? code;
  String? msg;
  List<Item>? data;

  ItemResponse({
    this.success,
    this.code,
    this.msg,
    this.data,
  });

  factory ItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ItemResponse();

    return ItemResponse(
      success: json['success'] as bool?,
      code: json['code'] as int?,
      msg: json['msg'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>?))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'code': code,
    'msg': msg,
    'data': data?.map((e) => e.toJson()).toList(),
  };
}

class Item {
  int? id;
  int? itemTypeId;
  int? itemCategoryId;
  String? itemAlias;
  String? itemAliasLocale;
  String? itemName;
  String? itemNameLocale;
  int? baseUnitId;
  String? barcode;
  bool? comboItem;
  double? minStockLevel;
  double? maxStockLevel;
  String? description;
  bool? status;
  String? remarks;
  int? insertUser;
  DateTime? insertDate;
  int? editUser;
  DateTime? editDate;
  String? itemTypeName;
  String? categoryName;
  String? unitName;
  int? recCount;
  int? rowNo;

  Item({
    this.id,
    this.itemTypeId,
    this.itemCategoryId,
    this.itemAlias,
    this.itemAliasLocale,
    this.itemName,
    this.itemNameLocale,
    this.baseUnitId,
    this.barcode,
    this.comboItem,
    this.minStockLevel,
    this.maxStockLevel,
    this.description,
    this.status,
    this.remarks,
    this.insertUser,
    this.insertDate,
    this.editUser,
    this.editDate,
    this.itemTypeName,
    this.categoryName,
    this.unitName,
    this.recCount,
    this.rowNo,
  });

  factory Item.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Item();

    return Item(
      id: json['id'] as int?,
      itemTypeId: json['item_type_id'] as int?,
      itemCategoryId: json['item_category_id'] as int?,
      itemAlias: json['item_alias'] as String?,
      itemAliasLocale: json['item_alias_locale'] as String?,
      itemName: json['item_name'] as String?,
      itemNameLocale: json['item_name_locale'] as String?,
      baseUnitId: json['base_unit_id'] as int?,
      barcode: json['barcode'] as String?,
      comboItem: json['combo_item'] as bool?,
      minStockLevel: (json['min_stock_level'] as num?)?.toDouble(),
      maxStockLevel: (json['max_stock_level'] as num?)?.toDouble(),
      description: json['description'] as String?,
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
      itemTypeName: json['item_type_name'] as String?,
      categoryName: json['category_name'] as String?,
      unitName: json['unit_name'] as String?,
      recCount: json['rec_count'] as int?,
      rowNo: json['row_no'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'item_type_id': itemTypeId,
    'item_category_id': itemCategoryId,
    'item_alias': itemAlias,
    'item_alias_locale': itemAliasLocale,
    'item_name': itemName,
    'item_name_locale': itemNameLocale,
    'base_unit_id': baseUnitId,
    'barcode': barcode,
    'combo_item': comboItem,
    'min_stock_level': minStockLevel,
    'max_stock_level': maxStockLevel,
    'description': description,
    'status': status,
    'remarks': remarks,
    'insert_user': insertUser,
    'insert_date': insertDate?.toIso8601String(),
    'edit_user': editUser,
    'edit_date': editDate?.toIso8601String(),
    'item_type_name': itemTypeName,
    'category_name': categoryName,
    'unit_name': unitName,
    'rec_count': recCount,
    'row_no': rowNo,
  };
}
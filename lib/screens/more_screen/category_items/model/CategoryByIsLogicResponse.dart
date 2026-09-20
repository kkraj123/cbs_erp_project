class CategoryByIsLogicResponse {
  bool? success;
  int? code;
  String? msg;
  List<CategoryData>? data;

  CategoryByIsLogicResponse({
    this.success,
    this.code,
    this.msg,
    this.data,
  });

  CategoryByIsLogicResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    msg = json['msg'];

    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data!.add(CategoryData.fromJson(v));
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

class CategoryData {
  int? id;
  int? itemTypeId;
  String? categoryAlias;
  String? categoryName;
  String? categoryNameLocale;
  int? parentId;
  bool? isLogical;
  int? invAccountId;
  int? expAccountId;
  double? depRate;
  int? salesAccountId;
  int? cogsAccountId;
  int? pchTxAccountId;
  int? slsTxAccountId;
  String? description;
  bool? status;
  String? remarks;
  int? insertUser;
  String? insertDate;
  int? editUser;
  String? editDate;
  dynamic recCount;
  dynamic rowNo;
  String? parentName;
  String? parentNameLocale;
  List<dynamic>? children;

  int? invAccTypeId;
  String? invAccNo;
  String? invAccName;
  String? invAccNameLocale;

  int? expAccTypeId;
  String? expAccNo;
  String? expAccName;
  String? expAccNameLocale;

  int? salesAccTypeId;
  String? salesAccNo;
  String? salesAccName;
  String? salesAccNameLocale;

  int? cogsAccTypeId;
  String? cogsAccNo;
  String? cogsAccName;
  String? cogsAccNameLocale;

  int? pchTxAccTypeId;
  String? pchTxAccNo;
  String? pchTxAccName;
  String? pchTxAccNameLocale;

  int? slsTxAccTypeId;
  String? slsTxAccNo;
  String? slsTxAccName;
  String? slsTxAccNameLocale;

  int? masterParentId;

  CategoryData({
    this.id,
    this.itemTypeId,
    this.categoryAlias,
    this.categoryName,
    this.categoryNameLocale,
    this.parentId,
    this.isLogical,
    this.invAccountId,
    this.expAccountId,
    this.depRate,
    this.salesAccountId,
    this.cogsAccountId,
    this.pchTxAccountId,
    this.slsTxAccountId,
    this.description,
    this.status,
    this.remarks,
    this.insertUser,
    this.insertDate,
    this.editUser,
    this.editDate,
    this.recCount,
    this.rowNo,
    this.parentName,
    this.parentNameLocale,
    this.children,
    this.invAccTypeId,
    this.invAccNo,
    this.invAccName,
    this.invAccNameLocale,
    this.expAccTypeId,
    this.expAccNo,
    this.expAccName,
    this.expAccNameLocale,
    this.salesAccTypeId,
    this.salesAccNo,
    this.salesAccName,
    this.salesAccNameLocale,
    this.cogsAccTypeId,
    this.cogsAccNo,
    this.cogsAccName,
    this.cogsAccNameLocale,
    this.pchTxAccTypeId,
    this.pchTxAccNo,
    this.pchTxAccName,
    this.pchTxAccNameLocale,
    this.slsTxAccTypeId,
    this.slsTxAccNo,
    this.slsTxAccName,
    this.slsTxAccNameLocale,
    this.masterParentId,
  });

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemTypeId = json['item_type_id'];
    categoryAlias = json['category_alias'];
    categoryName = json['category_name'];
    categoryNameLocale = json['category_name_locale'];
    parentId = json['parent_id'];
    isLogical = json['is_logical'];
    invAccountId = json['inv_account_id'];
    expAccountId = json['exp_account_id'];
    depRate = (json['dep_rate'] as num?)?.toDouble();
    salesAccountId = json['sales_account_id'];
    cogsAccountId = json['cogs_account_id'];
    pchTxAccountId = json['pch_tx_account_id'];
    slsTxAccountId = json['sls_tx_account_id'];
    description = json['description'];
    status = json['status'];
    remarks = json['remarks'];
    insertUser = json['insert_user'];
    insertDate = json['insert_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
    recCount = json['rec_count'];
    rowNo = json['row_no'];
    parentName = json['parent_name'];
    parentNameLocale = json['parent_name_locale'];
    children = json['children'];

    invAccTypeId = json['inv_acc_type_id'];
    invAccNo = json['inv_acc_no'];
    invAccName = json['inv_acc_name'];
    invAccNameLocale = json['inv_acc_name_locale'];

    expAccTypeId = json['exp_acc_type_id'];
    expAccNo = json['exp_acc_no'];
    expAccName = json['exp_acc_name'];
    expAccNameLocale = json['exp_acc_name_locale'];

    salesAccTypeId = json['sales_acc_type_id'];
    salesAccNo = json['sales_acc_no'];
    salesAccName = json['sales_acc_name'];
    salesAccNameLocale = json['sales_acc_name_locale'];

    cogsAccTypeId = json['cogs_acc_type_id'];
    cogsAccNo = json['cogs_acc_no'];
    cogsAccName = json['cogs_acc_name'];
    cogsAccNameLocale = json['cogs_acc_name_locale'];

    pchTxAccTypeId = json['pch_tx_acc_type_id'];
    pchTxAccNo = json['pch_tx_acc_no'];
    pchTxAccName = json['pch_tx_acc_name'];
    pchTxAccNameLocale = json['pch_tx_acc_name_locale'];

    slsTxAccTypeId = json['sls_tx_acc_type_id'];
    slsTxAccNo = json['sls_tx_acc_no'];
    slsTxAccName = json['sls_tx_acc_name'];
    slsTxAccNameLocale = json['sls_tx_acc_name_locale'];

    masterParentId = json['master_parent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['item_type_id'] = itemTypeId;
    data['category_alias'] = categoryAlias;
    data['category_name'] = categoryName;
    data['category_name_locale'] = categoryNameLocale;
    data['parent_id'] = parentId;
    data['is_logical'] = isLogical;
    data['inv_account_id'] = invAccountId;
    data['exp_account_id'] = expAccountId;
    data['dep_rate'] = depRate;
    data['sales_account_id'] = salesAccountId;
    data['cogs_account_id'] = cogsAccountId;
    data['pch_tx_account_id'] = pchTxAccountId;
    data['sls_tx_account_id'] = slsTxAccountId;
    data['description'] = description;
    data['status'] = status;
    data['remarks'] = remarks;
    data['insert_user'] = insertUser;
    data['insert_date'] = insertDate;
    data['edit_user'] = editUser;
    data['edit_date'] = editDate;
    data['rec_count'] = recCount;
    data['row_no'] = rowNo;
    data['parent_name'] = parentName;
    data['parent_name_locale'] = parentNameLocale;
    data['children'] = children;

    data['inv_acc_type_id'] = invAccTypeId;
    data['inv_acc_no'] = invAccNo;
    data['inv_acc_name'] = invAccName;
    data['inv_acc_name_locale'] = invAccNameLocale;

    data['exp_acc_type_id'] = expAccTypeId;
    data['exp_acc_no'] = expAccNo;
    data['exp_acc_name'] = expAccName;
    data['exp_acc_name_locale'] = expAccNameLocale;

    data['sales_acc_type_id'] = salesAccTypeId;
    data['sales_acc_no'] = salesAccNo;
    data['sales_acc_name'] = salesAccName;
    data['sales_acc_name_locale'] = salesAccNameLocale;

    data['cogs_acc_type_id'] = cogsAccTypeId;
    data['cogs_acc_no'] = cogsAccNo;
    data['cogs_acc_name'] = cogsAccName;
    data['cogs_acc_name_locale'] = cogsAccNameLocale;

    data['pch_tx_acc_type_id'] = pchTxAccTypeId;
    data['pch_tx_acc_no'] = pchTxAccNo;
    data['pch_tx_acc_name'] = pchTxAccName;
    data['pch_tx_acc_name_locale'] = pchTxAccNameLocale;

    data['sls_tx_acc_type_id'] = slsTxAccTypeId;
    data['sls_tx_acc_no'] = slsTxAccNo;
    data['sls_tx_acc_name'] = slsTxAccName;
    data['sls_tx_acc_name_locale'] = slsTxAccNameLocale;

    data['master_parent_id'] = masterParentId;

    return data;
  }
}
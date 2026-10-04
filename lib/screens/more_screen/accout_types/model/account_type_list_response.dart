class AccountTypeListResponse {
  bool? success;
  int? code;
  String? msg;
  List<AccountType>? data;

  AccountTypeListResponse({
    this.success,
    this.code,
    this.msg,
    this.data,
  });

  AccountTypeListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    msg = json['msg'];

    if (json['data'] != null) {
      data = <AccountType>[];
      json['data'].forEach((v) {
        data!.add(AccountType.fromJson(v));
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

class AccountType {
  int? rowNo;
  int? recCount;
  String? brDesc;
  String? acTypeName;
  int? id;
  int? brId;
  int? currencyId;
  bool? isGlobal;
  int? acTypeId;
  String? finType;
  int? finTypeCategory;
  bool? showInFin;
  String? masterAcDesc;
  String? acNo;
  String? accountTypeName;
  String? accountTypeLocale;
  String? preAlias;
  String? postAlias;
  int? digits;
  bool? autoNo;
  bool? idAsAcno;
  int? beginFrom;
  bool? drApplication;
  int? minDaysForDrApp;
  bool? crApplication;
  int? minDaysForCrApp;
  bool? compulsory;
  String? idCategory;
  bool? allowOrg;
  bool? orgOnly;
  bool? allowMf;
  bool? mfOnly;
  bool? allowChild;
  bool? childOnly;
  bool? allowCrBal;
  bool? allowDrBal;
  double? crBalLimit;
  double? drBalLimit;
  bool? allowCr;
  bool? allowDr;
  double? dailyCrLimit;
  double? dailyDrLimit;
  int? masterAc;
  bool? linkAcType;
  int? linkAcTypeId;
  bool? linkAc;
  bool? periodicCr;
  bool? periodicDr;
  bool? longTermCr;
  bool? longTermDr;
  bool? recurringCr;
  bool? recurringDr;
  double? minBalCr;
  double? minBalDr;
  bool? reqInstDrAc;
  bool? reqIntCrAc;
  bool? reqPrinCrAc;
  bool? reqPrinDrAc;
  bool? reqLoanCrAc;
  bool? reqLoanRepayAc;
  int? dormancy;
  int? crDormancy;
  int? drDormancy;
  bool? status;
  String? remarks;
  bool? reqColAc;
  int? colAcType;
  bool? reqId;
  bool? reqBr;
  int? insertUser;
  String? insertDate;
  int? editUser;
  String? editDate;

  AccountType({
    this.rowNo,
    this.recCount,
    this.brDesc,
    this.acTypeName,
    this.id,
    this.brId,
    this.currencyId,
    this.isGlobal,
    this.acTypeId,
    this.finType,
    this.finTypeCategory,
    this.showInFin,
    this.masterAcDesc,
    this.acNo,
    this.accountTypeName,
    this.accountTypeLocale,
    this.preAlias,
    this.postAlias,
    this.digits,
    this.autoNo,
    this.idAsAcno,
    this.beginFrom,
    this.drApplication,
    this.minDaysForDrApp,
    this.crApplication,
    this.minDaysForCrApp,
    this.compulsory,
    this.idCategory,
    this.allowOrg,
    this.orgOnly,
    this.allowMf,
    this.mfOnly,
    this.allowChild,
    this.childOnly,
    this.allowCrBal,
    this.allowDrBal,
    this.crBalLimit,
    this.drBalLimit,
    this.allowCr,
    this.allowDr,
    this.dailyCrLimit,
    this.dailyDrLimit,
    this.masterAc,
    this.linkAcType,
    this.linkAcTypeId,
    this.linkAc,
    this.periodicCr,
    this.periodicDr,
    this.longTermCr,
    this.longTermDr,
    this.recurringCr,
    this.recurringDr,
    this.minBalCr,
    this.minBalDr,
    this.reqInstDrAc,
    this.reqIntCrAc,
    this.reqPrinCrAc,
    this.reqPrinDrAc,
    this.reqLoanCrAc,
    this.reqLoanRepayAc,
    this.dormancy,
    this.crDormancy,
    this.drDormancy,
    this.status,
    this.remarks,
    this.reqColAc,
    this.colAcType,
    this.reqId,
    this.reqBr,
    this.insertUser,
    this.insertDate,
    this.editUser,
    this.editDate,
  });

  AccountType.fromJson(Map<String, dynamic> json) {
    rowNo = json['row_no'];
    recCount = json['rec_count'];
    brDesc = json['br_desc'];
    acTypeName = json['ac_type_name'];
    id = json['id'];
    brId = json['br_id'];
    currencyId = json['currency_id'];
    isGlobal = json['is_global'];
    acTypeId = json['ac_type_id'];
    finType = json['fin_type'];
    finTypeCategory = json['fin_type_category'];
    showInFin = json['show_in_fin'];
    masterAcDesc = json['master_ac_desc'];
    acNo = json['ac_no'];
    accountTypeName = json['account_type_name'];
    accountTypeLocale = json['account_type_locale'];
    preAlias = json['pre_alias'];
    postAlias = json['post_alias'];
    digits = json['digits'];
    autoNo = json['auto_no'];
    idAsAcno = json['id_as_acno'];
    beginFrom = json['begin_from'];
    drApplication = json['dr_application'];
    minDaysForDrApp = json['min_days_for_dr_app'];
    crApplication = json['cr_application'];
    minDaysForCrApp = json['min_days_for_cr_app'];
    compulsory = json['compulsory'];
    idCategory = json['id_category'];
    allowOrg = json['allow_org'];
    orgOnly = json['org_only'];
    allowMf = json['allow_mf'];
    mfOnly = json['mf_only'];
    allowChild = json['allow_child'];
    childOnly = json['child_only'];
    allowCrBal = json['allow_cr_bal'];
    allowDrBal = json['allow_dr_bal'];
    crBalLimit = json['cr_bal_limit']?.toDouble();
    drBalLimit = json['dr_bal_limit']?.toDouble();
    allowCr = json['allow_cr'];
    allowDr = json['allow_dr'];
    dailyCrLimit = json['daily_cr_limit']?.toDouble();
    dailyDrLimit = json['daily_dr_limit']?.toDouble();
    masterAc = json['master_ac'];
    linkAcType = json['link_ac_type'];
    linkAcTypeId = json['link_ac_type_id'];
    linkAc = json['link_ac'];
    periodicCr = json['periodic_cr'];
    periodicDr = json['periodic_dr'];
    longTermCr = json['long_term_cr'];
    longTermDr = json['long_term_dr'];
    recurringCr = json['recurring_cr'];
    recurringDr = json['recurring_dr'];
    minBalCr = json['min_bal_cr']?.toDouble();
    minBalDr = json['min_bal_dr']?.toDouble();
    reqInstDrAc = json['req_inst_dr_ac'];
    reqIntCrAc = json['req_int_cr_ac'];
    reqPrinCrAc = json['req_prin_cr_ac'];
    reqPrinDrAc = json['req_prin_dr_ac'];
    reqLoanCrAc = json['req_loan_cr_ac'];
    reqLoanRepayAc = json['req_loan_repay_ac'];
    dormancy = json['dormancy'];
    crDormancy = json['cr_dormancy'];
    drDormancy = json['dr_dormancy'];
    status = json['status'];
    remarks = json['remarks'];
    reqColAc = json['req_col_ac'];
    colAcType = json['col_ac_type'];
    reqId = json['req_id'];
    reqBr = json['req_br'];
    insertUser = json['insert_user'];
    insertDate = json['insert_date'];
    editUser = json['edit_user'];
    editDate = json['edit_date'];
  }

  Map<String, dynamic> toJson() {
    return {
      'row_no': rowNo,
      'rec_count': recCount,
      'br_desc': brDesc,
      'ac_type_name': acTypeName,
      'id': id,
      'br_id': brId,
      'currency_id': currencyId,
      'is_global': isGlobal,
      'ac_type_id': acTypeId,
      'fin_type': finType,
      'fin_type_category': finTypeCategory,
      'show_in_fin': showInFin,
      'master_ac_desc': masterAcDesc,
      'ac_no': acNo,
      'account_type_name': accountTypeName,
      'account_type_locale': accountTypeLocale,
      'pre_alias': preAlias,
      'post_alias': postAlias,
      'digits': digits,
      'auto_no': autoNo,
      'id_as_acno': idAsAcno,
      'begin_from': beginFrom,
      'dr_application': drApplication,
      'min_days_for_dr_app': minDaysForDrApp,
      'cr_application': crApplication,
      'min_days_for_cr_app': minDaysForCrApp,
      'compulsory': compulsory,
      'id_category': idCategory,
      'allow_org': allowOrg,
      'org_only': orgOnly,
      'allow_mf': allowMf,
      'mf_only': mfOnly,
      'allow_child': allowChild,
      'child_only': childOnly,
      'allow_cr_bal': allowCrBal,
      'allow_dr_bal': allowDrBal,
      'cr_bal_limit': crBalLimit,
      'dr_bal_limit': drBalLimit,
      'allow_cr': allowCr,
      'allow_dr': allowDr,
      'daily_cr_limit': dailyCrLimit,
      'daily_dr_limit': dailyDrLimit,
      'master_ac': masterAc,
      'link_ac_type': linkAcType,
      'link_ac_type_id': linkAcTypeId,
      'link_ac': linkAc,
      'periodic_cr': periodicCr,
      'periodic_dr': periodicDr,
      'long_term_cr': longTermCr,
      'long_term_dr': longTermDr,
      'recurring_cr': recurringCr,
      'recurring_dr': recurringDr,
      'min_bal_cr': minBalCr,
      'min_bal_dr': minBalDr,
      'req_inst_dr_ac': reqInstDrAc,
      'req_int_cr_ac': reqIntCrAc,
      'req_prin_cr_ac': reqPrinCrAc,
      'req_prin_dr_ac': reqPrinDrAc,
      'req_loan_cr_ac': reqLoanCrAc,
      'req_loan_repay_ac': reqLoanRepayAc,
      'dormancy': dormancy,
      'cr_dormancy': crDormancy,
      'dr_dormancy': drDormancy,
      'status': status,
      'remarks': remarks,
      'req_col_ac': reqColAc,
      'col_ac_type': colAcType,
      'req_id': reqId,
      'req_br': reqBr,
      'insert_user': insertUser,
      'insert_date': insertDate,
      'edit_user': editUser,
      'edit_date': editDate,
    };
  }
}
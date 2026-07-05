import 'dart:convert';

class AuthModel {
  bool? success;
  String? msg;
  bool? iseodbodrunning;
  bool? requireOtpVerification;
  String? authToken;
  User? user;
  Branch? branch;
  String? deviceToken;
  Dates? dates;
  List<FinanceParam>? financeParams;
  List<UserAppMenu>? userManu;


  AuthModel({
    this.success,
    this.msg,
    this.iseodbodrunning,
    this.requireOtpVerification,
    this.authToken,
    this.user,
    this.branch,
    required this.deviceToken,
    this.dates,
    this.financeParams,
    this.userManu
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      AuthModel(
        success: json['success'] ?? false,
        msg: json['msg'] ?? '',
        iseodbodrunning: json['iseodbodrunning'] ?? false,
        requireOtpVerification: json['require_otp_verification'] ?? false,
        authToken: json['auth_token'] ?? '',
        user: json['user'] != null ? User.fromJson(json['user']) : null,
        branch: json['branch'] != null ? Branch.fromJson(json['branch']) : null,
        deviceToken: json['deviceToken'] ?? '',
        dates: json['dates'] != null ? Dates.fromJson(json['dates']) : null,
        financeParams: json['finance_params'] != null
            ? List<FinanceParam>.from(
          json['finance_params'].map((x) => FinanceParam.fromJson(x)),
        )
            : [],
        userManu: json['userAppMenus'] != null
            ? List<UserAppMenu>.from(
          json['userAppMenus'].map((x) => UserAppMenu.fromJson(x)),
        )
            : [],
      );

  Map<String, dynamic> toJson() => {
    'success': success ?? false,
    'msg': msg ?? '',
    'iseodbodrunning': iseodbodrunning ?? false,
    'require_otp_verification': requireOtpVerification ?? false,
    'auth_token': authToken ?? '',
    'user': user?.toJson(),
    'branch': branch?.toJson(),
    'deviceToken': deviceToken,
    'dates': dates?.toJson(),
    'finance_params': financeParams?.map((x) => x.toJson()).toList() ?? [],
    'userAppMenus': userManu?.map((x) => x.toJson()).toList() ?? [],
  };
}

class User {
  int? id;
  int? brId;
  int? counterId;
  int? roleId;
  String? userName;
  String? passwordSalt;
  String? passwordHash;
  String? fullName;
  String? fullNameLocale;
  String? address;
  int? genderId;
  String? pContact;
  String? otherContact;
  String? email;
  bool? status;
  DateTime? deactiveDate;
  Map<String, String>? remarks;
  String? brName;
  String? brAlias;
  String? roleName;
  String? genderName;
  int? rowNo;
  int? recCount;
  bool? otpSelf;
  bool? otpBranch;
  bool? checkIp;
  int? insertUser;
  DateTime? insertDate;
  int? editUser;
  DateTime? editDate;

  User({
    this.id,
    this.brId,
    this.counterId,
    this.roleId,
    this.userName,
    this.passwordSalt,
    this.passwordHash,
    this.fullName,
    this.fullNameLocale,
    this.address,
    this.genderId,
    this.pContact,
    this.otherContact,
    this.email,
    this.status,
    this.deactiveDate,
    this.remarks,
    this.brName,
    this.brAlias,
    this.roleName,
    this.genderName,
    this.rowNo,
    this.recCount,
    this.otpSelf,
    this.otpBranch,
    this.checkIp,
    this.insertUser,
    this.insertDate,
    this.editUser,
    this.editDate,
  });

  factory User.fromJson(Map<String, dynamic>? json) {
    if (json == null) return User();

    return User(
      id: _toInt(json['id']),
      brId: _toInt(json['br_id']),
      counterId: _toInt(json['counter_id']),
      roleId: _toInt(json['role_id']),
      userName: _toString(json['user_name']),
      passwordSalt: _toString(json['password_salt']),
      passwordHash: _toString(json['password_hash']),
      fullName: _toString(json['full_name']),
      fullNameLocale: _toString(json['full_name_locale']),
      address: _toString(json['address']),
      genderId: _toInt(json['gender_id']),
      pContact: _toString(json['p_contact']),
      otherContact: _toString(json['other_contact']),
      email: _toString(json['email']),
      status: _toBool(json['status']),
      deactiveDate: _parseDate(json['deactive_date']),
      remarks: _parseRemarks(json['remarks']),
      brName: _toString(json['br_name']),
      brAlias: _toString(json['br_alias']),
      roleName: _toString(json['role_name']),
      genderName: _toString(json['gender_name']),
      rowNo: _toInt(json['row_no']),
      recCount: _toInt(json['rec_count']),
      otpSelf: _toBool(json['otp_self']),
      otpBranch: _toBool(json['otp_branch']),
      checkIp: _toBool(json['check_ip']),
      insertUser: _toInt(json['insert_user']),
      insertDate: _parseDate(json['insert_date']),
      editUser: _toInt(json['edit_user']),
      editDate: _parseDate(json['edit_date']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'br_id': brId,
    'counter_id': counterId,
    'role_id': roleId,
    'user_name': userName,
    'password_salt': passwordSalt,
    'password_hash': passwordHash,
    'full_name': fullName,
    'full_name_locale': fullNameLocale,
    'address': address,
    'gender_id': genderId,
    'p_contact': pContact,
    'other_contact': otherContact,
    'email': email,
    'status': status,
    'deactive_date': deactiveDate?.toIso8601String(),
    'remarks': remarks,
    'br_name': brName,
    'br_alias': brAlias,
    'role_name': roleName,
    'gender_name': genderName,
    'row_no': rowNo,
    'rec_count': recCount,
    'otp_self': otpSelf,
    'otp_branch': otpBranch,
    'check_ip': checkIp,
    'insert_user': insertUser,
    'insert_date': insertDate?.toIso8601String(),
    'edit_user': editUser,
    'edit_date': editDate?.toIso8601String(),
  };

  // 🔹 Safe Converters

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    return int.tryParse(value.toString());
  }

  static String? _toString(dynamic value) {
    if (value == null) return null;
    return value.toString();
  }

  static bool? _toBool(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    return value.toString().toLowerCase() == 'true';
  }

  static DateTime? _parseDate(dynamic date) {
    try {
      if (date == null || date == "0001-01-01T00:00:00") return null;
      return DateTime.parse(date).toLocal();
    } catch (_) {
      return null;
    }
  }

  static Map<String, String>? _parseRemarks(dynamic remarks) {
    try {
      if (remarks == null) return null;

      if (remarks is Map) {
        return remarks.map(
              (key, value) => MapEntry(key.toString(), value.toString()),
        );
      }

      if (remarks is String) {
        final cleaned = remarks.replaceAll('"{"', '{').replaceAll('}"', '}');
        final decoded = jsonDecode(cleaned);
        return (decoded as Map<String, dynamic>).map(
              (k, v) => MapEntry(k, v.toString()),
        );
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}

class Branch {
  int? id;
  String? fullName;
  String? brAlias;
  String? shortName;
  bool? showLocaleDate;
  int? defCurId;
  bool? isCorporate;
  String? logo;

  Branch({
    this.id,
    this.fullName,
    this.brAlias,
    this.shortName,
    this.showLocaleDate,
    this.defCurId,
    this.isCorporate,
    this.logo,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
    id: json['id'] ?? 0,
    fullName: json['full_name'] ?? '',
    brAlias: json['br_alias'] ?? '',
    shortName: json['short_name'] ?? '',
    showLocaleDate: json['show_locale_date'] ?? false,
    defCurId: json['def_cur_id'] ?? 0,
    isCorporate: json['is_corporate'] ?? false,
    logo: json['logo'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id ?? 0,
    'full_name': fullName ?? '',
    'br_alias': brAlias ?? '',
    'short_name': shortName ?? '',
    'show_locale_date': showLocaleDate ?? false,
    'def_cur_id': defCurId ?? 0,
    'is_corporate': isCorporate ?? false,
    'logo': logo ?? '',
  };
}

class Dates {
  String? todayNdate;
  String? todayEdate;

  Dates({this.todayNdate, this.todayEdate});

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
    todayNdate: json['todayNdate'] ?? '',
    todayEdate: json['todayEdate'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'todayNdate': todayNdate ?? '',
    'todayEdate': todayEdate ?? '',
  };
}

class FinanceParam {
  int? id;
  String? parameterName;
  String? parameterLocale;
  String? parameterValue;
  String? description;
  bool? status;
  String? remarks;
  int? rowNo;
  int? recCount;
  int? insertUser;
  String? insertDate;
  int? editUser;
  String? editDate;

  FinanceParam({
    this.id,
    this.parameterName,
    this.parameterLocale,
    this.parameterValue,
    this.description,
    this.status,
    this.remarks,
    this.rowNo,
    this.recCount,
    this.insertUser,
    this.insertDate,
    this.editUser,
    this.editDate,
  });

  factory FinanceParam.fromJson(Map<String, dynamic> json) => FinanceParam(
    id: json['id'] ?? 0,
    parameterName: json['parameter_name'] ?? '',
    parameterLocale: json['parameter_locale'] ?? '',
    parameterValue: json['parameter_value'] ?? '',
    description: json['description'] ?? '',
    status: json['status'] ?? false,
    remarks: json['remarks'] ?? '',
    rowNo: json['row_no'] ?? 0,
    recCount: json['rec_count'] ?? 0,
    insertUser: json['insert_user'] ?? 0,
    insertDate: json['insert_date'] ?? '',
    editUser: json['edit_user'] ?? 0,
    editDate: json['edit_date'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id ?? 0,
    'parameter_name': parameterName ?? '',
    'parameter_locale': parameterLocale ?? '',
    'parameter_value': parameterValue ?? '',
    'description': description ?? '',
    'status': status ?? false,
    'remarks': remarks ?? '',
    'row_no': rowNo ?? 0,
    'rec_count': recCount ?? 0,
    'insert_user': insertUser ?? 0,
    'insert_date': insertDate ?? '',
    'edit_user': editUser ?? 0,
    'edit_date': editDate ?? '',
  };
}

class UserAppMenu {
  int? menuId;
  String? menuName;
  String? menuNameLocale;
  int? parentId;
  String? parentMenu;
  int? orderIndex;
  String? menuPath;
  List<UserAppMenu>? children;

  UserAppMenu({
    this.menuId,
    this.menuName,
    this.menuNameLocale,
    this.parentId,
    this.parentMenu,
    this.orderIndex,
    this.menuPath,
    this.children,
  });

  factory UserAppMenu.fromJson(Map<String, dynamic> json) => UserAppMenu(
    menuId: json['menu_id'],
    menuName: json['menu_name'],
    menuNameLocale: json['menu_name_locale'],
    parentId: json['parent_id'],
    parentMenu: json['parent_menu'],
    orderIndex: json['order_index'],
    menuPath: json['menu_path'],
    children: json['children'] != null
        ? List<UserAppMenu>.from(
      json['children'].map((x) => UserAppMenu.fromJson(x)),
    )
        : null,
  );

  Map<String, dynamic> toJson() => {
    'menu_id': menuId,
    'menu_name': menuName,
    'menu_name_locale': menuNameLocale,
    'parent_id': parentId,
    'parent_menu': parentMenu,
    'order_index': orderIndex,
    'menu_path' : menuPath,
    'children': children?.map((x) => x.toJson()).toList(),
  };
}
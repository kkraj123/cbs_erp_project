import 'package:cbs_erp_project/network/support/dialog_manager.dart';
import 'package:flutter/material.dart';


class ErrorHandler {
  //change with suitable dialog
  static void errorHandle(String message, String title, BuildContext context){
    DialogManager.showErrorDialog(message, title,context);
  }
}
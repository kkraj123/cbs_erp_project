import 'package:flutter/cupertino.dart';

class RecentItemsModel {
  final IconData icon;
  final String itemName;
  final String txnId;
  final String price;
  final String status;

  RecentItemsModel({
    required this.icon,
    required this.itemName,
    required this.txnId,
    required this.price,
    required this.status,
  });
}

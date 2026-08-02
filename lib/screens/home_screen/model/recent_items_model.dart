import 'package:flutter/cupertino.dart';

class RecentItemsModel {
  final int id;
  final IconData icon;
  final String itemName;
  final String txnId;
  final String price;
  final String status;

  RecentItemsModel({
    required this.id,
    required this.icon,
    required this.itemName,
    required this.txnId,
    required this.price,
    required this.status,
  });
}

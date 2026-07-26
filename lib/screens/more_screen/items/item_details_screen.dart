import 'package:cbs_erp_project/screens/more_screen/items/model/item_response.dart';
import 'package:flutter/material.dart';

class ItemDetailsScreen extends StatelessWidget {
  final Item itemDetails;
  const ItemDetailsScreen({super.key, required this.itemDetails});

  Color get _accentColor {
    const palette = [
      Color(0xFF6C63FF),
      Color(0xFF00B894),
      Color(0xFFFF7675),
      Color(0xFFFDCB6E),
      Color(0xFF0984E3),
    ];
    final id = itemDetails.itemTypeId ?? 0;
    return palette[id % palette.length];
  }

  @override
  Widget build(BuildContext context) {
    final isActive = itemDetails.status == true;
    final min = itemDetails.minStockLevel ?? 0;
    final max = itemDetails.maxStockLevel ?? 0;
    final ratio = max > 0 ? (min / max).clamp(0.0, 1.0) : 0.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: _accentColor,
            foregroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
              title: Text(
                itemDetails.itemName ?? '-',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [_accentColor, _accentColor.withOpacity(0.75)],
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.inventory_2_rounded,
                    size: 64,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 14),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    final local = date.toLocal();
    final d = local.day.toString().padLeft(2, '0');
    final m = local.month.toString().padLeft(2, '0');
    final y = local.year.toString();
    final h = local.hour.toString().padLeft(2, '0');
    final min = local.minute.toString().padLeft(2, '0');
    return '$d/$m/$y  $h:$min';
  }
}

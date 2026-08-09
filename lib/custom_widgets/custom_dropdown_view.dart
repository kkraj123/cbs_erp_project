import 'package:flutter/material.dart';

class CustomDropdownV2<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T item) labelBuilder;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String hint;
  final bool searchable;
  final bool enabled;
  final String label;

  final Color? fillColor;
  final Color? selectedFillColor;
  final double borderRadius;
  final Color? accentColor;

  const CustomDropdownV2({
    super.key,
    required this.items,
    required this.labelBuilder,
    required this.onChanged,
    this.value,
    this.hint = 'Select an option',
    this.searchable = false,
    this.enabled = true,
    this.label = '',
    this.fillColor,
    this.selectedFillColor,
    this.borderRadius = 14,
    this.accentColor,
  });

  @override
  State<CustomDropdownV2<T>> createState() => _CustomDropdownV2State<T>();
}

class _CustomDropdownV2State<T> extends State<CustomDropdownV2<T>> {
  bool _isOpen = false;

  Color get _fill => widget.fillColor ?? const Color(0xFFF2F3F7);

  Color get _accent => widget.accentColor ?? Theme.of(context).primaryColor;

  @override
  Widget build(BuildContext context) {
    final hasValue = widget.value != null;
    final radius = BorderRadius.circular(widget.borderRadius);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 5),
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
        ],
        Material(
          color: widget.enabled ? _fill : _fill.withOpacity(0.5),
          borderRadius: radius,
          child: InkWell(
            borderRadius: radius,
            onTap: widget.enabled ? () => _handleTap(context) : null,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: radius,
                color: Color(0xFFFAFAFA),
                border: Border.all(color: Color(0xFFE0E0E0), width: 1),
              ),
              child: widget.searchable
                  ? _buildTriggerRow(hasValue)
                  : _buildInlineDropdownFallback(hasValue),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTriggerRow(bool hasValue) {
    return Row(
      children: [
        Expanded(
          child: Text(
            hasValue ? widget.labelBuilder(widget.value as T) : widget.hint,
            style: TextStyle(
              fontSize: 15,
              fontWeight: hasValue ? FontWeight.w500 : FontWeight.w400,
              color: widget.enabled
                  ? (hasValue ? Colors.black87 : Colors.grey[600])
                  : Colors.grey[500],
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        AnimatedRotation(
          turns: _isOpen ? 0.5 : 0,
          duration: const Duration(milliseconds: 200),
          child: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: widget.enabled ? Colors.grey[700] : Colors.grey[400],
          ),
        ),
      ],
    );
  }

  // Non-searchable mode still uses a native DropdownButton but restyled to
  // match the filled look (transparent underline, custom icon/text).
  Widget _buildInlineDropdownFallback(bool hasValue) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        isExpanded: true,
        value: widget.value,
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        hint: Text(
          widget.hint,
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        borderRadius: BorderRadius.circular(widget.borderRadius),
        items: widget.items
            .map(
              (item) => DropdownMenuItem<T>(
                value: item,
                child: Text(widget.labelBuilder(item), style: TextStyle(fontSize: 13),),
              ),
            )
            .toList(),
        onChanged: widget.enabled ? widget.onChanged : null,
      ),
    );
  }

  void _handleTap(BuildContext context) {
    if (!widget.searchable) return;
    setState(() => _isOpen = true);
    _openSearchSheet(context).whenComplete(() {
      if (mounted) setState(() => _isOpen = false);
    });
  }

  Future<void> _openSearchSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        String query = '';
        return StatefulBuilder(
          builder: (context, setModalState) {
            final filtered = widget.items
                .where(
                  (item) => widget
                      .labelBuilder(item)
                      .toLowerCase()
                      .contains(query.toLowerCase()),
                )
                .toList();

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  children: [
                    // Grab handle
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 6),
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    if (widget.label.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 8),
                        child: Text(
                          widget.label,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                      child: TextField(
                        autofocus: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Search...',
                          filled: true,
                          fillColor: _fill,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              widget.borderRadius,
                            ),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                        ),
                        onChanged: (val) => setModalState(() => query = val),
                      ),
                    ),
                    Expanded(
                      child: filtered.isEmpty
                          ? Center(
                              child: Text(
                                'No results found',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            )
                          : ListView.builder(
                              itemCount: filtered.length,
                              itemBuilder: (context, index) {
                                final item = filtered[index];
                                final selected = item == widget.value;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  child: Material(
                                    color: selected
                                        ? (widget.selectedFillColor ??
                                              _accent.withOpacity(0.08))
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(
                                      widget.borderRadius,
                                    ),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          widget.borderRadius,
                                        ),
                                      ),
                                      title: Text(
                                        widget.labelBuilder(item),
                                        style: TextStyle(
                                          fontWeight: selected
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                          color: selected
                                              ? _accent
                                              : Colors.black87,
                                        ),
                                      ),
                                      trailing: selected
                                          ? Icon(
                                              Icons.check_rounded,
                                              color: _accent,
                                            )
                                          : null,
                                      onTap: () {
                                        widget.onChanged(item);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

import 'package:cbs_erp_project/network/core/network/api_state.dart';
import 'package:cbs_erp_project/screens/login_screen/model/auth_model.dart';
import 'package:cbs_erp_project/screens/more_screen/accout_types/model/account_type_list_response.dart';
import 'package:cbs_erp_project/screens/more_screen/accout_types/provider/account_type_view_holder.dart';
import 'package:cbs_erp_project/screens/more_screen/accout_types/save_account_type_screen.dart';
import 'package:cbs_erp_project/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountTypeScreen extends ConsumerStatefulWidget {
  final User user;

  const AccountTypeScreen({super.key, required this.user});

  @override
  ConsumerState<AccountTypeScreen> createState() => _AccountTypeScreenState();
}

class _AccountTypeScreenState extends ConsumerState<AccountTypeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(accountTypeProvider.notifier).getAccountType();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(accountTypeProvider);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Account Types', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColors,
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(accountTypeProvider.notifier).getAccountType(),
        child: _buildAccountTypeView(state, context),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryColors,
        onPressed: () async {
          final result = await Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (context) => SaveAccountTypeScreen(user: widget.user),
            ),
          );
          if (result == true) {
            ref.read(accountTypeProvider.notifier).getAccountType();
          }
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Add Account Type',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildAccountTypeView(
    ApiState<AccountTypeListResponse> state,
    BuildContext context,
  ) {
    if (state.isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    if (state.errorMessage != null) {
      return Center(child: Text(state.errorMessage ?? 'Something error'));
    }
    if (state.data?.data == null) {
      return const Center(child: Text('Data not found'));
    }
    final accountTypeList = state.data?.data ?? [];
    if (accountTypeList.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(height: 200),
          Center(child: Text('Account types not found')),
        ],
      );
    }
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 88), // room for the FAB
      itemCount: accountTypeList.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        return AccountTypeCard(
          item: accountTypeList[index],
          onTap: () {
            // TODO: open edit / detail screen
          },
        );
      },
    );
  }
}

class AccountTypeCard extends StatelessWidget {
  final dynamic item;
  final VoidCallback? onTap;

  const AccountTypeCard({super.key, required this.item, this.onTap});

  (Color, IconData) _finStyle(String? type) {
    switch (type?.toUpperCase()) {
      case 'ASSETS':
        return (Colors.green, Icons.account_balance_wallet_outlined);
      case 'LIABILITY':
        return (Colors.blue, Icons.savings_outlined);
      case 'EXPENSES':
        return (Colors.red, Icons.trending_down);
      case 'INCOMES':
        return (Colors.teal, Icons.trending_up);
      default:
        return (Colors.grey, Icons.account_balance_outlined);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String name = (item.accountTypeName ?? '-').toString().trim();
    final String locale = (item.accountTypeLocale ?? '').toString().trim();
    final String alias =
    '${item.preAlias ?? ''}${item.postAlias ?? ''}'.trim();
    final String finType = (item.finType ?? '').toString();
    final bool isActive = item.status == true;

    final num minBal = item.minBalCr ?? 0;
    final int? dormancy = item.dormancy;
    final int? digits = item.digits;

    final (color, icon) = _finStyle(finType);

    return Material(
      color: Colors.white,
      elevation: 1.5,
      shadowColor: Colors.black26,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 46,
                    width: 46,
                    decoration: BoxDecoration(
                      color: color.withAlpha(30),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: color),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            _StatusBadge(isActive: isActive),
                          ],
                        ),
                        // Hide locale when it is empty or same as the name
                        if (locale.isNotEmpty && locale != name) ...[
                          const SizedBox(height: 2),
                          Text(
                            locale,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            if (alias.isNotEmpty)
                              _InfoChip(icon: Icons.tag, label: alias),
                            if (finType.isNotEmpty)
                              _InfoChip(
                                icon: Icons.category_outlined,
                                label: finType,
                                color: color,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Key facts row
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    _Stat(
                      label: 'Min Balance',
                      value: minBal > 0
                          ? 'Rs. ${minBal.toStringAsFixed(0)}'
                          : '-',
                    ),
                    _divider(),
                    _Stat(
                      label: 'Dormancy',
                      // 99999 / 999999 means "no limit" in your data
                      value: (dormancy != null && dormancy < 9999)
                          ? '$dormancy days'
                          : '-',
                    ),
                    _divider(),
                    _Stat(
                      label: 'A/C Digits',
                      value: digits?.toString() ?? '-',
                    ),
                  ],
                ),
              ),

              // Feature flags
              Builder(builder: (_) {
                final flags = <String>[
                  if (item.compulsory == true) 'Compulsory',
                  if (item.autoNo == true) 'Auto No',
                  if (item.recurringCr == true) 'Recurring',
                  if (item.periodicCr == true) 'Periodic',
                ];
                if (flags.isEmpty) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: flags
                          .map((f) => _FlagChip(label: f))
                          .toList(),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _divider() =>
      Container(height: 28, width: 1, color: Colors.grey.shade300);
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  const _Stat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}

class _FlagChip extends StatelessWidget {
  final String label;
  const _FlagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColors.withAlpha(120)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 10.5, color: AppColors.primaryColors),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isActive;
  const _StatusBadge({required this.isActive});

  @override
  Widget build(BuildContext context) {
    final color = isActive ? Colors.green : Colors.red;
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isActive ? 'Active' : 'Inactive',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  const _InfoChip({required this.icon, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    final c = color ?? Colors.grey.shade700;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color != null ? color!.withAlpha(25) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: c),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 11, color: c)),
        ],
      ),
    );
  }
}

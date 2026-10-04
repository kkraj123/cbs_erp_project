import 'package:cbs_erp_project/network/core/network/api_state.dart';
import 'package:cbs_erp_project/screens/home_screen/model/category_item_by_logic.dart';
import 'package:cbs_erp_project/screens/login_screen/model/auth_model.dart';
import 'package:cbs_erp_project/screens/more_screen/category_items/add_category_items.dart';
import 'package:cbs_erp_project/screens/more_screen/category_items/provider/cateogry_view_model.dart';
import 'package:cbs_erp_project/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryItemScreen extends ConsumerStatefulWidget {
  final User user;

  const CategoryItemScreen({super.key, required this.user});

  @override
  ConsumerState<CategoryItemScreen> createState() => _CategoryItemScreenState();
}

class _CategoryItemScreenState extends ConsumerState<CategoryItemScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(categoryByLogicProvider.notifier).getCategoryByLogicItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoryByLogicProvider);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Category Item', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColors,
      ),
      body: RefreshIndicator(
        child: _buildCategoryBylogicItems(state, context),
        onRefresh: () => ref
            .read(categoryByLogicProvider.notifier)
            .getCategoryByLogicItems(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryColors,
        onPressed: () async {
          final result = await Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (context) => AddCategoryItems(user: widget.user),
            ),
          );
          if (result == true) {
            ref.read(categoryByLogicProvider.notifier).getCategoryByLogicItems();
          }
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Add Category',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildCategoryBylogicItems(
    ApiState<CategoryItemsByLogic> state,
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
    final categoryByLogicItemList = state.data?.data ?? [];
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 88),
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemCount: categoryByLogicItemList.length,
      itemBuilder: (context, index) {
        return CategoryItemCard(
          item: categoryByLogicItemList[index],
          onTap: () {
            // TODO: open edit / detail screen
          },
        );
      },
    );
  }
}

class CategoryItemCard extends StatelessWidget {
  final dynamic item; // replace with your model type, e.g. CategoryItem
  final VoidCallback? onTap;

  const CategoryItemCard({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final String name = item.categoryName ?? '-';
    final String? locale = item.categoryNameLocale;
    final String? alias = item.categoryAlias;
    final String? parent = item.parentName;
    final String? description = item.description;
    final bool isActive = item.status == true;
    final bool isRoot = parent == null || parent.isEmpty;

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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Leading avatar
              Container(
                height: 46,
                width: 46,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primaryColors.withAlpha(30),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  name.isNotEmpty ? name[0].toUpperCase() : '?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColors,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Main content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            maxLines: 1,
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
                    if (locale != null && locale.isNotEmpty) ...[
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
                        if (alias != null && alias.isNotEmpty)
                          _InfoChip(icon: Icons.tag, label: alias),
                        _InfoChip(
                          icon: isRoot
                              ? Icons.account_tree_outlined
                              : Icons.subdirectory_arrow_right,
                          label: isRoot ? 'Root category' : parent,
                        ),
                      ],
                    ),
                    if (description != null && description.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
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

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: Colors.grey.shade600),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade800),
          ),
        ],
      ),
    );
  }
}

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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCategoryItems(user: widget.user),
            ),
          );
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
    return ListView.builder(
      shrinkWrap: true,
      itemCount: categoryByLogicItemList.length,
      itemBuilder: (context, index) {
        final categoryByLogic = categoryByLogicItemList[index];
        return Padding(padding: const EdgeInsets.all(10),
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            color: AppColors.primaryColors.withAlpha(50),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(padding: const EdgeInsets.all(10), child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5)
                ),
              )
            ],
          ),),
        ),);
      },
    );
  }
}

import 'package:ankh_project/feauture/client_search_screen/search_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/customized_widgets/reusable_widgets/custom_search_bar.dart';
import '../../../domain/entities/all_products_entity.dart';
import 'cubit/search_cubit.dart';
import 'cubit/search_state.dart';

class ClientSearchScreen extends StatefulWidget {
  const ClientSearchScreen({super.key});

  @override
  State<ClientSearchScreen> createState() => _ClientSearchScreenState();
}

class _ClientSearchScreenState extends State<ClientSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AllProductsSearchCubit>().fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.all(16),
          child: Column(
            children: [
              CustomSearchBar(
                controller: _searchController,
                onChanged: (value) =>
                    context.read<AllProductsSearchCubit>().search(value),
              ),
              SizedBox(height: 30.h),
              Expanded(
                child: BlocBuilder<AllProductsSearchCubit, AllProductsSearchState>(
                  builder: (context, state) {
                    return switch (state) {
                      AllProductsLoading() =>
                      const Center(child: CircularProgressIndicator()),
                      AllProductsError() =>
                          Center(child: Text(state.message)),
                      AllProductsEmpty() =>
                      const Center(child: Text("No products found")),
                      AllProductsLoaded() =>
                          _buildProductList(state.filteredProducts),
                      _ => const SizedBox.shrink(),
                    };
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductList(List<AllProductsEntity> products) {
    return ListView.separated(
      itemCount: products.length,
      separatorBuilder: (_, _) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final product = products[index];
        return SearchProductItem(product: product);
      },
    );
  }
}

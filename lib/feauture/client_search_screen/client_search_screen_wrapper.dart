import 'package:ankh_project/feauture/client_search_screen/client_search_screen.dart';
import 'package:ankh_project/feauture/client_search_screen/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ankh_project/api_service/di/di.dart';

class ClientSearchScreenWrapper extends StatelessWidget {
  const ClientSearchScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AllProductsSearchCubit>()..fetchAllProducts(),
      child: const ClientSearchScreen(),
    );

  }
}

import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../api_service/di/di.dart';
import '../../../core/customized_widgets/reusable_widgets/customized_containers/cutomized_container _with_listile.dart';
import '../../../domain/entities/cs_roles_response_entity.dart';
import '../../../l10n/app_localizations.dart';

import '../../authentication/register/register _screen.dart';
import 'choose_cs_role_cubit.dart';
import 'choose_cs_roles_states.dart';



class ChooseCsTypeScreen extends StatelessWidget {
  const ChooseCsTypeScreen({super.key});
  static String chooseCsTypeScreenRouteName ="ChooseCsRoleScreen";


  static Widget withProvider() {
    return BlocProvider(
      create: (context) => getIt<RoleCsCubit>()..fetchRoles(),
      child: const ChooseCsTypeScreen(),
    );
  }


  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RoleCsCubit>();


    return  Scaffold(
      appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){Navigator.of(context).pop();},), ),
      body: Padding(
        padding:  EdgeInsets.only(top: 50.h,right: 18.w,left: 18.w,bottom: 50.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(child: Image.asset(ImageAssets.appIcon,height: 200.h,),backgroundColor: Colors.black,radius: 35.r,),
            SizedBox(height: 15.h,),
            Text(AppLocalizations.of(context)!.chooseRole,style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 26.5.sp),),
            SizedBox(height: 15.h,),
            Text(AppLocalizations.of(context)!.chooseRoleDescribe,style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 15.6.sp,color: ColorManager.darkGrey ),),
            SizedBox(height: 55.h,),
    Expanded(
    child: BlocBuilder<RoleCsCubit, RoleCsState>(
    builder: (context, state) {

   if (state is RoleCsLoading) {
    return const Center(child: CircularProgressIndicator());
    } else if (state is RoleCsError) {
    return Center(child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(state.error?.errorMessage??"",
            style: Theme.of(context).textTheme.bodyMedium,

          ),
          CustomizedElevatedButton(
            bottonWidget: Text(AppLocalizations.of(context)!.tryAgain,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: ColorManager.white,fontSize: 14.sp),
            ),
            color: ColorManager.lightprimary,
            borderColor: ColorManager.lightprimary,
            onPressed: () => cubit.fetchRoles(),
          )
        ],
      ),
    ));
    }else if (state is RoleCsSuccess) {
     final rolesList = state.rolesList;
     final  selectedRole = state.selectedRole;


    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ListView.separated(
                            itemCount: rolesList.length,
                            separatorBuilder: (_, __) => SizedBox(height: 15.h),
                            itemBuilder: (context, index) {
                              final role = rolesList[index];
                              final imageUrl = role.imageUrl != null && role.imageUrl!.isNotEmpty
                                  ? 'https://ankhapi.runasp.net${role.imageUrl}' // Replace with real base URL
                                  :"";
                                print(imageUrl);
                              return ContainerWithListTile(
                                title: role.name ?? '',
                                subtitle: role.description ?? '',
                                image: imageUrl,
                                isSelected: selectedRole?.id == role.id,
                                onTap: () => cubit.selectRole(role),
                              );
                            },
                     ),
        ),
        CustomizedElevatedButton(
            bottonWidget: Text(
              AppLocalizations.of(context)!.continu,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: ColorManager.white),
            ),
            color: ColorManager.lightprimary,
            borderColor: ColorManager.lightprimary,
            onPressed: () {
              final state = cubit.state;
              if (state is RoleCsSuccess && state.selectedRole != null) {
                Navigator.of(context).pushNamed(
                  RegisterScreen.registerScreenRouteName,
                  arguments: state.selectedRole,
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(
                      AppLocalizations.of(context)!.chooseRole)),
                );
              }
            }
        ),
      ],
    );
    }else {
     return SizedBox();
   }
    },
    ),
    ),

            // Continue button



          ],
        ),
      ),
    );
  }
}
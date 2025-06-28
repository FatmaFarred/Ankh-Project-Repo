import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/customized_widgets/reusable_widgets/customized_containers/cutomized_container _with_listile.dart';
import '../../../l10n/app_localizations.dart';

import '../../authentication/register/register _screen.dart';
import 'choose_cs_role_cubit.dart';



class ChooseCsTypeScreen extends StatelessWidget {
  const ChooseCsTypeScreen({super.key});
  static String chooseCsTypeScreenRouteName ="ChooseCsRoleScreen";




  @override
  Widget build(BuildContext context) {
    final selectedRole = context.watch<RoleCsCubit>().state;


    return  Scaffold(
      appBar: AppBar(leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){Navigator.of(context).pop();},), ),
      body: Padding(
        padding:  EdgeInsets.only(top: 50.h,right: 18.w,left: 18.w,bottom: 80.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(child: Image.asset(ImageAssets.appIcon,height: 200.h,),backgroundColor: Colors.black,radius: 35.r,),
            SizedBox(height: 15.h,),
            Text(AppLocalizations.of(context)!.chooseRole,style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 26.5.sp),),
            SizedBox(height: 15.h,),
            Text(AppLocalizations.of(context)!.chooseRoleDescribe,style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 15.6.sp,color: ColorManager.darkGrey ),),
            SizedBox(height: 55.h,),

            ContainerWithListTile(title: AppLocalizations.of(context)!.marketer,
              subtitle: AppLocalizations.of(context)!.marketerDescription,
              image: ImageAssets.marketerIcon,
              isSelected: selectedRole == CsRole.marketer,
              onTap: (){
                //todo: navigate to owner screen
                context.read<RoleCsCubit>().selectCsRole(CsRole.marketer);
              },
            ),

            SizedBox(height: 15.h,),

            ContainerWithListTile(title: AppLocalizations.of(context)!.inspector,
              subtitle: AppLocalizations.of(context)!.inspectorDescription,
              image: ImageAssets.inspectorIcon,
              onTap: (){
                context.read<RoleCsCubit>().selectCsRole(CsRole.inspector);

              },
              isSelected: selectedRole == CsRole.inspector,
            ),
            SizedBox(height: 15.h,),
            ContainerWithListTile(title: AppLocalizations.of(context)!.cst,
              subtitle: AppLocalizations.of(context)!.cstDescription,
              image: ImageAssets.cstIcon,
              onTap: (){
                context.read<RoleCsCubit>().selectCsRole(CsRole.customerService);

              },
              isSelected: selectedRole == CsRole.customerService,

            ),
            Spacer(),

            CustomizedElevatedButton(bottonWidget: Text(AppLocalizations.of(context)!.continu,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: ColorManager.white),),
              color: ColorManager.lightprimary,
              borderColor: ColorManager.lightprimary,
                onPressed: () {
                  print('Selected Role: $selectedRole');

                  if (selectedRole == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(AppLocalizations.of(context)!.chooseRole)),
                    );
                    return;
                  }


                    Navigator.of(context).pushNamed(
                      RegisterScreen.registerScreenRouteName,
                      arguments: selectedRole,
                    );
                  }

            )


          ],),
      ),


    );
  }
}
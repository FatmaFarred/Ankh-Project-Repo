
import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/app_localizations.dart';

class ContainerWithListTile extends StatelessWidget {
  const ContainerWithListTile({super.key, required this.title, required this.subtitle,this.isSelected=false, required this.onTap, required this.image});
  final bool isSelected;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r) ,
        border: Border.all(color: isSelected?ColorManager.lightprimary:ColorManager.lightGrey,width: 2.w)),
      child: ListTile(leading: Image.asset(image),
      title: Text(title,style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 16.sp),),
        subtitle:Text (subtitle,style: Theme.of(context).textTheme.labelMedium?.copyWith(color: ColorManager.darkGrey)),
          trailing: isSelected?Icon(Icons.check_circle,color: ColorManager.lightprimary,):Icon(Icons.circle_outlined,color:ColorManager. lightGrey,),
        onTap:onTap,
      )
        
      
    );
  }
}

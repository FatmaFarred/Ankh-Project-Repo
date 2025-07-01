import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/custom_text_field.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import 'package:ankh_project/core/validator/my_validator.dart';
import 'package:ankh_project/feauture/request_inspection_screen/confirm_request_screen.dart';
import 'package:ankh_project/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestInspectionScreen extends StatefulWidget {
  const RequestInspectionScreen({super.key});

  @override
  State<RequestInspectionScreen> createState() =>
      _RequestInspectionScreenState();
}

class _RequestInspectionScreenState extends State<RequestInspectionScreen> {
  final _formKey = GlobalKey<FormState>();
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back), // Cupertino back icon
          color: Colors.white, // White color
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(AppLocalizations.of(context)!.requestInspection),
        centerTitle: true,
        backgroundColor: ColorManager.lightprimary,
        titleTextStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 20.sp,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: REdgeInsets.symmetric(vertical: 24.0, horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.clientName,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.black,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTextField(
                  hintText: AppLocalizations.of(context)!.enterClientName,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      ValidatorUtils.validateName(value, context),
                ),
                SizedBox(height: 16.h),
                Text(
                  AppLocalizations.of(context)!.phoneNumber,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.black,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTextField(
                  hintText: AppLocalizations.of(context)!.enterPhoneNumber,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      ValidatorUtils.validatePhone(value, context),
                ),
                SizedBox(height: 16.h),
                Text(
                  AppLocalizations.of(context)!.address,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.black,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTextField(
                  hintText: AppLocalizations.of(context)!.enterAddress,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      ValidatorUtils.validateName(value, context),
                ),
                SizedBox(height: 16.h),
                Text(
                  AppLocalizations.of(context)!.preferredDate,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.black,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTextField(
                  hintText: AppLocalizations.of(context)!.datePlaceholder,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: Color(0xffA3A3A3),
                    size: 15.sp,
                  ),
                  suffixIcon: InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.calendar_today_rounded,
                      color: ColorManager.black,
                      size: 15.sp,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  AppLocalizations.of(context)!.preferredTime,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.black,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTextField(
                  hintText: AppLocalizations.of(context)!.selectTimeSlot,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  prefixIcon: Icon(
                    Icons.watch_later_outlined,
                    color: Color(0xffA3A3A3),
                    size: 15.sp,
                  ),
                ),
                SizedBox(height: 28.h),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.saveInfoForLater,
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.black,
                      ),
                    ),
                    Spacer(),
                    Transform.scale(
                      scale: 0.6,
                      child: Switch(
                        value: light,
                        activeColor: ColorManager.lightprimary,
                        onChanged: (bool value) {
                          setState(() {
                            light = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h,),
                CustomizedElevatedButton(
                  bottonWidget: Text(
                    AppLocalizations.of(context)!.next,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorManager.white,
                      fontSize: 16.sp,
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                  borderColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){return ConfirmRequestScreen();}));
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

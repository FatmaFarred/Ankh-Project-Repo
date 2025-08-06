import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ankh_project/feauture/dashboard/marketer_mangemnet/cubit/marketer_management_cubit.dart';
import 'package:ankh_project/feauture/dashboard/marketer_mangemnet/cubit/marketer_management_states.dart';
import 'package:ankh_project/feauture/dashboard/inspector_management/cubit/inspector_management_cubit.dart';
import 'package:ankh_project/core/constants/color_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../api_service/di/di.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/customized_widgets/shared_preferences .dart';
import '../../../../core/customized_widgets/reusable_widgets/custom_dialog.dart';
import '../push_notification/cubit/push_notification_cubit.dart';

class NotificationScreen extends StatefulWidget {
  static const String routeName = '/notification';

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String selectedRecipientType = 'Marketer'; // 'Marketer' or 'Inspector'
  String? selectedMessage;
  String? selectedTitle;
  List<String> selectedUserIds = [];
  List<String> selectedDeviceTokens = [];
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  PushNotificationCubit pushNotificationCubit = getIt<PushNotificationCubit>();

  // Pre-defined message templates
  List<Map<String, String>> messageTemplates = [
    {
      'title': 'رصيد المحفظة منخفض',
      'message': 'رصيد محفظتك منخفض. يرجى إعادة الشحن للاستمرار في قبول الفحوصات.',
    },
    {
      'title': 'تم تعيين فحص جديد',
      'message': 'تم تعيين فحص جديد لك. تحقق من جدولك الآن.',
    },
    {
      'title': 'تم رفض الفحص',
      'message': 'تم رفض الفحص المقدم. يرجى مراجعة الملاحظات.',
    },
    {
      'title': 'لا توجد استجابة من العميل',
      'message': 'لا توجد استجابة من العميل. يرجى المحاولة مرة أخرى أو الإبلاغ عن المشكلة.',
    },
    {
      'title': 'تم جدولة فحص جديد',
      'message': 'تم جدولة فحص جديد لك. لا تنس تأكيد الوقت.',
    },
    {
      'title': 'تحديث مهم',
      'message': 'هناك تحديث مهم في التطبيق. يرجى التحقق من التحديثات الجديدة.',
    },
    {
      'title': 'تذكير بالفحص',
      'message': 'تذكير: لديك فحص مجدول اليوم. تأكد من الاستعداد.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadSavedTemplates();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadRecipients();
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    messageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _loadSavedTemplates() async {
    try {
      final saved = await SharedPrefsManager.getData(key: 'notification_templates');
      if (saved != null) {
        final List<dynamic> jsonList = jsonDecode(saved);
        final List<Map<String, String>> templates = jsonList
            .map((item) => {
          'title': item['title'] as String,
          'message': item['message'] as String,
        })
            .cast<Map<String, String>>() // ✅ Add this line
            .toList();

        setState(() {
          messageTemplates = templates;
        });
        print('📱 Loaded ${templates.length} templates from SharedPreferences');
      } else {
        print('📱 No saved templates found');
      }
    } catch (e) {
      print('❌ Failed to load templates: $e');
    }
  }



  void _loadRecipients() {
    print('🔄 Loading recipients for type: $selectedRecipientType');
    if (selectedRecipientType == 'Marketer') {
      print('📞 Calling fetchMarketers()');
      context.read<MarketerManagementCubit>().fetchMarketers();
    } else {
      print('📞 Calling getAllInspectors()');
      context.read<InspectorManagementCubit>().getAllInspectors();
    }
  }

  void _onMessageSelected(String title, String message) {
    setState(() {
      selectedTitle = title;
      selectedMessage = message;
    });
    _showRecipientSelectionScreen();
  }

  void _showAddNewMessageBottomSheet() {
    // Clear the controllers before showing the bottom sheet
    titleController.clear();
    messageController.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
          padding: EdgeInsets.all(20.w),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

              Row(
              children: [
              Icon(
                Icons.add,
                size: 24.h,
                color: ColorManager.lightprimary,
              ),
              SizedBox(width: 8.w),
              Text(
                'إضافة رسالة جديدة',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              'أدخل عنوان الرسالة ونصها لإضافتها إلى القائمة',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: ColorManager.darkGrey,
              ),
            ),
            SizedBox(height: 20.h),
            TextFormField(

              controller: titleController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال عنوان الرسالة';
                }
                return null;
              },
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: ColorManager.textColor,
              ),
              decoration: InputDecoration(
                labelText: 'عنوان الرسالة',
                labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: ColorManager.darkGrey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: ColorManager.darkGrey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: ColorManager.darkGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: ColorManager.lightprimary),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: ColorManager.error),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: ColorManager.error),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            TextFormField(
              controller: messageController,
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال نص الرسالة';
                }
                return null;
              },
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: ColorManager.textBlack,
              ),
              decoration: InputDecoration(
                labelText: 'نص الرسالة',
                labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: ColorManager.darkGrey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: ColorManager.darkGrey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: ColorManager.darkGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: ColorManager.lightprimary),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: ColorManager.error),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: ColorManager.error),
                ),
              ),
            ),
            SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('إلغاء',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: ColorManager.darkGrey,

                          ),
                          )
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            print('🔘 Button pressed!');
                            print('📝 Title: "${titleController.text}"');
                            print('📝 Message: "${messageController.text}"');
                            
                            if (formKey.currentState!.validate()) {
                              print('✅ Form validation passed');
                              // ✅ 1. Add to in-memory list
                              setState(() {
                                messageTemplates.add({
                                  'title': titleController.text,
                                  'message': messageController.text,
                                });
                              });

                              // ✅ 2. Save updated list to SharedPreferences
                              await _saveTemplatesToPrefs();
                              print('✅ Saved to SharedPreferences');

                              Navigator.pop(context);
                              print('✅ Popped bottom sheet');
                              CustomDialog.positiveButton(
                                context: context,
                                title: 'نجح',
                                message: 'تم إضافة الرسالة الجديدة بنجاح',
                                positiveOnClick: () {
                                  print('✅ Success dialog PRESSED');
                                 },
                              );
                              print('✅ Success dialog called');
                            } else {
                              print('❌ Form validation failed');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.lightprimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text('إضافة',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                            ),

                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _saveTemplatesToPrefs() async {
    final jsonList = jsonEncode(messageTemplates);
    await SharedPrefsManager.saveData(key: 'notification_templates', value: jsonList);
    print('💾 Saved ${messageTemplates.length} templates to SharedPreferences');
  }
  void _showRecipientSelectionScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipientSelectionScreen(
          recipientType: selectedRecipientType,
          selectedMessage: selectedMessage!,
          selectedTitle: selectedTitle!,
          onRecipientsSelected: (userIds, deviceTokens) {
            setState(() {
              selectedUserIds = userIds;
              selectedDeviceTokens = deviceTokens;
            });
          },
        ),
      ),
    );
  }

  void _sendNotification() async {
    if (selectedMessage == null || selectedUserIds.isEmpty) {
      CustomDialog.positiveButton(
        context: context,
        title: AppLocalizations.of(context)!.error,
        message: 'الرجاء اختيار رسالة ومستقبلين',
        positiveOnClick: () {
          Navigator.of(context).pop();
        },
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Get current admin token
      final adminToken = await SharedPrefsManager.getData(key: 'user_token');
      
      if (adminToken == null) {
        CustomDialog.positiveButton(
          context: context,
          title: AppLocalizations.of(context)!.error,
          message: 'يرجى إعادة تسجيل الدخول',
          positiveOnClick: () {
            Navigator.of(context).pop();
          },
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }

      print('📱 Starting notification sending process...');
      print('   Selected User IDs: $selectedUserIds');
      print('   Selected Device Tokens: $selectedDeviceTokens');
      print('   Title: $selectedTitle');
      print('   Message: $selectedMessage');

      // Send notification to each selected recipient
      for (String recipientId in selectedUserIds) {
        // Call the combined method that handles both post and push notifications
        pushNotificationCubit.sendNotificationAndPost(
          userId: recipientId, // This is the marketer/inspector ID
          AdminToken: adminToken,
          message: selectedMessage!,
          title: selectedTitle!,
          body: selectedMessage!,
          tokens: selectedDeviceTokens,
        );

        print('📱 Sending combined notification to recipient:');
        print('   Recipient ID: $recipientId');
        print('   Title: $selectedTitle');
        print('   Body: $selectedMessage');
        print('   Device Tokens: $selectedDeviceTokens');
      }

    } catch (e) {
      print('❌ Error in _sendNotification: $e');
      CustomDialog.positiveButton(
        context: context,
        title: AppLocalizations.of(context)!.error,
        message: 'فشل في إرسال الإشعار: $e',
        positiveOnClick: () {
          Navigator.of(context).pop();
        },
      );
      setState(() {
        _isLoading = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return BlocListener<PushNotificationCubit, PushNotificationState>(
      bloc: pushNotificationCubit,
      listener: (context, state) {
        print('🔄 BlocListener state changed: ${state.runtimeType}');

        if (state is PushNotificationLoading) {
          print('🔄 Push notification loading...');
          CustomDialog.loading(
            context: context,
            message: AppLocalizations.of(context)!.loading,
            cancelable: false,
          );
        } else if (state is PushNotificationSuccess) {
          print('✅ Push notification success with message: ${state.message}');
          Navigator.of(context).pop(); // Close loading dialog
          CustomDialog.positiveButton(
            context: context,
            title: AppLocalizations.of(context)!.success,
            message: state.message ?? 'تم إرسال الإشعار بنجاح',
            positiveOnClick: () {
              setState(() {
                selectedMessage = null;
                selectedTitle = null;
                selectedUserIds.clear();
                selectedDeviceTokens.clear();
                _isLoading = false;
              });
            },
          );
        } else if (state is PushNotificationFailure) {
          print('❌ Push notification failure: ${state.errorMessage ?? state.error?.errorMessage}');
          Navigator.of(context).pop(); // Close loading dialog
          CustomDialog.positiveButton(
            context: context,
            title: AppLocalizations.of(context)!.error,
            message: state.errorMessage ?? state.error?.errorMessage ?? 'حدث خطأ غير متوقع',
            positiveOnClick: () {
              Navigator.of(context).pop();
              setState(() {
                _isLoading = false;
              });
            },
          );
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddNewMessageBottomSheet,
          backgroundColor: ColorManager.lightprimary,
          child: Icon(Icons.add, color: Colors.white),
          tooltip: 'إضافة رسالة جديدة',
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            print('🔄 Pull to refresh triggered');
            _loadRecipients();
            // Add a small delay to show the refresh indicator
            await Future.delayed(Duration(milliseconds: 500));
          },
          color: ColorManager.lightprimary,
          backgroundColor: Colors.white,
          child: Column(
            children: [
              // Recipients Section
              _buildRecipientsSection(),

              // Message Templates Section
              Expanded(
                child: _buildMessageTemplatesSection(),
              ),

              // Send Button
              _buildSendButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecipientsSection() {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'المستقبلون',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16),

          // Recipient Type Toggle
          Container(
            decoration: BoxDecoration(
              color: Color(0xffC6E0BF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedRecipientType = 'Marketer';
                        selectedUserIds.clear();
                        selectedDeviceTokens.clear();
                      });
                      _loadRecipients();
                    },
                    child: Container(
                      margin:EdgeInsets.symmetric(vertical: 8.h,horizontal: 12.w),
                      padding: EdgeInsets.symmetric(vertical: 12.h,horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: selectedRecipientType == 'Marketer'
                            ? Colors.white
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'مسوق',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedRecipientType = 'Inspector';
                        selectedUserIds.clear();
                        selectedDeviceTokens.clear();
                      });
                      _loadRecipients();
                    },
                    child: Container(
                      margin:EdgeInsets.symmetric(vertical: 8.h,horizontal: 12.w),
                      padding: EdgeInsets.symmetric(vertical: 12.h,horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: selectedRecipientType == 'Inspector'
                            ? Colors.white
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'مفتش',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageTemplatesSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: messageTemplates.length,
        itemBuilder: (context, index) {
          final template = messageTemplates[index];
          final isSelected = selectedMessage == template['message'];

          return Container(
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: isSelected ? ColorManager.lightprimary : Color(0xffEBFAEB),
              borderRadius: BorderRadius.circular(16),
            ),
            child: DottedBorder(
              options: RoundedRectDottedBorderOptions(
                dashPattern: [10, 5],
                strokeWidth: 2,
                padding: EdgeInsets.all(16),
                radius: Radius.circular(16),
                color: isSelected ? ColorManager.transparent : ColorManager.lightprimary!,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _onMessageSelected(template['title']!, template['message']!),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                template['title']!,
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.white : ColorManager.textColor,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                template['message']!,
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 14.sp,
                                  color: isSelected ? Colors.white : ColorManager.textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // ✅ Always show delete icon
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            size: 20,
                            color: isSelected ? Colors.white : Colors.red,
                          ),
                          onPressed: () => _deleteMessage(index),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  void _deleteMessage(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('حذف الرسالة'),
        content: Text('هل أنت متأكد من حذف هذه الرسالة؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                messageTemplates.removeAt(index);
              });
              // ✅ Save to SharedPreferences
              _saveTemplatesToPrefs();
              Navigator.pop(ctx); // Close dialog
            },
            child: Text('حذف', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
  Widget _buildSendButton() {
    final canSend = selectedMessage != null && selectedUserIds.isNotEmpty && !_isLoading;

    return Container(
      margin: EdgeInsets.all(16),
      width: 202.w,
      child: ElevatedButton(
        onPressed: canSend ? _sendNotification : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: canSend ? ColorManager.lightprimary : ColorManager.lightGrey,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isLoading
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            ),
            SizedBox(width: 12),
            Text(
              'جاري الإرسال...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
             AppLocalizations.of(context)!.send,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.send, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

// New Recipient Selection Screen
class RecipientSelectionScreen extends StatefulWidget {
  final String recipientType;
  final String selectedMessage;
  final String selectedTitle;
  final Function(List<String> userIds, List<String> deviceTokens) onRecipientsSelected;

  const RecipientSelectionScreen({
    Key? key,
    required this.recipientType,
    required this.selectedMessage,
    required this.selectedTitle,
    required this.onRecipientsSelected,
  }) : super(key: key);

  @override
  _RecipientSelectionScreenState createState() => _RecipientSelectionScreenState();
}

class _RecipientSelectionScreenState extends State<RecipientSelectionScreen> {
  List<String> selectedUserIds = [];
  List<String> selectedDeviceTokens = [];
  final TextEditingController _searchController = TextEditingController();

  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('اختيار المستقبلين'),
        backgroundColor: ColorManager.lightprimary,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            margin: EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'البحث عن ${widget.recipientType == 'Marketer' ? 'مسوق' : 'مفتش'}...',
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: ColorManager.darkGrey,
                ),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: ColorManager.lightGrey)
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: ColorManager.lightGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: ColorManager.lightGrey),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),

          // Recipients List
          Expanded(
            child: _buildRecipientsList(),
          ),

          // Action Buttons
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        selectedUserIds.clear();
                        selectedDeviceTokens.clear();
                      });
                    },
                    child: Text('إلغاء التحديد',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                       color: ColorManager.lightprimary

                    )
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: selectedUserIds.isNotEmpty ? () {
                      widget.onRecipientsSelected(selectedUserIds, selectedDeviceTokens);
                      Navigator.pop(context);
                    } : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.lightprimary,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'تأكيد (${selectedUserIds.length})',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientsList() {
    if (widget.recipientType == 'Marketer') {
      return BlocBuilder<MarketerManagementCubit, MarketerManagementState>(
        builder: (context, state) {
          print('🔍 MarketerManagement State: $state'); // Debug print

          if (state is MarketerManagementLoading) {
            return Center(child: CircularProgressIndicator(color: ColorManager.lightprimary));
          } else if (state is MarketerManagementSuccess) {
            print('✅ Marketers loaded: ${state.marketersList.length} marketers'); // Debug print
            List filteredMarketers = state.marketersList.where((marketer) {
              if (_searchController.text.isEmpty) return true;
              return (marketer.fullName != null &&
                  marketer.fullName!.toLowerCase().contains(_searchController.text.toLowerCase())) ||
                  (marketer.email != null &&
                      marketer.email!.toLowerCase().contains(_searchController.text.toLowerCase()));

            }).toList();

            if (filteredMarketers.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people_outline, size: 48, color: Colors.grey),
                    SizedBox(height: 8),
                    Text(
                        _searchController.text.isEmpty
                            ? 'لا توجد مسوقين متاحين'
                            : 'لا توجد نتائج للبحث',
                        style: TextStyle(color: Colors.grey)
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              itemCount: filteredMarketers.length,
              itemBuilder: (context, index) {
                final marketer = filteredMarketers[index];
                final isSelected = selectedUserIds.contains(marketer.id);

                return Card(
                  color: Colors.grey[200],

                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ListTile(

                    leading: CircleAvatar(
                      backgroundColor: isSelected ? ColorManager.lightprimary : Colors.grey[400],
                      child: Text(
                        marketer.fullName?.substring(0, 1).toUpperCase() ?? 'M',
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      marketer.fullName ?? 'مسوق',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: isSelected ? ColorManager.lightprimary : Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      marketer.email ?? 'لا يوجد بريد إلكتروني',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    trailing: isSelected
                        ? Icon(Icons.check_circle, color: ColorManager.lightprimary)
                        : Icon(Icons.radio_button_unchecked, color: Colors.grey),
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedUserIds.remove(marketer.id);
                          // Remove all device tokens for this marketer
                          if (marketer.deviceTokens != null) {
                            selectedDeviceTokens.removeWhere((token) =>
                                marketer.deviceTokens!.contains(token));
                          }
                        } else {
                          selectedUserIds.add(marketer.id);
                          // Add all device tokens for this marketer
                          if (marketer.deviceTokens != null) {
                            for (String token in marketer.deviceTokens!) {
                              if (token.isNotEmpty && !selectedDeviceTokens.contains(token)) {
                                selectedDeviceTokens.add(token);
                              }
                            }
                          }
                        }
                      });
                    },
                  ),
                );
              },
            );
          } else if (state is MarketerManagementError) {
            print('❌ MarketerManagement Error: ${state.error.errorMessage}'); // Debug print
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: ColorManager.darkGrey),
                  SizedBox(height: 8),
                  Text(
                    'خطأ في تحميل البيانات',
                    style: TextStyle(color: ColorManager.darkGrey, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    state.error.errorMessage ?? 'حدث خطأ غير متوقع',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<MarketerManagementCubit>().fetchMarketers();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.lightprimary,
                    ),
                    child: Text(
                      'إعادة المحاولة',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is MarketerManagementEmpty) {
            print('📭 No marketers found'); // Debug print
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 48, color: Colors.grey),
                  SizedBox(height: 8),
                  Text(
                      'لا توجد مسوقين متاحين',
                      style: TextStyle(color: Colors.grey)
                  ),
                ],
              ),
            );
          } else {
            print('❓ Unknown state: $state'); // Debug print
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: Colors.grey),
                  SizedBox(height: 8),
                  Text('خطأ في تحميل البيانات', style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }
        },
      );
    } else {
      return BlocBuilder<InspectorManagementCubit, InspectorManagementState>(
        builder: (context, state) {
          print('🔍 InspectorManagement State: $state'); // Debug print

          if (state is InspectorManagementLoading) {
            return Center(child: CircularProgressIndicator(color: ColorManager.lightprimary));
          } else if (state is InspectorManagementSuccess) {
            print('✅ Inspectors loaded: ${state.inspectors.length} inspectors'); // Debug print
            List filteredInspectors = state.inspectors.where((inspector) {
              if (_searchController.text.isEmpty) return true;
              return (inspector.fullName != null &&
                  inspector.fullName!.toLowerCase().contains(_searchController.text.toLowerCase())) ||
                  (inspector.email != null &&
                      inspector.email!.toLowerCase().contains(_searchController.text.toLowerCase()));

            }).toList();

            if (filteredInspectors.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people_outline, size: 48, color: Colors.grey),
                    SizedBox(height: 8),
                    Text(
                        _searchController.text.isEmpty
                            ? 'لا توجد مفتشين متاحين'
                            : 'لا توجد نتائج للبحث',
                        style: TextStyle(color: Colors.grey)
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              itemCount: filteredInspectors.length,
              itemBuilder: (context, index) {
                final inspector = filteredInspectors[index];
                final isSelected = selectedUserIds.contains(inspector.id);

                return Card(
                  color: Colors.grey[200],
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isSelected ? ColorManager.lightprimary : Colors.grey[400],
                      child: Text(
                        inspector.fullName?.substring(0, 1).toUpperCase() ?? 'I',
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      inspector.fullName ?? 'مفتش',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: isSelected ? ColorManager.lightprimary : Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      inspector.email ?? 'لا يوجد بريد إلكتروني',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    trailing: isSelected
                        ? Icon(Icons.check_circle, color: ColorManager.lightprimary)
                        : Icon(Icons.radio_button_unchecked, color: Colors.grey),
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedUserIds.remove(inspector.id);
                          // Remove all device tokens for this inspector
                          if (inspector.deviceTokens != null) {
                            selectedDeviceTokens.removeWhere((token) =>
                                inspector.deviceTokens!.contains(token));
                          }
                        } else {
                          selectedUserIds.add(inspector.id);
                          // Add all device tokens for this inspector
                          if (inspector.deviceTokens != null) {
                            for (String token in inspector.deviceTokens!) {
                              if (token.isNotEmpty && !selectedDeviceTokens.contains(token)) {
                                selectedDeviceTokens.add(token);
                              }
                            }
                          }
                        }
                      });
                    },
                  ),
                );
              },
            );
          } else if (state is InspectorManagementFailure) {
            print('❌ InspectorManagement Error: ${state.error.errorMessage}'); // Debug print
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: ColorManager.darkGrey),
                  SizedBox(height: 8),
                  Text(
                    'خطأ في تحميل البيانات',
                    style: TextStyle(color: ColorManager.darkGrey, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    state.error.errorMessage ?? 'حدث خطأ غير متوقع',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<InspectorManagementCubit>().getAllInspectors();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.lightprimary,
                    ),
                    child: Text(
                      'إعادة المحاولة',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is InspectorManagementEmpty) {
            print('📭 No inspectors found'); // Debug print
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 48, color: Colors.grey),
                  SizedBox(height: 8),
                  Text(
                      'لا توجد مفتشين متاحين',
                      style: TextStyle(color: Colors.grey)
                  ),
                ],
              ),
            );
          } else {
            print('❓ Unknown inspector state: $state'); // Debug print
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: Colors.grey),
                  SizedBox(height: 8),
                  Text('خطأ في تحميل البيانات', style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }
        },
      );
    }
  }
} 
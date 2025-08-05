import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/color_manager.dart';
import '../../../core/customized_widgets/reusable_widgets/customized_elevated_button.dart';
import '../../../domain/entities/price_offer_pending_entity.dart';
import '../../../l10n/app_localizations.dart';
import '../../inspector_screen/widgets/custom_text_form_field.dart';
import 'cubit/price_offer_cubit.dart';

class PriceOfferBottomSheet  extends StatelessWidget {
  final PriceOfferPendingEntity offers;
  final int statusNum;

  PriceOfferBottomSheet ({super.key, required this.offers,required this.statusNum});

  final TextEditingController noteController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<PriceOfferCubit>(),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Enter Note',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: noteController,
              hintText: 'Note',
              keyBoardType: TextInputType.text,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: CustomizedElevatedButton(
                    onPressed: () async {
                      final note = noteController.text.trim();

                      if (note.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Note cannot be empty')),
                        );
                        return;
                      }

                      try {
                        // Update offer status
                        await context.read<PriceOfferCubit>().updatePriceOfferStatus(
                          id: "${offers.id}",
                          status: statusNum,
                          adminNote: note,
                        );

                        // Refresh the list
                        await context.read<PriceOfferCubit>().fetchPendingPriceOffers();

                        // Optional: small delay to allow state emission before closing
                        Future.delayed(const Duration(milliseconds: 100), () {
                          Navigator.pop(context); // Close the dialog/screen
                        });

                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Offer accepted successfully')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to submit note: $e')),
                        );
                      }
                    }
                    ,

                    color: ColorManager.lightprimary,
                    bottonWidget: Text(
                      AppLocalizations.of(context)!.submit,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorManager.white,
                        fontSize: 16.sp,
                      ),
                    ),),
                ),
                SizedBox(width: 8.w,),
                Expanded(
                  child: CustomizedElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    color: ColorManager.white,
                    bottonWidget: Text(
                      AppLocalizations.of(context)!.cancel,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorManager.lightprimary,
                        fontSize: 16.sp,
                      ),
                    ),),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

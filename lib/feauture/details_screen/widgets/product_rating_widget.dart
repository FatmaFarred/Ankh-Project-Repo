import 'package:ankh_project/feauture/details_screen/cubit/rating_cubit.dart';
import 'package:ankh_project/feauture/details_screen/cubit/rating_states.dart';
import 'package:ankh_project/l10n/global_localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ankh_project/core/customized_widgets/reusable_widgets/custom_dialog.dart';

import '../../../core/customized_widgets/shared_preferences .dart';

class ProductRatingWidget extends StatefulWidget {
  final num productId;

  const ProductRatingWidget({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  State<ProductRatingWidget> createState() => _ProductRatingWidgetState();
}

class _ProductRatingWidgetState extends State<ProductRatingWidget> {
  final TextEditingController _commentController = TextEditingController();
  double _rating = 0;
  String? _userToken;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _userToken = await SharedPrefsManager.getUserToken();
    _userId = await SharedPrefsManager.getUserId();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RatingCubit, RatingState>(
      listener: (context, state) {
        if (state is RatingSuccess) {
          Navigator.pop(context);
          CustomDialog.showCustomDialog(
            context: context,
            title: GlobalLocalization.of(context).productRating,
            message: state.message,
            confirmButtonText: GlobalLocalization.of(context).ok,
          );
          context.read<RatingCubit>().resetState();
        } else if (state is RatingError) {
          Navigator.pop(context);
          CustomDialog.showCustomDialog(
            context: context,
            title: GlobalLocalization.of(context).error,
            message: state.error.errorMessage ?? GlobalLocalization.of(context).error,
            confirmButtonText: GlobalLocalization.of(context).ok,
          );
          context.read<RatingCubit>().resetState();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              GlobalLocalization.of(context).rateThisProduct,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: GlobalLocalization.of(context).ratingComment,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            BlocBuilder<RatingCubit, RatingState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: state is RatingLoading
                      ? null
                      : () {
                          if (_userToken == null || _userId == null) {
                            CustomDialog.showCustomDialog(
                              context: context,
                              title: GlobalLocalization.of(context).login,
                              message: GlobalLocalization.of(context).pleaseLoginFirst,
                              confirmButtonText: GlobalLocalization.of(context).ok,
                            );
                            return;
                          }

                          if (_rating == 0) {
                            CustomDialog.showCustomDialog(
                              context: context,
                              title: GlobalLocalization.of(context).error,
                              message: GlobalLocalization.of(context).enterYourRate,
                              confirmButtonText: GlobalLocalization.of(context).ok,
                            );
                            return;
                          }

                          context.read<RatingCubit>().addProductRating(
                            productId: widget.productId,
                            userId: _userId!.toString(),
                            stars: _rating,
                            comment: _commentController.text,
                            token: _userToken!,
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: state is RatingLoading
                      ? const CircularProgressIndicator()
                      : Text(GlobalLocalization.of(context).submitRating),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
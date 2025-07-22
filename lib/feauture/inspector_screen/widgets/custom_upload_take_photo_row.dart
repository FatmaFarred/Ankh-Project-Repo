import 'dart:io';

import 'package:ankh_project/feauture/details_screen/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class CustomPhotoButtons extends StatefulWidget {
  final void Function(List<XFile>) onImagesSelected;

  const CustomPhotoButtons({
    Key? key,
    required this.onImagesSelected,
  }) : super(key: key);

  @override
  State<CustomPhotoButtons> createState() => _CustomPhotoButtonsState();
}

class _CustomPhotoButtonsState extends State<CustomPhotoButtons> {
  List<XFile> _selectedImages = [];

  Future<void> _pickImages() async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile>? pickedFiles = await picker.pickMultiImage();
      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        setState(() {
          _selectedImages = pickedFiles;
        });
        widget.onImagesSelected(pickedFiles);
      }
    } catch (e) {
      debugPrint("Error picking images: $e");
    }
  }

  Future<void> _takePhoto() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        setState(() {
          _selectedImages = [photo];
        });
        widget.onImagesSelected([photo]);
      }
    } catch (e) {
      debugPrint("Error taking photo: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff777777).withOpacity(0.5)),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: "Inspector Details"),
          SizedBox(height: 20.h),
          if (_selectedImages.isEmpty)
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _pickImages,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6F4EA),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.green),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.upload, color: Colors.green),
                          SizedBox(width: 8.w),
                          Text(
                            "Upload",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: GestureDetector(
                    onTap: _takePhoto,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F0FE),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.camera_alt, color: Colors.blue),
                          SizedBox(width: 8.w),
                          Text(
                            "Take Photo",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            Wrap(
              spacing: 10.w,
              runSpacing: 10.h,
              children: _selectedImages.map((img) {
                return Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.file(
                      File(img.path),
                      width: 100.w,
                      height: 100.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}

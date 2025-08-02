import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ankh_project/core/constants/assets_manager.dart';
import 'package:ankh_project/api_service/api_constants.dart';

class ProfileImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final VoidCallback? onTap;
  final bool showLoadingState;

  const ProfileImageWidget({
    Key? key,
    this.imageUrl,
    this.size = 50,
    this.onTap,
    this.showLoadingState = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: Container(
          width: size.w,
          height: size.w,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(size / 2),
          ),
          child: imageUrl != null
              ? Image.network(
                  "${ApiConstant.imageBaseUrl}$imageUrl",
                  width: size.w,
                  height: size.w,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    
                    if (showLoadingState) {
                      return Container(
                        width: size.w,
                        height: size.w,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(size / 2),
                        ),
                        child: Center(
                          child: SizedBox(
                            width: (size * 0.4).w,
                            height: (size * 0.4).w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.shade600),
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        ),
                      );
                    }
                    
                    return Container(
                      width: size.w,
                      height: size.w,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(size / 2),
                      ),
                      child: Icon(
                        Icons.person,
                        size: (size * 0.5).w,
                        color: Colors.grey.shade600,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: size.w,
                      height: size.w,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(size / 2),
                      ),
                      child: Icon(
                        Icons.person,
                        size: (size * 0.5).w,
                        color: Colors.grey.shade600,
                      ),
                    );
                  },
                )
              : showLoadingState
                  ? Container(
                      width: size.w,
                      height: size.w,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(size / 2),
                      ),
                      child: Center(
                        child: SizedBox(
                          width: (size * 0.4).w,
                          height: (size * 0.4).w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.shade600),
                          ),
                        ),
                      ),
                    )
                  : Image.asset(
                      ImageAssets.profilePic, // This will show app logo for visitors
                      width: size.w,
                      height: size.w,
                      fit: BoxFit.cover,
                    ),
        ),
      ),
    );
  }
} 
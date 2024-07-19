import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeleton_text/skeleton_text.dart';

class LoadingMediaItem extends StatelessWidget {
  const LoadingMediaItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      child: Container(
        margin: EdgeInsets.all(14.sp),
        padding: EdgeInsets.symmetric(vertical:  8.sp),
        height: 180.h,
        width: double.infinity,
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),color: Colors.grey[300],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 15.h,
              width: 100.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.sp),
                color: Colors.grey[400],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.sp),
              child: Container(
                height: 120.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.sp),
                  color: Colors.grey[400],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

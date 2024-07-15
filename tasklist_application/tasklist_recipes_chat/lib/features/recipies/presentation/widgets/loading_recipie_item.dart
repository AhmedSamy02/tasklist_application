import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeleton_text/skeleton_text.dart';

class LoadingRecipieItem extends StatelessWidget {
  const LoadingRecipieItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      child: Container(
        margin: EdgeInsets.all(18.sp),
        height: 100.sp,
        width: double.infinity,
        // decoration: BoxDecoration(
        color: Colors.grey[200],
        // ),
        child: Row(
          children: [
            Expanded(
              child: Card(
                child: Container(
                  height: 100.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    color: Colors.grey[400],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(left: 15.sp, top: 5.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 15.h,
                      width: 200.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.sp),
                      child: Container(
                        height: 15.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 30.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.dg),
                            color: Colors.grey[400],
                          ),
                        ),
                        Container(
                          height: 30.h,
                          width: 30.w,
                          margin: EdgeInsets.only(left: 10.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.dg),
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

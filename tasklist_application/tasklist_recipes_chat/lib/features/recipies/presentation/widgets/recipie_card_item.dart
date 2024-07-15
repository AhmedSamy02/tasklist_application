import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecipieItemCard extends StatelessWidget {
  const RecipieItemCard({
    super.key,
    required this.time,
    required this.icon,
  });

  final int time;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.sp,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.dg),
      ),
      child: Padding(
        padding: EdgeInsets.all(5.sp),
        child: Column(
          children: [
            SvgPicture.asset(
              icon,
              color: Colors.deepOrange[500],
              height: 22.sp,
              width: 22.sp,
            ),
            Text(
              '$time mins',
              style: TextStyle(
                  fontSize: 8.sp,
                  color: Colors.deepOrange[300],
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

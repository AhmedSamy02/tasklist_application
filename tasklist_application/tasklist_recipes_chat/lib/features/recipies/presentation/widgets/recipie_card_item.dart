import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecipieItemCard extends StatelessWidget {
  const RecipieItemCard({
    super.key,
    required this.time,
    required this.icon,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
    this.fontSize,
    this.iconSize, this.padding,
  });

  final int time;
  final String icon;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final double? fontSize;
  final double? iconSize;
  final double? padding;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.sp,
      color: backgroundColor ?? Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.dg),
      ),
      child: Padding(
        padding: EdgeInsets.all(padding ?? 5.sp),
        child: Column(
          children: [
            SvgPicture.asset(
              icon,
              color: iconColor ?? Colors.deepOrange[500],
              height: iconSize ?? 22.sp,
              width: iconSize ?? 22.sp,
            ),
            Text(
              '$time mins',
              style: TextStyle(
                  fontSize: fontSize ?? 8.sp,
                  color: textColor ?? Colors.deepOrange[300],
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

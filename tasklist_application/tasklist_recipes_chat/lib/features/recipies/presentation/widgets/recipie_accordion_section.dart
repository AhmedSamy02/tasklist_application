import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AccordionSection recipieAccordionSection({
  required String title,
  required String value,
  required IconData icon,
  required Color color,
  required Color borderColor,
  bool? isOpen,
}) {
  return AccordionSection(
    isOpen: isOpen??false,
      header: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 17.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      leftIcon: Icon(
        icon,
        color: Colors.grey[300],
      ),
      headerBackgroundColor: color,
      contentBorderColor: borderColor,
      contentVerticalPadding: 8.sp,
      headerPadding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.sp),
      content: Text(
        value,
        style: TextStyle(fontSize: 15.sp),
      ));
}

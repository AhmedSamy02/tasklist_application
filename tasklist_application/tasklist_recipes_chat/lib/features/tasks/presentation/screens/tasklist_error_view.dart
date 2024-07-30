import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TasklistErrorView extends StatelessWidget {
  const TasklistErrorView({
    super.key,
    required this.message,
  });
  final String message;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          size: 50.sp,
          color: const Color(0xffaf0b09),
        ),
        Padding(
          padding: EdgeInsets.all(18.sp),
          child: SizedBox(
            width: 200.w,
            child: Text(
              message,
              maxLines: 3,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xffaf0b09),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

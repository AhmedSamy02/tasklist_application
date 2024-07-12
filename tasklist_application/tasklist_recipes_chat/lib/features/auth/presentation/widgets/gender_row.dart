import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderRow extends StatelessWidget {
  const GenderRow({super.key, this.onChanged});
  final void Function(String? value)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Gender',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,),
        ),
        const Spacer(),
        DropdownButton<String>(
          value: 'Male',
          items: const [
            DropdownMenuItem(
              value: 'Male',
              child: Text('Male'),
            ),
            DropdownMenuItem(
              value: 'Female',
              child: Text('Female'),
            ),
          ],
          onChanged: onChanged,
        )
      ],
    );
  }
}

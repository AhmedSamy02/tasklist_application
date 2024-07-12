import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FullNameRow extends StatelessWidget {
  const FullNameRow(
      {super.key,
      required this.firstNameController,
      required this.lastNameController});
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: firstNameController,
            validator: (value) {
              if (value != null && value.isEmpty) {
                return 'Please enter your first name';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              label: Text('First Name'),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: TextFormField(
            controller: lastNameController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value != null && value.isEmpty) {
                return 'Please enter your last name';
              }
              return null;
            },
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              label: Text('Last Name'),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}

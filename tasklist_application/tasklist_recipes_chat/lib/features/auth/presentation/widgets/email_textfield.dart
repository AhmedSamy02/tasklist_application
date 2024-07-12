import 'package:flutter/material.dart';

class EmailTextfield extends StatelessWidget {
  const EmailTextfield({
    super.key,
    required this.emailController,
    this.initialValue,
    required this.enabled,
    this.textInputAction,
  });
  final TextEditingController emailController;
  final String? initialValue;
  final bool enabled;
  final TextInputAction? textInputAction;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value != null && value.isEmpty) {
          return 'Please enter your email';
        }
        if (value != null &&
            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
      
      initialValue: initialValue,
      controller: emailController,
      enabled: enabled,
      keyboardType: TextInputType.emailAddress,
      maxLines: 1,
      textInputAction: textInputAction ?? TextInputAction.next,
      
      decoration:  InputDecoration(
        fillColor: enabled?Colors.transparent:Colors.grey[500],
          focusedBorder:const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo, width: 2.0),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          disabledBorder:const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2.0),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          border:const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2.0),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          labelText: 'Email',
          floatingLabelStyle: const TextStyle( fontSize: 18,)
          ),
    );
  }
}

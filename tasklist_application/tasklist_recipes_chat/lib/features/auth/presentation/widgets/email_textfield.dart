import 'package:flutter/material.dart';

class EmailTextfield extends StatelessWidget {
  const EmailTextfield({
    super.key,
    required this.emailController,
    this.initialValue,
    required this.enabled,
  });
  final TextEditingController emailController;
  final String? initialValue;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: emailController,
      enabled: enabled,
      keyboardType: TextInputType.emailAddress,
      maxLines: 1,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo, width: 2.0),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2.0),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          labelText: 'Email',
          floatingLabelStyle: TextStyle(color: Colors.indigo, fontSize: 18)),
    );
  }
}

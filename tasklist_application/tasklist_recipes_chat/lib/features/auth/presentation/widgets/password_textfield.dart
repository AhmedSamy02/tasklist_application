import 'package:flutter/material.dart';

class PasswordTextfield extends StatefulWidget {
  const PasswordTextfield({
    super.key,
    required this.controller,
    required this.textInputAction,
    this.validator,
    this.labelText,
  });
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String? Function(String? value)? validator;
  final String? labelText;
  @override
  State<PasswordTextfield> createState() => _PasswordTextfieldState();
}

class _PasswordTextfieldState extends State<PasswordTextfield> {
  bool shown = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: !shown,
      maxLines: 1,
      autovalidateMode:
          widget.validator != null ? AutovalidateMode.onUserInteraction : null,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.indigo, width: 2.0),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        label: Text(widget.labelText ?? 'Password'),
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                shown = !shown;
              });
            },
            icon: Icon(
              Icons.remove_red_eye,
              color: Colors.grey[800],
            )),
      ),
    );
  }
}

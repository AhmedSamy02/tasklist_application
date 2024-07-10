import 'package:flutter/material.dart';

class PasswordTextfield extends StatefulWidget {
  const PasswordTextfield({
    super.key,
    required this.controller,
    required this.textInputAction,
  });
  final TextEditingController controller;
  final TextInputAction textInputAction;
  @override
  State<PasswordTextfield> createState() => _PasswordTextfieldState();
}

class _PasswordTextfieldState extends State<PasswordTextfield> {
  bool shown = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: !shown,
      maxLines: 1,
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
          labelText: 'Password',
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  shown = !shown;
                });
              },
              icon: Icon(
                Icons.remove_red_eye_outlined,
                color: Colors.grey[600],
              )),
          floatingLabelStyle:
              const TextStyle(color: Colors.indigo, fontSize: 18)),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsTile extends StatelessWidget {
  const DetailsTile({super.key, required this.title, required this.value, required this.padding});
  final String title;
  final String value;
  final double padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.cookie(
              fontSize: 26.sp,
              color: Colors.deepOrange[900],
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

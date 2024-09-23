import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CategoryButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const CategoryButton(
      {required this.text, this.isSelected = false, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xff4361EE) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color:
                  text == "All notes" ? Color(0xff4361EE) : Color(0xff5F5F5F),
            ),
          ),
          child: Text(
            text,
            style: GoogleFonts.outfit(
              color: isSelected ? Color(0xffFFFFFF) : Color(0xffFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}

class Notescard extends StatelessWidget {
  final String title;
  final DateTime date;
  final String description;

  const Notescard({
    required this.title,
    required this.date,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('d MMM').format(date);
    return Card(
      color: Color(0xFF1F2028),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formattedDate,
              style: GoogleFonts.outfit(
                color: Color(0xff4361EE),
                fontSize: 14.sp,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontSize: 28.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.outfit(
                color: Colors.white24,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}

class NotescardView extends StatelessWidget {
  final String title;
  final String description;
  const NotescardView({
    required this.title,
    required this.description,
  }) : super();

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('d MMM').format(DateTime.now());
    return Card(
      color: Color(0xFF1F2028),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formattedDate,
              style: GoogleFonts.outfit(
                color: Color(0xff4361EE),
                fontSize: 14.sp,
              ),
            ),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontSize: 28.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.outfit(
                color: Colors.white24,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}

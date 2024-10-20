import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mind_pad/app/modules/edit/views/edit_view.dart';

import '../modules/AddNotes/views/add_notes_view.dart';

class CategoryButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const CategoryButton({
    required this.text,
    this.isSelected = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.2.h, vertical: 8.w),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xff4361EE) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? const Color(0xff4361EE)
                  : const Color(0xff5F5F5F),
            ),
          ),
          child: Text(
            text,
            style: GoogleFonts.outfit(
              color: const Color(0xffFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}

class Notescard extends StatelessWidget {
  final String title;
  final String? timestamp;
  final String description;
  final String docId;

  const Notescard({
    required this.title,
    this.timestamp,
    required this.description,
    required this.docId,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate;
    if (timestamp != null) {
      try {
        DateTime savedTime = DateTime.parse(timestamp!);
        formattedDate = DateFormat('d MMM').format(savedTime);
      } catch (e) {
        formattedDate = 'Invalid date';
      }
    } else {
      formattedDate = 'No Date';
    }
    return GestureDetector(
      onTap: () {
        Get.to(() => EditView(
          docId: docId,
          title: title,
          description: description,
        ));
      },
      child: Card(
        color: const Color(0xFF1F2028),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formattedDate,
                style: GoogleFonts.outfit(
                  color: const Color(0xff4361EE),
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.h,
                ),
              ),
              SizedBox(
                height: 5.h,
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
      ),
    );
  }
}
class NotescardView extends StatelessWidget {
  final String title;
  final String description;
  final String? timestamp;
  final String docId;
  const NotescardView({
    required this.title,
    required this.description, this.timestamp,required this.docId,
  }) : super();

  @override
  Widget build(BuildContext context) {
        String formattedDate;
    if (timestamp != null) {
      try {
        DateTime savedTime = DateTime.parse(timestamp!);
        formattedDate = DateFormat('d MMM, yy').format(savedTime);
      } catch (e) {
        formattedDate = 'Invalid date';
      }
    } else {
      formattedDate = 'No Date';
    }

    return Scaffold(
      backgroundColor: const Color(0xff15161E),
      appBar: AppBar(
        backgroundColor: const Color(0xff15161E),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xffffffff)),
        title: Text(
          'Notes View',
          style: GoogleFonts.outfit(
            fontSize: 20.sp,
            color: const Color(0xffFFFFFF),
          ),
        ),
        actions: [
          SizedBox(width: 5.w),
          ElevatedButton(
            onPressed: () {
             Get.to(() => EditView(
                docId: docId,
                title: title,
                description: description,
              ));
            },
            child: Text(
              'Edit',
              style: GoogleFonts.outfit(
                color: const Color(0xffffffff),
              ),
            ),
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                Color(0xff4361EE),
              ),
            ),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0.r),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Date: $formattedDate',
                  style: GoogleFonts.outfit(
                    color: const Color(0xff8F8F93),
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity.h,
              height: MediaQuery.of(context).size.height,
              color: const Color(0xff1F2028),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.h,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    description,
                    style: GoogleFonts.outfit(
                      color: Colors.white24,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Get.to(AddNotesView());
        },
        child: Icon(
          CupertinoIcons.sparkles,
          size: 26.r,
          color: const Color(0xffffffff),
        ),
        backgroundColor: const Color(0xff4361EE),
      ),
    );
  }
}

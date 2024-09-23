import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mind_pad/app/modules/home/views/home_view.dart';

import '../controllers/add_notes_controller.dart';

class AddNotesView extends GetView<AddNotesController> {
  AddNotesView({super.key});

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> addTaskToFirebase() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      String uid = user.uid;
      var time = DateTime.now();
      await FirebaseFirestore.instance
          .collection('tasks')
          .doc(uid)
          .collection('mytasks')
          .doc(time.toString())
          .set({
        'title': titleController.text,
        'description': descriptionController.text,
        'time': time.toString(),
        'timestamp': time,
      });

      Fluttertoast.showToast(msg: 'Data Added');
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('d MMM, yy').format(DateTime.now());
    
    return Scaffold(
      backgroundColor: const Color(0xff15161E),
      appBar: AppBar(
        backgroundColor: const Color(0xff15161E),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xffffffff)),
        title: Text(
          'Add a note',
          style: GoogleFonts.outfit(
            fontSize: 20,
            color: const Color(0xffFFFFFF),
          ),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xff1F2028),
            ),
            child: IconButton(
              icon: const Icon(Icons.push_pin, color: Color(0xffFFFFFF)),
              onPressed: () {
                // Pin logic here
              },
            ),
          ),
          SizedBox(width: 5.w),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xff1F2028),
            ),
            child: IconButton(
              icon: const Icon(Icons.save, color: Color(0xffFFFFFF)),
              onPressed: () {},
            ),
          ),
          SizedBox(width: 5.w),
          ElevatedButton(
            onPressed: () {
              addTaskToFirebase();

            },
            child: Text(
              'Save',
              style: GoogleFonts.outfit(color: const Color(0xffffffff)),
            ),
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Color(0xff4361EE))),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Date: $formattedDate',
                style: GoogleFonts.outfit(
                  color: const Color(0xff8F8F93),
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: const Color(0xff1F2028),
              ),
              child: TextField(
                controller: titleController,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xffFFFFFF),
                ),
                decoration: const InputDecoration(
                  hintText: 'Your note title here...',
                  hintStyle: TextStyle(
                    color: Color(0xff8F8F93),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: Container(
                height: 500.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: const Color(0xff1F2028),
                ),
                child: SingleChildScrollView(
                  child: TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      hintText: 'Your note content here...',
                      hintStyle: TextStyle(
                        color: Color(0xff8F8F93),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                    maxLines: null,
                    textAlignVertical: TextAlignVertical.top,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

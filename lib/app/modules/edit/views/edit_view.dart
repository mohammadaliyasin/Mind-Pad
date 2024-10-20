import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/edit_controller.dart';

class EditView extends StatefulWidget {
  final String? title;
  final String? description;
  final String docId;

  const EditView({this.title, this.description, required this.docId, super.key});

  @override
  _EditViewState createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  final EditController controller = Get.put(EditController());
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.title ?? '';
    descriptionController.text = widget.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff15161E),
      appBar: AppBar(
        backgroundColor: const Color(0xff15161E),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xffffffff)),
        title: Text(
          'Edit Note',
          style: GoogleFonts.outfit(
            fontSize: 20.sp,
            color: const Color(0xffFFFFFF),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              controller.updateNote(
                widget.docId,
                titleController.text,
                descriptionController.text,
              );
            },
            child: Text(
              'Save',
              style: GoogleFonts.outfit(color: const Color(0xffffffff)),
            ),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Color(0xff4361EE)),
            ),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
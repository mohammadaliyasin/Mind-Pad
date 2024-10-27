import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../home/views/home_view.dart';
import '../controllers/add_notes_controller.dart';

class AddNotesView extends GetView<AddNotesController> {
  const AddNotesView({super.key});

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat('d MMM, yy').format(DateTime.now());
    final AddNotesController controller = Get.put(AddNotesController());

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
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await controller.addTaskToFirebase();
              Get.offAll(() => const HomeView());
            },
            child: Text(
              'Save',
              style: GoogleFonts.outfit(color: const Color(0xffffffff)),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff4361EE),
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
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Date: $formattedDate',
                style: GoogleFonts.outfit(
                  color: const Color(0xff8F8F93),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
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
                cursorColor: const Color(0xff4361EE),
                controller: controller.tagController,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xffFFFFFF),
                ),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Color(0xff8F8F93),
                    ),
                    onPressed: () {
                      controller.addTag(controller.tagController.text);
                      controller.tagController.clear();
                    },
                  ),
                  hintText: 'Your note tags here...',
                  hintStyle: GoogleFonts.outfit(color: Colors.white54),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(8.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Obx(() {
              return Wrap(
                spacing: 8.0,
                children: controller.tags.map((tag) {
                  return Chip(
                    label: Text(tag),
                    onDeleted: () {
                      controller.removeTag(tag);
                    },
                  );
                }).toList(),
              );
            }),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: const Color(0xff1F2028),
              ),
              child: TextField(
                controller: controller.titleController,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromRGBO(255, 255, 255, 1),
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
                    controller: controller.descriptionController,
                    cursorColor: const Color(0xff4361EE),
                    decoration: InputDecoration(
                      hintText: 'Your note content here...',
                      hintStyle: GoogleFonts.outfit(color: Colors.white54),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(8.0),
                    ),
                    maxLines: null,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showPromptBottomSheet(context, controller),
        child: Icon(CupertinoIcons.sparkles, size: 26.r, color: Colors.white),
        backgroundColor: const Color(0xff4361EE),
      ),
    );
  }

  void _showPromptBottomSheet(
      BuildContext context, AddNotesController controller) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xff15161E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (BuildContext context) {
        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0.r),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child:
                          Image.asset('assets/images/khush.png', scale: 1.6.r),
                    ),
                    SizedBox(height: 10.h),
                    TextFieldContainer(
                      controller: controller.promptController,
                      hintText: 'Enter a prompt',
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.send, color: Colors.white54),
                          onPressed: () {
                            controller.generateResponse(
                                controller.promptController.text);
                          }),
                    ),
                    SizedBox(height: 10.h),
                    Obx(() {
                      return _displayTextSection(
                          controller, 'Asked:', controller.askedText.value);
                    }),
                    Obx(() {
                      return controller.isLoading.value
                          ? Center(
                              child: CircularProgressIndicator(
                              color: Color(0xff4361EE),
                            ))
                          : _displayTextSection(controller, 'Response:',
                              controller.response.value);
                    }),
                    SizedBox(
                      height: 60.h,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10.h,
              left: 20.w,
              right: 20.w,
              child: ElevatedButton(
                onPressed: () {
                  controller.titleController.text = controller.askedText.value;
                  controller.descriptionController.text =
                      controller.response.value;
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(340.w, 45.h),
                  backgroundColor: const Color(0xff4361EE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  'Insert into notes',
                  style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _displayTextSection(
      AddNotesController controller, String title, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.outfit(color: Colors.white54, fontSize: 14.sp),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: const Color(0xff1F2028),
          ),
          child: Text(
            text,
            style: GoogleFonts.outfit(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? suffixIcon;

  const TextFieldContainer({
    Key? key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xff4361EE),
        ),
        borderRadius: BorderRadius.circular(8.r),
        color: const Color(0xff1F2028),
      ),
      child: TextField(
        controller: controller,
        cursorColor: const Color(0xff4361EE),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.outfit(color: Colors.white54),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(8.0.r),
          suffixIcon: suffixIcon,
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

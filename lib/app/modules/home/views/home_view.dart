import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mind_pad/app/modules/AddNotes/views/add_notes_view.dart';
import 'package:mind_pad/app/modules/profile/views/profile_view.dart';
import '../../../Component/categoryButton.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff15161E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70.h,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Text(
              controller.getGreetingMessage(),
              style: GoogleFonts.outfit(
                fontSize: 16.sp,
                color: const Color(0xff4361EE),
              ),
            ),
            Obx(() {
              String displayName =
                  controller.user.value?.displayName ?? 'Guest';
              String firstName = displayName.split(' ').first;
              String formattedFirstName = firstName[0].toUpperCase() +
                  firstName.substring(1).toLowerCase();
              return Text(
                formattedFirstName,
                style: GoogleFonts.outfit(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              );
            }),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 14.w, top: 12.h),
            child: Obx(() {
              return GestureDetector(
                onTap: () {
                  Get.to(
                    const ProfileView(),
                  );
                },
                child: CircleAvatar(
                  foregroundImage: controller.user.value?.photoURL != null
                      ? NetworkImage(controller.user.value!.photoURL!)
                      : null,
                  radius: 25.r,
                  backgroundColor: const Color(0xff1F2028),
                ),
              );
            }),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              color: const Color(0xff1F2028),
              height: 50.h,
              child: Row(
                children: [
                  Obx(() => CategoryButton(
                        text: 'All notes',
                        isSelected:
                            controller.selectedCategory.value == 'All notes',
                        onPressed: () {
                          controller.filterNotes('All notes');
                        },
                      )),
                  Obx(() => CategoryButton(
                        text: 'College',
                        isSelected:
                            controller.selectedCategory.value == 'College',
                        onPressed: () {
                          controller.filterNotes('College');
                        },
                      )),
                  Obx(() => CategoryButton(
                        text: 'Personal',
                        isSelected:
                            controller.selectedCategory.value == 'Personal',
                        onPressed: () {
                          controller.filterNotes('Personal');
                        },
                      )),
                  Obx(() => CategoryButton(
                        text: 'Study',
                        isSelected:
                            controller.selectedCategory.value == 'Study',
                        onPressed: () {
                          controller.filterNotes('Study');
                        },
                      )),
                  Obx(() => CategoryButton(
                        text: 'Goals',
                        isSelected:
                            controller.selectedCategory.value == 'Goals',
                        onPressed: () {
                          controller.filterNotes('Goals');
                        },
                      )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: Obx(() {
              if (controller.notes.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff4361EE),
                  ),
                );
              } else if (controller.filteredNotes.isEmpty) {
                return Center(
                  child: Text(
                    'No notes available. Please add some notes.',
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                return SingleChildScrollView(
                  child: StaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 3.0,
                    crossAxisSpacing: 3.0,
                    children: List.generate(controller.filteredNotes.length,
                        (int index) {
                      var note = controller.filteredNotes[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => NotescardView(
                                title: note['title'] ?? 'No Title',
                                timestamp: note['timestamp'] != null
                                    ? (note['timestamp'] as Timestamp)
                                        .toDate()
                                        .toString()
                                    : null,
                                description:
                                    note['description'] ?? 'No Description',
                                    docId: note['id'],
                              ));
                        },
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: const Color(0xFF1F2028),
                                title: Text(
                                  note['title'],
                                  maxLines: 1,
                                  style: GoogleFonts.outfit(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff4361EE),
                                  ),
                                ),
                                content: Text(
                                  'Are you sure you want to delete this note?',
                                  style: GoogleFonts.outfit(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: GoogleFonts.outfit(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      if (note['id'] != null &&
                                          note['id'] is String) {
                                        controller.deleteNote(note['id']);
                                      } else {
                                        print('Invalid note ID');
                                      }
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Delete',
                                      style: GoogleFonts.outfit(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromARGB(255, 240, 82, 82),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Notescard(
                          title: note['title'] ?? 'No Title',
                          timestamp: note['timestamp'] != null
                              ? (note['timestamp'] as Timestamp)
                                  .toDate()
                                  .toString()
                              : null,
                          description: note['description'] ?? 'No Description',
                          docId: note['id'],
                        ),
                      );
                    }),
                  ),
                );
              }
            }),
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddNotesView());
        },
        child: Icon(
          Icons.edit,
          size: 30.r,
          color: Color(0xffffffff),
        ),
        backgroundColor: Color(0xff4361EE),
      ),
    );
  }
}

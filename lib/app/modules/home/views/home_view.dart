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
              SizedBox(height: 10.h),
              Text(
                controller.getGreetingMessage(),
                style: GoogleFonts.outfit(
                  fontSize: 18.sp,
                  color: const Color(0xff4361EE),
                ),
              ),
              Obx(() {
                return Text(
                  "${controller.user.value?.displayName ?? 'Guest'}",
                  style: GoogleFonts.outfit(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
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
                    Get.to(ProfileView());
                  },
                  child: CircleAvatar(
                    foregroundImage: controller.user.value?.photoURL != null
                        ? NetworkImage(controller.user.value!.photoURL!)
                        : null,
                    radius: 25.r,
                    backgroundColor: Color(0xff1F2028),
                  ),
                );
              }),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 10),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              color: Color(0xff1F2028),
              height: 70.h,
             
              child: Row(
                children: [
                    CategoryButton(text: 'All Notes', onPressed: (){},isSelected: true,),
                    CategoryButton(text: 'All Notes', onPressed: (){}),
                    CategoryButton(text: 'All Notes', onPressed: (){}),
                    CategoryButton(text: 'All Notes', onPressed: (){}),
                    CategoryButton(text: 'All Notes', onPressed: (){}),
                      
                ],
              ),
            ),
          ),
            SizedBox(height: 10),
            SingleChildScrollView(
              child: Expanded(
                child: Obx(() {
                  if (controller.notes.isEmpty) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Color(0xff4361EE),
                    ));
                  } else {
                    return StaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 3.0,
                      crossAxisSpacing: 3.0,
                      children:
                          List.generate(controller.notes.length, (int index) {
                        var note = controller.notes[index];
                        return GestureDetector(
                          onTap: () {
                            
                          },
                          child: Notescard(
                            title: note['title'] ?? 'No Title',
                            date: note['date'] != null
                              ? DateTime.parse(note['date'])
                              : DateTime.now(),
                            description: note['description'] ?? 'No Description',
                            tags: List<String>.from(note['tags'] ?? []),
                           
                          ),
                        );
                      }),
                    );
                  }
                }),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(AddNotesView());
          },
          child: Icon(
            Icons.edit,
            size: 30,
            color: Color(0xffffffff),
          ),
          backgroundColor: Color(0xff4361EE),
        ));
  }
}

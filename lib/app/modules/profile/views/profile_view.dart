import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mind_pad/app/modules/signUp/views/sign_up_view.dart';
import '../controllers/profile_controller.dart';


class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return Scaffold(
      backgroundColor: Color(0XFF15161E),
      appBar: AppBar(
        backgroundColor: Color(0xff15161E),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xffffffff)),
        title: Text(
          'Profile',
          style: GoogleFonts.outfit(
            color: Color(0xffFFFFFF),
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0.w),
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: Color(0xff4361EE),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              child: Text(
                'Edit Details',
                style: GoogleFonts.outfit(
                  color: Color(0xffFFFFFF),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15),
              Obx(() {
              return CircleAvatar(
                foregroundImage: controller.user.value?.photoURL != null
                    ? NetworkImage(controller.user.value!.photoURL!)
                    : null,
                radius: 50.r,
                backgroundColor: Color(0xff1F2028),
              );
            }),
              SizedBox(height: 10),
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
              SizedBox(height: 8),
              Text(
                'YOUR EMAIL:',
                style: GoogleFonts.outfit(
                  color: Color(0xff4361EE),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5),
              Obx(() {
                return Text(
                  "${controller.user.value?.email ?? 'No Email'}",
                  style: GoogleFonts.outfit(
                    color: Color(0xff8F8F93),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'GENERAL',
                  style: GoogleFonts.outfit(
                    color: Color(0xff4361EE),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 10),
              buildListItem('Achieve Notes'),
              buildListItem('Achieve Notes'),
              buildListItem('Achieve Notes'),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'SETTINGS',
                  style: GoogleFonts.outfit(
                    color: Color(0xff4361EE),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 10),
              buildListItem('Achieve Notes'),
              buildListItem('Achieve Notes'),
              buildListItem('Achieve Notes'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListItem(String title) {
    return Card(
      color: Color(0xFF1E1F28),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(
          Icons.save,
          color: Color(0xff4361EE),
          size: 24,
        ),
        title: Text(
          title,
          style: GoogleFonts.outfit(color: Color(0xffFFFFFF)),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Color(0xff8F8F93),
        ),
        onTap: () {},
      ),
    );
  }
}

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
      backgroundColor: const Color(0XFF15161E),
      appBar: AppBar(
        backgroundColor: const Color(0xff15161E),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xffffffff)),
        title: Text(
          'Profile',
          style: GoogleFonts.outfit(
            color: const Color(0xffFFFFFF),
            fontSize: 20.sp,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0.w),
            child: OutlinedButton(
              onPressed: () async{
               await controller.signOut();
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Color(0xff4361EE),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              child: Text(
                'SignOut',
                style: GoogleFonts.outfit(
                  color: const Color(0xffFFFFFF),
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15.h),
              Obx(() {
                return CircleAvatar(
                  foregroundImage: controller.user.value?.photoURL != null
                      ? NetworkImage(controller.user.value!.photoURL!)
                      : null,
                  radius: 50.r,
                  backgroundColor: const Color(0xff1F2028),
                );
              }),
              SizedBox(height: 10.h),
              Obx(() {
                String displayName =
                    controller.user.value?.displayName ?? 'Guest';
                String formattedName = displayName.split(' ').map((word) {
                  return word[0].toUpperCase() +
                      word.substring(1).toLowerCase();
                }).join(' ');
                return Text(
                  formattedName,
                  style: GoogleFonts.outfit(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                );
              }),
              SizedBox(height: 8.h),
              Text(
                'YOUR EMAIL:',
                style: GoogleFonts.outfit(
                  color: const Color(0xff4361EE),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.h),
              Obx(() {
                return Text(
                  controller.user.value?.email ?? 'No Email',
                  style: GoogleFonts.outfit(
                    color: const Color(0xff8F8F93),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }),
              SizedBox(height: 10.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'GENERAL',
                  style: GoogleFonts.outfit(
                    color: const Color(0xff4361EE),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              buildListItem('Achieve Notes'),
              buildListItem('Achieve Notes'),
              buildListItem('Achieve Notes'),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'SETTINGS',
                  style: GoogleFonts.outfit(
                    color: const Color(0xff4361EE),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
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
      color: const Color(0xFF1E1F28),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(
          Icons.save,
          color: const Color(0xff4361EE),
          size: 24.r,
        ),
        title: Text(
          title,
          style: GoogleFonts.outfit(color: const Color(0xffFFFFFF)),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Color(0xff8F8F93),
        ),
        onTap: () {},
      ),
    );
  }
}

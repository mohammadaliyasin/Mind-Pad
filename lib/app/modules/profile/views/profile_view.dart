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
            fontSize: 20,
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
              const SizedBox(height: 15),
              Obx(() {
                return CircleAvatar(
                  foregroundImage: controller.user.value?.photoURL != null
                      ? NetworkImage(controller.user.value!.photoURL!)
                      : null,
                  radius: 50.r,
                  backgroundColor: const Color(0xff1F2028),
                );
              }),
              const SizedBox(height: 10),
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
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                );
              }),
              const SizedBox(height: 8),
              Text(
                'YOUR EMAIL:',
                style: GoogleFonts.outfit(
                  color: const Color(0xff4361EE),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),
              Obx(() {
                return Text(
                  "${controller.user.value?.email ?? 'No Email'}",
                  style: GoogleFonts.outfit(
                    color: const Color(0xff8F8F93),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }),
              const SizedBox(height: 10),
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
              const SizedBox(height: 10),
              buildListItem('Achieve Notes'),
              buildListItem('Achieve Notes'),
              buildListItem('Achieve Notes'),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'SETTINGS',
                  style: GoogleFonts.outfit(
                    color: const Color(0xff4361EE),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
        leading: const Icon(
          Icons.save,
          color: Color(0xff4361EE),
          size: 24,
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

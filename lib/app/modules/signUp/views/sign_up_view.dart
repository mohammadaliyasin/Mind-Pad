import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mind_pad/app/modules/home/views/home_view.dart';
import 'package:mind_pad/app/modules/profile/views/profile_view.dart';
import 'package:mind_pad/app/services/services/auth/authServices.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 150.w, vertical: 50.h),
              child: Image.asset('assets/images/mindpad.png'),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 80.h),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '“',
                          style: GoogleFonts.outfit(
                            color: const Color(0xFF4361EE),
                            fontSize: 70.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: 'Your ',
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: 'note',
                          style: GoogleFonts.outfit(
                            color: const Color(0xFF4361EE),
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: '\ntaking ',
                          style: GoogleFonts.outfit(
                            color: const Color(0xFF4361EE),
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w500,
                            height: 1.h,
                          ),
                        ),
                        TextSpan(
                          text: 'partner.',
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w500,
                            height: 1.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Designed by DVxUI",
                    style: GoogleFonts.outfit(
                      color: const Color(0xff5F5F5F),
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 100.h),
                  ElevatedButton.icon(
                    onPressed: () {
                      // await controller.signInWithGoogle();
                      Get.off(HomeView());
                    },
                    icon: Image.asset('assets/images/google.png'),
                    label: Text(
                      "Continue with Google",
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F2028),
                      side: const BorderSide(color: Color(0xff4361EE)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 50.w, vertical: 14.h),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                    child: Text(
                      "Note: By signing up with Google you are agreeing to our terms & conditions and privacy policy.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff5F5F5F),
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

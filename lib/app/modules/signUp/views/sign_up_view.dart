import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mind_pad/app/modules/profile/views/profile_view.dart';
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
          image: AssetImage('assets/images/bg.png'), // Ensure the correct image path
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Keep the background transparent
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 50),
              child: Image.asset('assets/images/mindpad.png'),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 85),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '“ ',
                          style: GoogleFonts.outfit(
                            color: const Color(0xFF4361EE),
                            fontSize: 70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'Your ',
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'note',
                          style: GoogleFonts.outfit(
                            color: const Color(0xFF4361EE),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '\ntaking ',
                          style: GoogleFonts.outfit(
                            color: const Color(0xFF4361EE),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'partner.',
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Designed by DVxUI",
                    style: GoogleFonts.outfit(
                      color: const Color(0xff5F5F5F),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 160),
                  ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        controller.signInWithGoogle();
                        if (controller.user != null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileView(),
                            ),
                          );
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    icon: Image.asset('assets/images/google.png'),
                    label: Text(
                      "Continue with Google",
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F2028),
                      side: const BorderSide(color: Color(0xff4361EE)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 14), // Button size
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "Note: By signing up with Google you are agreeing to our terms & conditions and privacy policy.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff5F5F5F),
                        fontSize: 14,
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
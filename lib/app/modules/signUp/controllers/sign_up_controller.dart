import 'package:get/get.dart';
import 'package:mind_pad/app/services/services/auth/authServices.dart';

class SignUpController extends GetxController {
  final AuthServices _authServices = AuthServices();

  Future<void> signInWithGoogle() async {
    try {
      await _authServices.signInWithGoogle();
    } catch (e) {
      print('Error during Google Sign-In: $e');

      Get.snackbar('Sign-In Error', 'Failed to sign in with Google. Please try again.');
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mind_pad/app/services/services/auth/authServices.dart';

class SignUpController extends GetxController {
  final AuthServices _authService = Get.put(AuthServices());

  // Assuming you have a User class or similar
  User? _user;

  // Getter for user
  User? get user => _user;

  // Method to sign in with Google
  Future<void> signInWithGoogle() async {
    await _authService.signInWithGoogle();
    _user = _authService.user;
    if (_user != null) {
      // Handle successful sign-in
      print("User signed in: ${_user?.displayName}");
    } else {
      // Handle sign-in failure
      print("Sign-in failed");
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}

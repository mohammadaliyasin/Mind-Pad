import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mind_pad/app/modules/signUp/views/sign_up_view.dart';

import '../../../services/services/auth/authServices.dart';

class ProfileController extends GetxController {
  final AuthServices _authServices = AuthServices();

  var user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user.value = FirebaseAuth.instance.currentUser;
  }

  Future<void> signOut() async {
    try {
      await _authServices.googleSignOut();
      user.value = null;
      Get.offAll(
        () => const SignUpView(),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign out: $e');
    }
  }
}

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  var _isSigningIn = false.obs;
  var _user = Rx<User?>(null);

  bool get isSigningIn => _isSigningIn.value;
  User? get user => _user.value;

  // Sign in with Google
  Future<void> signInWithGoogle() async {
    _isSigningIn.value = true;

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        _isSigningIn.value = false;
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      _user.value = userCredential.user;
    } catch (error) {
      print('Error during Google Sign-In: $error');
    }

    _isSigningIn.value = false;
  }

  // Sign out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    _user.value = null;
  }
}
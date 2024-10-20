import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Future<User?> signInWithGoogle() async {
  //   try {

  //     _auth.setLanguageCode('en');

  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     if (googleUser == null) {
  //       return null; // The user canceled the sign-in
  //     }

  //     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     final UserCredential userCredential = await _auth.signInWithCredential(credential);
  //     return userCredential.user;
  //   } catch (e) {
  //     print('Error during Google sign-in: $e');
  //     return null;
  //   }
  // }


  // for sign in
  Future<UserCredential> signInWithGoogle() async {
    FirebaseAuth.instance.setLanguageCode("en");

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // for sign out
  googleSignOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}

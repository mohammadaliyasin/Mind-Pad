import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  var user = Rx<User?>(null);
  var notes = [].obs;

  @override
  void onInit() {
    super.onInit();
    user.value = _auth.currentUser;
    if (user.value != null) {
      String uid = user.value!.uid;
    }
    fetchNotes();
      notes.addAll([
    ]);
  }

  String getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning,';
    } else if (hour < 17) {
      return 'Good Afternoon,';
    } else {
      return 'Good Evening,';
    }
  }

  void fetchNotes() async {
    if (user.value != null) {
      String uid = user.value!.uid;
      try {
        FirebaseFirestore.instance
            .collection('tasks')
            .doc(uid)
            .collection('mytasks')
            .snapshots()
            .listen((snapshot) {
          notes.value = snapshot.docs.map((doc) => doc.data()).toList();
        });
      } catch (e) {
        print('Error fetching notes: $e');
      }
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    user.value = null;
    notes.clear();
  }
}
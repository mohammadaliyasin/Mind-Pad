import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String uid = '';

  var user = Rx<User?>(null);
  var notes = [].obs;
  var filteredNotes = [].obs;
  var selectedTag = ''.obs;
  
  @override
  void onInit() {
    super.onInit();
    user.value = _auth.currentUser;
    fetchNotes();
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
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      String uid = user.uid;
      FirebaseFirestore.instance
          .collection('tasks')
          .doc(uid)
          .collection('mytasks')
          .snapshots()
          .listen((snapshot) {
        notes.value = snapshot.docs.map((doc) => doc.data()).toList();
      });
    }
  }

  void filterNotes() {
    if (selectedTag.value.isEmpty || selectedTag.value == 'All notes') {
      filteredNotes.value = notes;
    } else {
      filteredNotes.value = notes.where((note) {
        List<String> tags = List<String>.from(note['tags'] ?? []);
        return tags.contains(selectedTag.value);
      }).toList();
    }
  }

  void selectTag(String tag) {
    selectedTag.value = tag;
    filterNotes();
  }
}

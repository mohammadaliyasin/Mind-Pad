import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  var user = Rx<User?>(null);
  var notes = [].obs;
  var filteredNotes = [].obs;
  var selectedCategory = 'All notes'.obs;

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
  if (user.value != null) {
    String uid = user.value!.uid;
    try {
      FirebaseFirestore.instance
          .collection('tasks')
          .doc(uid)
          .collection('mytasks')
          .snapshots()
          .listen((snapshot) {
        notes.value = snapshot.docs.map((doc) => {
          ...doc.data(),
          'id': doc.id,
        }).toList();
        filterNotes(selectedCategory.value);
      });
    } catch (e) {
      print('Error fetching notes: $e');
    }
  }
}

  void filterNotes(String category) {
    selectedCategory.value = category;
    if (category == 'All notes') {
      filteredNotes.assignAll(notes); 
    } else {
      filteredNotes.assignAll(
          notes.where((note) => note['category'] == category).toList());
    }
  }

  Future<void> deleteNote(String docId) async {
    if (user.value != null) {
      String uid = user.value!.uid;
      try {
        await FirebaseFirestore.instance
            .collection('tasks')
            .doc(uid)
            .collection('mytasks')
            .doc(docId)
            .delete();

        Fluttertoast.showToast(msg: 'Note Deleted');
        fetchNotes();
      } catch (e) {
        print('Error deleting note: $e');
        Fluttertoast.showToast(msg: 'Failed to delete note: $e');
      }
    } else {
      Fluttertoast.showToast(msg: 'User not authenticated');
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    user.value = null;
    notes.clear();
    filteredNotes.clear();
  }
}
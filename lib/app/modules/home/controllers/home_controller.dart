import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var user = Rx<User?>(null);
  var notes = [].obs;
  var filteredNotes = [].obs;
  var selectedTag = 'All notes'.obs;
  var tags = <String>['All notes'].obs;

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

    fetchNotes() {
    if (user.value != null) {
      String uid = user.value!.uid;
      try {
       FirebaseFirestore.instance
            .collection('tasks')
            .doc(uid)
            .collection('mytasks')
            .snapshots()
            .listen((snapshot) {
          notes.value = snapshot.docs.map((doc) {
            var data = doc.data();
            var tags = List<String>.from(data['tags'] ?? []);
            return {
              ...data,
              'id': doc.id,
              'tags': tags,
            };
          }).toList();
          updateTags();
          filterByTag(selectedTag.value);
        });
      } catch (e) {
        print('Error fetching notes: $e');
      }
    }
  }

  void updateTags() {
    var allTags = <String>{'All notes'};
    for (var note in notes) {
      allTags.addAll(note['tags']);
    }
    tags.value = allTags.toList();
  }

  void filterByTag(String tag) {
    selectedTag.value = tag;
    if (tag == 'All notes') {
      filteredNotes.assignAll(notes);
    } else {
      filteredNotes.assignAll(
          notes.where((note) => note['tags'].contains(tag)).toList());
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
}
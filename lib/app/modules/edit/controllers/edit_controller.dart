import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user.value = _auth.currentUser;
  }

  Future<void> updateNote(String docId, String title, String description) async {
    if (user.value != null) {
      String uid = user.value!.uid;
      try {
        await FirebaseFirestore.instance
            .collection('tasks')
            .doc(uid)
            .collection('mytasks')
            .doc(docId)
            .update({
          'title': title,
          'description': description,
          'timestamp': DateTime.now(),
        });

        Fluttertoast.showToast(msg: 'Note Updated');
      } catch (e) {
        print('Error updating note: $e');
        Fluttertoast.showToast(msg: 'Failed to update note: $e');
      }
    } else {
      Fluttertoast.showToast(msg: 'User not authenticated');
    }
  }
}
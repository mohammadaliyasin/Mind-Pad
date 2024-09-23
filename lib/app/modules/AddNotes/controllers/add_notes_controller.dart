import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AddNotesController extends GetxController {
  //TODO: Implement AddNotesController


  var isPinned = false.obs;

  Future<void> togglePin() async {
    isPinned.value = !isPinned.value;
    Fluttertoast.showToast(msg: isPinned.value ? 'Note Pinned' : 'Note Unpinned');
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

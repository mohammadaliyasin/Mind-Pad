import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../apiKey.dart';
import '../../../Model/Model.dart';

class AddNotesController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final TextEditingController promptController = TextEditingController();

  var tags = <String>[].obs;
  var response = ''.obs;
  var isLoading = false.obs;
  var askedText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // generateResponse(promptController.text);
  }

  Future<void> addTaskToFirebase() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user != null) {
      String uid = user.uid;
      var time = DateTime.now();
      await FirebaseFirestore.instance
          .collection('tasks')
          .doc(uid)
          .collection('mytasks')
          .doc(time.toString())
          .set({
        'title': titleController.text,
        'description': descriptionController.text,
        'time': time.toString(),
        'timestamp': time,
        'tags': tags.toList(),
      });
      Fluttertoast.showToast(msg: 'Data Added');
    }
  }

  void addTag(String tag) {
    if (tag.isNotEmpty && !tags.contains(tag)) {
      tags.add(tag);
    }
  }

  void removeTag(String tag) {
    tags.remove(tag);
  }

  Future<void> generateResponse(String asked) async {
    if (asked.isEmpty) return;
    isLoading.value = true;
    askedText.value = asked;
    promptController.clear();

    const String apiKey = GeminiApiKey.api_key;
    final AIModel? aiModel = await getResponseFromGeminiAI(asked, apiKey);

    if (aiModel != null) {
      response.value = aiModel.response;

    } else {
      response.value = 'Failed to get response';
    }
    isLoading.value = false;
  }

  Future<AIModel?> getResponseFromGeminiAI(String asked, String apiKey) async {
    try {
      final response = await http.post(
        Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$apiKey',
        ),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "contents": [
            {
              "parts": [
                {"text": asked},
              ],
            },
          ],
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        String message =
            responseData['candidates'][0]['content']['parts'][0]['text'];
        return AIModel.fromJson({
          'asked': asked,
          'response': message,
        });
      } else {
        return AIModel(
          asked: asked,
          response: 'Error: Unable to fetch response',
        );
      }
    } catch (e) {
      return AIModel(
        asked: asked,
        response: 'Error: ${e.toString()}',
      );
    }
  }
}

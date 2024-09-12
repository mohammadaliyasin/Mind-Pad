import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mind_pad/app/modules/signUp/views/sign_up_view.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.amberAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await controller.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignUpView(), // Ensure you have this view
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Obx(() {
          final user = controller.user.value;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  user?.photoURL ?? '',
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Welcome, ${user?.displayName ?? 'Guest'}',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 8),
              Text(
                'Email: ${user?.email ?? 'Not available'}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await controller.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpView(), // Ensure you have this view
                    ),
                  );
                },
                child: const Text('Sign Out'),
              ),
            ],
          );
        }),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:tes/core/constants/constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          children: [

            /// Avatar
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

            /// Nama
            const Text(
              "Admin D4TI",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            /// Email
            const Text(
              "admin@d4ti.com",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 32),

            /// Info Card
            Card(
              child: Column(
                children: [

                  ListTile(
                    leading: const Icon(Icons.school),
                    title: const Text("Program Studi"),
                    subtitle: const Text("D4 Teknik Informatika"),
                  ),

                  const Divider(),

                  ListTile(
                    leading: const Icon(Icons.business),
                    title: const Text("Universitas"),
                    subtitle: const Text("Universitas Airlangga"),
                  ),

                  const Divider(),

                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text("Versi Aplikasi"),
                    subtitle: Text(AppConstants.appVersion),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
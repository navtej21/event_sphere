import 'package:event_sphere/modules/attendee/account/profile_page.dart';
import 'package:event_sphere/modules/attendee/interests/event_interest_view.dart';
import 'package:event_sphere/modules/auth/welcome_view.dart';
import 'package:event_sphere/services/auth_service.dart';
import 'package:event_sphere/widgets/preference_title.dart';
import 'package:event_sphere/widgets/profile_card.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F7F2),
        title: const Text("Account"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => EditProfilePage()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            profileCard(),
            const SizedBox(height: 24),
            const Text(
              "Preferences",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            preferencesTile(
                icon: Icons.flash_on,
                title: "Interests",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EventInterestView()));
                }),
            const Divider(height: 32),
            preferencesTile(
              icon: Icons.logout,
              title: "Sign out",
              textColor: Colors.black,
              onTap: () {
                AuthService.logout();
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WelcomeScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

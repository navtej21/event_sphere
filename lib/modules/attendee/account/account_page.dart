
import 'package:event_sphere/services/auth_service.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F2),
      body: Center(
        child: Column(
          children: [
            InkWell(
              onTap: () {
              },
              child: Container(
                child: Text("LOGOUT"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(""),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Profile picture
            Column(
              children: [
                const CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.black,
                  child: Text(
                    "NN",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    // TODO: image picker
                  },
                  child: const Text(
                    "Update picture",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            _inputField(label: "First name", initialValue: "Navtej"),
            _inputField(label: "Last name", initialValue: "Nair"),

            _inputField(
              label: "Email",
              initialValue: "navtejsnair@gmail.com",
              enabled: false,
            ),

            _inputField(
              label: "Location",
              initialValue: "Chennai",
              suffixIcon: Icons.my_location,
            ),

            _inputField(label: "Phone number"),

            const SizedBox(height: 16),

            // Change password
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text("Change password"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: navigate to change password
              },
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _inputField({
    required String label,
    String? initialValue,
    bool enabled = true,
    IconData? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        initialValue: initialValue,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: enabled ? Colors.white : const Color(0xFFEDEDED),
          suffixIcon:
              suffixIcon != null ? Icon(suffixIcon, size: 20) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

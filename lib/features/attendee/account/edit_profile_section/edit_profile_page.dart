import 'package:event_sphere/features/attendee/account/edit_profile_section/edit_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfilePage extends GetView<EditProfileController> {
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
                  onTap: () {},
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
            _inputField(
                label: "First name",
                initialValue: controller.firstNameController.text),
            _inputField(
                label: "Last name",
                initialValue: controller.lastNameController.text),
            _inputField(
              label: "Email",
              initialValue: controller.emailController.text,
              enabled: false,
            ),
            _inputField(
              label: "Location",
              initialValue: controller.locationController.text,
              suffixIcon: Icons.my_location,
            ),
            _inputField(
                label: "Phone number",
                initialValue: controller.phoneController.text,
                suffixIcon: Icons.phone),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text("Change password"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
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
          suffixIcon: suffixIcon != null ? Icon(suffixIcon, size: 20) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

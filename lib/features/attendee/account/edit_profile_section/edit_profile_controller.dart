import 'package:flutter/material.dart';
import 'package:get/get.dart';


class EditProfileController extends GetxController {
  final firstNameController = TextEditingController(text: "Navtej");
  final lastNameController = TextEditingController(text: "Nair");
  final emailController =
      TextEditingController(text: "navtejsnair@gmail.com");
  final locationController = TextEditingController(text: "Chennai");
  final phoneController = TextEditingController();

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    locationController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';



class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>(); // ✅ important

  final isLoading = false.obs;

  Future<void> login() async {
    // ✅ Trigger validation
    if (!formKey.currentState!.validate()) return;

    FocusManager.instance.primaryFocus?.unfocus();

    try {
      isLoading.value = true;

      await Future.delayed(const Duration(seconds: 1));
      Get.offAllNamed(Routes.events);

    } catch (e) {
      Get.snackbar('Error', 'Login failed');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
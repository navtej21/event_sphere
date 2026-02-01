import 'package:event_sphere/features/attendee/account/edit_profile_section/edit_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class EditProfileBinding extends Bindings{

  @override 

  void dependencies(){
    Get.lazyPut<EditProfileController>(()=>EditProfileController());
  }

}
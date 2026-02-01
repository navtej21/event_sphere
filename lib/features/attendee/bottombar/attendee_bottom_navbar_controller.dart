
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AttendeeBottomNavbarController extends GetxController{


  final currentindex=0.obs;

  void changeTab(int index){
    currentindex.value=index;
  }
}
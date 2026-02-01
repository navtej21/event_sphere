import 'package:event_sphere/features/auth/login_view.dart';
import 'package:event_sphere/features/auth/welcome_view.dart';
import 'package:event_sphere/services/initial_screen.dart';
import 'package:event_sphere/features/attendee/home/attendee_home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Widget? intialscreen=await getInitialScreen();


  runApp(MaterialApp(
    home: intialscreen,
    debugShowCheckedModeBanner: false,
  )); 
}

import 'package:event_sphere/modules/auth/login_view.dart';
import 'package:event_sphere/modules/auth/welcome_view.dart';
import 'package:event_sphere/services/initial_screen.dart';
import 'package:event_sphere/modules/attendee/home/attendee_home_view.dart';
import 'package:flutter/material.dart';
void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Widget? intialscreen=await getInitialScreen();


  runApp(MaterialApp(
    home: intialscreen,
    debugShowCheckedModeBanner: false,
  )); 
}

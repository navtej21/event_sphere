import 'package:event_sphere/modules/auth/login_view.dart';
import 'package:event_sphere/modules/auth/welcome_view.dart';
import 'package:event_sphere/modules/organizer/dash_board/organizer_home_screen.dart';
import 'package:event_sphere/services/storage_service.dart';
import 'package:event_sphere/modules/admin/admin_screen.dart';
import 'package:event_sphere/modules/attendee/home/attendee_home_view.dart';
import 'package:event_sphere/modules/organizer/my_events/organizer_screen.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:jwt_decoder/jwt_decoder.dart';


Future<Widget?> getInitialScreen() async{

  String? token=await SecureStorage.getToken();

  if(token ==null){
    return const WelcomeScreen();
  }
  else{
    if(JwtDecoder.isExpired(token)){
      await SecureStorage.deleteToken();
      return const WelcomeScreen();
    }
    else{
      final decodedToken=Jwt.parseJwt(token);
      final role=decodedToken['role'];
      switch(role){
        case 'ADMIN':
          return const AdminScreen();
        case 'ORGANIZER':
          return const OrganizerHomeScreen();
        default:
          return const AttendeeScreen();
      }
    }
  }
  

  
}
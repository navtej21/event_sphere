
import 'package:event_sphere/modules/auth/welcome_view.dart';
import 'package:event_sphere/services/auth_service.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListTile(
            title: Text("Logout"),
            leading: Icon(Icons.logout),
            onTap: ()
             async{
              await AuthService.logout();
              if(context.mounted){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>WelcomeScreen()));
              }
            },
          )
        ],
      ),
    );
  }
}
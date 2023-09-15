import 'package:flutter/material.dart';
import 'package:resq/auth/login_screen.dart';
import 'package:resq/services/auth_services.dart';
import 'package:resq/widgets/widgets.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  AuthService authService=AuthService();
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ElevatedButton(onPressed: (){
      authService.signOut();
       nextScreenReplace(context, LoginPage());
    }, child: Text("log out"))),
    );
  }
}

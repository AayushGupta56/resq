import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:resq/auth/home_page.dart';
import 'package:resq/auth/register_screen.dart';
import 'package:resq/services/auth_services.dart';
import 'package:resq/services/database_services.dart';
import 'package:resq/shared_prefrences/helper_function.dart';
import 'package:resq/widgets/widgets.dart';

import '../comman_design_code.dart';



class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  AuthService authService=AuthService();
  login() async {
   // if (formKey.currentState!.validate()) {

      await authService.loginWithUserNameandPassword( emailCont.text, passwordCont.text).then((value) async {
        if(value==true){
          QuerySnapshot snapshot = await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
              .gettingUserData(emailCont.text);
         // saving the values to our shared preferences
         await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(emailCont.text);
         await HelperFunctions.saveUserNameSF(snapshot.docs[0]['fullName']);
         nextScreenReplace(context,  HomePage());
          nextScreen(context, HomePage());
        }
        else{
          showSnackbar(context, Colors.red, value);

        }
      }
      );
   // }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 60,),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/login1.jpg', // Replace with your image URL
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 38.0,
                        fontFamily: 'RedHatDisplay'
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5,),
              InputBoxes(boxNameText: "Email", boxHintText: "Enter Email",
                boxPrefixIcon: Icon(Icons.account_circle_outlined, color: Colors.grey,),
                controller: emailCont,
                validator: (value) {
                  return RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value!)
                      ? null
                      : "Please enter a valid email";
                },
              ),

              SizedBox(height: 5.0),

              InputBoxes(boxNameText: "password", boxHintText: "Enter password",
                boxPrefixIcon: Icon(Icons.lock_outlined, color: Colors.grey,),
                controller: passwordCont,
                validator: (value) {
                  if (value == null || value.length<=6) {
                    return 'Password should be greater than 6 characters';
                  }
                  return null;
                },
              ),
              MyButton(buttonName: "Login", onPressed: (){
                login();
               // Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterPage()));
              }),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        'OR',
                        style: TextStyle(fontSize: 16, color: Colors.grey ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0.0,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('New Agency ?', style: TextStyle(fontSize: 16),),
                  TextButton(
                    onPressed: () {
                      // Handle sign-up button press
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                    },
                    child: Text('Register now', style: TextStyle(fontSize: 16),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
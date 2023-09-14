import 'package:flutter/material.dart';
import 'package:resq/auth/register_screen.dart';

import '../comman_design_code.dart';



class LoginPage extends StatelessWidget {

  TextEditingController userNameCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

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
              InputBoxes(boxNameText: "username", boxHintText: "Enter Username",
                boxPrefixIcon: Icon(Icons.account_circle_outlined, color: Colors.grey,),
                controller: userNameCont,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username is required';
                  }
                  return null;
                },
              ),

              SizedBox(height: 5.0),

              InputBoxes(boxNameText: "password", boxHintText: "Enter password",
                boxPrefixIcon: Icon(Icons.lock_outlined, color: Colors.grey,),
                controller: passwordCont,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username is required';
                  }
                  return null;
                },
              ),
              MyButton(buttonName: "Login", onPressed: (){
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
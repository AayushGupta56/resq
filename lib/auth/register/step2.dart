import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resq/provider_code.dart';
import '../../comman_design_code.dart';
import 'package:http/http.dart' as http;
class Step2Page extends StatefulWidget {
  final GlobalKey<FormState> formKey;


  Step2Page({
    required this.formKey,
  });

  @override
  State<Step2Page> createState() => _Step2PageState();
}

class _Step2PageState extends State<Step2Page> {
  final TextEditingController AdminstratornameCont = TextEditingController();

  final TextEditingController EmailaddressCont = TextEditingController();
  final TextEditingController phonenumCont = TextEditingController();
  final TextEditingController pincodeCont = TextEditingController();
  final TextEditingController StateCont = TextEditingController();
  final TextEditingController distictCont = TextEditingController();
  final TextEditingController NameCont = TextEditingController();


  String ?selectedAgencyType ; // Initially, no country is selected

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyProviderData>(context, listen: false);
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          SizedBox(height: 30,),
          InputBoxes(boxNameText: "Adminstrator Name", boxHintText: "Enter Adminstrator Name",
            boxPrefixIcon: Icon(Icons.account_circle_outlined, color: Colors.grey,),
            controller: provider.AdminstratornameCont,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Username is required';
              }
              return null;
            },
          ),
          SizedBox(height: 10.0),

          InputBoxes(boxNameText: "Email Address", boxHintText: "Enter email address",
            boxPrefixIcon: Icon(Icons.account_circle_outlined, color: Colors.grey,),
            controller: provider.EmailaddressCont,
            validator: (value) {
              return RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value!)
                  ? null
                  : "Please enter a valid email";
            },
          ),
          InputBoxes(boxNameText: "Create password", boxHintText: "Create Password",
            boxPrefixIcon: Icon(Icons.account_circle_outlined, color: Colors.grey,),
            controller: provider.PasswordCont,
            validator: (value) {
              if (value == null || value.length<=5) {
                return 'password should be at least 6 characters';
              }
              return null;
            },
          ),
          InputBoxes(boxNameText: "Phone number", boxHintText: "Enter Phone number",
            boxPrefixIcon: Icon(Icons.account_circle_outlined, color: Colors.grey,),
            controller: provider.phonenumCont,
            validator: (value) {
              if (value == null || value.length!=10) {
                return 'Enter correct phone number';
              }
              return null;
            },
          ),
          InputBoxes(boxNameText: "Pin Code", boxHintText: "Enter Pin Code",
            boxPrefixIcon: Icon(Icons.account_circle_outlined, color: Colors.grey,),
            controller: provider.pincodeCont,
            validator: (value) {
              if (value == null || value.length!=6) {
                return 'Enter correct phone number';
              }
              return null;
            },
          ),
          TextButton(onPressed: ()async{
            String pincode=provider.pincodeCont.text;
            print(pincode);
            final response = await http.get(Uri.parse('https://api.postalpincode.in/pincode/$pincode'));
            if (response.statusCode == 200) {
              // Parse the JSON data if the request was successful.
              final jsonData = json.decode(response.body);
              // Now you can work with the data.
              print(jsonData);
            } else {
              // Handle errors, e.g., show an error message to the user.
              print('Request failed with status: ${response.statusCode}');
            }
            final data = json.decode(response.body);
            provider.StateCont.text=data[0]['PostOffice'][0]['State'];
            provider.districtCont.text=data[0]['PostOffice'][0]['District'];
            provider.NameCont.text=data[0]['PostOffice'][0]['Name'];
         //   final name = jData['name'];
           // final email = jsonData['email'];
          }, child: Text("Auto fill")),
          InputBoxes(boxNameText: "state", boxHintText: "Enter State",
            boxPrefixIcon: Icon(Icons.account_circle_outlined, color: Colors.grey,),
            controller: provider.StateCont,
            validator: (value) {
              if (value == null || value.length<=3) {
                return 'Enter correct State';
              }
              return null;
            },
          ),
          InputBoxes(boxNameText: "district", boxHintText: "Enter district",
            boxPrefixIcon: Icon(Icons.account_circle_outlined, color: Colors.grey,),
            controller: provider.districtCont,
            validator: (value) {
              if (value == null || value.length<=3) {
                return 'Enter correct district';
              }
              return null;
            },
          ),
          InputBoxes(boxNameText: "name", boxHintText: "Enter city name",
            boxPrefixIcon: Icon(Icons.account_circle_outlined, color: Colors.grey,),
            controller: provider.NameCont,
            validator: (value) {
              if (value == null || value.length<=3) {
                return 'Enter correct State';
              }
              return null;
            },
          ),
        ],

      ),
    );
  }
}
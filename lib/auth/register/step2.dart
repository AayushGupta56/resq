import 'package:flutter/material.dart';
import '../../comman_design_code.dart';

class Step2Page extends StatefulWidget {
  final GlobalKey<FormState> formKey;


  Step2Page({
    required this.formKey,
  });

  @override
  State<Step2Page> createState() => _Step2PageState();
}

class _Step2PageState extends State<Step2Page> {
  final TextEditingController AgencynameCont = TextEditingController();

  final TextEditingController EmailaddressCont = TextEditingController();
  final TextEditingController phonenumCont = TextEditingController();
  final TextEditingController pincodeCont = TextEditingController();
  final TextEditingController StateCont = TextEditingController();
  final TextEditingController distictCont = TextEditingController();
  final TextEditingController NameCont = TextEditingController();


  String ?selectedAgencyType ; // Initially, no country is selected

  List<String> agencies = [
    'Government',
    'Non-Profit',
    'Private',
    // Add more countries as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          SizedBox(height: 30,),
          InputBoxes(boxNameText: "Adminstrator Name", boxHintText: "Enter Adminstrator Name",
            boxPrefixIcon: Icon(Icons.account_circle_outlined, color: Colors.grey,),
            controller: AgencynameCont,
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
            controller: EmailaddressCont,
            validator: (value) {
              return RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value!)
                  ? null
                  : "Please enter a valid email";
            },
          ),
          InputBoxes(boxNameText: "Phone number", boxHintText: "Enter Phone number",
            boxPrefixIcon: Icon(Icons.account_circle_outlined, color: Colors.grey,),
            controller: phonenumCont,
            validator: (value) {
              if (value == null || value.length!=10) {
                return 'Enter correct phone number';
              }
              return null;
            },
          ),
          InputBoxes(boxNameText: "Pin Code", boxHintText: "Enter Pin Code",
            boxPrefixIcon: Icon(Icons.account_circle_outlined, color: Colors.grey,),
            controller: pincodeCont,
            validator: (value) {
              if (value == null || value.length!=6) {
                return 'Enter correct phone number';
              }
              return null;
            },
          ),
          InputBoxes(boxNameText: "state", boxHintText: "Enter State",
            boxPrefixIcon: Icon(Icons.account_circle_outlined, color: Colors.grey,),
            controller: StateCont,
            validator: (value) {
              if (value == null || value.length<=3) {
                return 'Enter correct State';
              }
              return null;
            },
          ),
          InputBoxes(boxNameText: "district", boxHintText: "Enter district",
            boxPrefixIcon: Icon(Icons.account_circle_outlined, color: Colors.grey,),
            controller: distictCont,
            validator: (value) {
              if (value == null || value.length<=3) {
                return 'Enter correct district';
              }
              return null;
            },
          ),
          InputBoxes(boxNameText: "name", boxHintText: "Enter city name",
            boxPrefixIcon: Icon(Icons.account_circle_outlined, color: Colors.grey,),
            controller: StateCont,
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
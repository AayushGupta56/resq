import 'package:flutter/material.dart';

import '../../comman_design_code.dart';


class Step1Page extends StatefulWidget {
  final GlobalKey<FormState> formKey;


  Step1Page({
    required this.formKey,
  });

  @override
  State<Step1Page> createState() => _Step1PageState();
}

class _Step1PageState extends State<Step1Page> {
  // Text editing controllers for form fields
  final TextEditingController AgencynameCont = TextEditingController();
  final TextEditingController registrationCont = TextEditingController();


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
          InputBoxes(boxNameText: "Agency Name", boxHintText: "Enter Agency Name",
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
          MyDropdownField<String>(
            fieldName: 'Agency Type',
            hintText: 'Select agency type',
            value: selectedAgencyType,
            onChanged: (newValue) {
              setState(() {
                selectedAgencyType = newValue!;
              });
            },
            items: agencies.map((country) {
              return DropdownMenuItem(
                value: country,
                child: Text(country),
              );
            }).toList(),
            validator: (value) {
              if (value == null) {
                return 'Please select agency type';
              }
              return null;
            },
          ),
          SizedBox(height: 10.0),

          InputBoxes(boxNameText: "Registration", boxHintText: "Enter Agency Name",
            boxPrefixIcon: Icon(Icons.account_circle_outlined, color: Colors.grey,),
            controller: registrationCont,
            validator: (value) {
            //   if (value == null || value.isEmpty) {
            //     return 'User is required';
            //   }
            //   return null;
             },
          ),
        ],
      ),
    );
  }
}



import 'package:flutter/material.dart';
import '../../comman_design_code.dart';

class Step3Page extends StatefulWidget {
  final GlobalKey<FormState> formKey;


  Step3Page({
    required this.formKey,
  });

  @override
  State<Step3Page> createState() => _Step3PageState();
}

class _Step3PageState extends State<Step3Page> {
  final TextEditingController AreaCont = TextEditingController();

  final TextEditingController ResourcesCont = TextEditingController();
  final TextEditingController EquipmentCont = TextEditingController();


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
          InputBoxes(boxNameText: "Area of expertise", boxHintText: "Enter Area of Expertise",
            boxPrefixIcon: Icon(Icons.account_circle_outlined, color: Colors.grey,),
            controller: AreaCont,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Username is required';
              }
              return null;
            },
          ),
          SizedBox(height: 10.0),
          // MyDropdownField<String>(
          //   fieldName: 'Agency Type',
          //   hintText: 'Select agency type',
          //   value: selectedAgencyType,
          //   onChanged: (newValue) {
          //     setState(() {
          //       selectedAgencyType = newValue!;
          //     });
          //   },
          //   items: agencies.map((country) {
          //     return DropdownMenuItem(
          //       value: country,
          //       child: Text(country),
          //     );
          //   }).toList(),
          //   validator: (value) {
          //     if (value == null) {
          //       return 'Please select agency type';
          //     }
          //     return null;
          //   },
          // ),
          // SizedBox(height: 10.0),


          InputBoxes(boxNameText: "Resources", boxHintText: "Enter Resources",
            boxPrefixIcon: Icon(Icons.account_circle_outlined, color: Colors.grey,),
            controller: ResourcesCont,
            validator: (value) {
              if (value == null || value.length<=2) {
                return 'Enter correct resources';
              }
              return null;
            },
          ),
          InputBoxes(boxNameText: "Equipment", boxHintText: "Enter Equipments",
            boxPrefixIcon: Icon(Icons.account_circle_outlined, color: Colors.grey,),
            controller: EquipmentCont,
            validator: (value) {
              if (value == null || value.length<=1) {
                return 'Enter correct phone equipments';
              }
              return null;
            },
          ),

        ],

      ),
    );
  }
}
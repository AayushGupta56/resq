import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class MyProviderData extends ChangeNotifier {
  // Your provider implementation goes here...
  //step1
  final TextEditingController AgencynameCont = TextEditingController();
  final TextEditingController registrationCont = TextEditingController();
  String ?selectedAgencyType ;
  //step2
  final TextEditingController AdminstratornameCont = TextEditingController();

  final TextEditingController EmailaddressCont = TextEditingController();
  final TextEditingController phonenumCont = TextEditingController();
  final TextEditingController pincodeCont = TextEditingController();
  final TextEditingController StateCont = TextEditingController();
  final TextEditingController distictCont = TextEditingController();
  final TextEditingController NameCont = TextEditingController();
  //step3
  final TextEditingController AreaCont = TextEditingController();

  final TextEditingController ResourcesCont = TextEditingController();
  final TextEditingController EquipmentCont = TextEditingController();

}

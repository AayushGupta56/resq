
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class MyProviderData extends ChangeNotifier {
  // Your provider implementation goes here...
  //step1
  final TextEditingController AgencynameCont = TextEditingController();
  final TextEditingController registrationNumberCont = TextEditingController();
  String ?selectedAgencyType ;
  //step2
  final TextEditingController AdminstratornameCont = TextEditingController();
  final TextEditingController EmailaddressCont = TextEditingController();

  final TextEditingController PasswordCont = TextEditingController();
  final TextEditingController phonenumCont = TextEditingController();
  final TextEditingController pincodeCont = TextEditingController();
  final TextEditingController StateCont = TextEditingController();
  final TextEditingController districtCont = TextEditingController();
  final TextEditingController NameCont = TextEditingController();
  //step3
  final TextEditingController AreaCont = TextEditingController();
  final TextEditingController ResourcesCont = TextEditingController();
  final TextEditingController numberOfWorkers = TextEditingController();

}

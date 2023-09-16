import 'package:provider/provider.dart';
import 'package:resq/provider_code.dart';
import 'package:resq/shared_prefrences/helper_function.dart';
import 'package:resq/services/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // login
  Future loginWithUserNameandPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password))
          .user!
      ;

      if (user != null) {
        print('hmv');
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // register
  Future registerUserWithEmailandPassword(
      String fullName, String email, String password,context) async {

    final provider = Provider.of<MyProviderData>(context, listen: false);
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password))
          .user!;

      if (user != null) {
        // call our database service to update the user data.
        await DatabaseService(uid: user.uid).savingUserData(
          agencyName: provider.AgencynameCont.text,
          registrationNum: provider.registrationNumberCont.text,
          agencyType: provider.selectedAgencyType,
          adminstratorName: provider.AdminstratornameCont.text,
          email: provider.EmailaddressCont.text,
          phoneNum: provider.phonenumCont.text,
          pincode: provider.phonenumCont.text,
          state: provider.StateCont.text,
          district: provider.districtCont.text,
          cityName: provider.NameCont.text,
          areaExpertise: provider.AreaCont.text,
          resources: provider.ResourcesCont.text,
          numberOfWorkers: provider.numberOfWorkers.text,
          imageUrl: provider.imageUrl,
        );
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // signout
  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailSF("");
      await HelperFunctions.saveUserNameSF("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
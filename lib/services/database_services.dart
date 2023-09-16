import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  // reference for our collections
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  // saving the userdata
  Future savingUserData({
    String? agencyName,
    String? registrationNum,
    String? agencyType,
    String? adminstratorName,
    String? email,
    String? phoneNum,
    String? pincode,
    String? state,
    String? district,
    String? cityName,
    String? areaExpertise,
    String? resources,
    String? numberOfWorkers,
    String? imageUrl,
  }
  ) async {
    return await userCollection.doc(uid).set({
      "AgencyName": agencyName,
      "RegistrationNum":registrationNum,
      "agencyType":agencyType,
      "adminstratorName":adminstratorName,
      "email":email,
      "phoneNum":phoneNum,
      "pincode":pincode,
      "state":state,
      "district":district,
      "cityName":cityName,
      "areaExpertise":areaExpertise,
      "resources":resources,
      "numberOfWorkers":numberOfWorkers,
       "uid": uid,
      "imageUrl" : imageUrl,
    });
  }

  // getting user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
}

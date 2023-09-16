
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resq/provider_code.dart';
import '../../comman_design_code.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';



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
  final TextEditingController numberOfWorkers = TextEditingController();

  String? selectedAgencyType; // Initially, no country is selected



  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyProviderData>(context, listen: false);
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),

          IconButton(
              onPressed: () async {
                /*
                * Step 1. Pick/Capture an image   (image_picker)
                * Step 2. Upload the image to Firebase storage
                * Step 3. Get the URL of the uploaded image
                * Step 4. Store the image URL inside the corresponding
                *         document of the database.
                * Step 5. Display the image on the list
                *
                * */

                ImagePicker imagePicker = ImagePicker();
                XFile? file =
                await imagePicker.pickImage(source: ImageSource.gallery);
                File myFile;
                myFile = File(file!.path);
                print('${file?.path}');


                if (file == null || myFile==null) return;
                // //Import dart:core
                 String uniqueFileName =
                 DateTime.now().millisecondsSinceEpoch.toString();
                //
                // /*Step 2: Upload to Firebase storage*/
                // //Install firebase_storage
                // //Import the library
                //
                // //Get a reference to storage root
                 Reference referenceRoot = FirebaseStorage.instance.ref();
                 Reference referenceDirImages =
                 referenceRoot.child('images');

                // //Create a reference for the image to be stored
                 Reference referenceImageToUpload =
                 referenceDirImages.child(uniqueFileName);
                //
                // //Handle errors/success
                 try {
                  //Store the file
                  await referenceImageToUpload.putFile(myFile);
                  //Success: get the download URL
                  provider.imageUrl = await referenceImageToUpload.getDownloadURL();
                } catch (error) {
                  //Some error occurred
                }
              },
              icon: Icon(Icons.camera_alt)),


          InputBoxes(
            boxNameText: "Area of expertise",
            boxHintText: "Enter Area of Expertise",
            boxPrefixIcon: Icon(
              Icons.account_circle_outlined,
              color: Colors.grey,
            ),
            controller: provider.AreaCont,
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

          InputBoxes(
            boxNameText: "Resources",
            boxHintText: "Enter Resources",
            boxPrefixIcon: Icon(
              Icons.account_circle_outlined,
              color: Colors.grey,
            ),
            controller: provider.ResourcesCont,
            validator: (value) {
              if (value == null || value.length <= 2) {
                return 'Enter correct resources';
              }
              return null;
            },
          ),

          InputBoxes(
            boxNameText: "Equipment",
            boxHintText: "Enter Equipments",
            boxPrefixIcon: Icon(
              Icons.account_circle_outlined,
              color: Colors.grey,
            ),
            controller: provider.numberOfWorkers,
            validator: (value) {
              if (value == null || value.length <= 0) {
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

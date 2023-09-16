import 'package:flutter/material.dart';

import 'home/agency_detail.dart';



   // code to show loading
// showDialog(
// context: context,
// barrierDismissible: false,
// builder: (context) {
// return loadingDesign;
// },
// );

  // dismiss loading
 // Navigator.of(context).pop();


class AnimatedCounter extends StatefulWidget {
  final int targetNumber;
  final Duration duration;

  AnimatedCounter({required this.targetNumber, required this.duration});

  @override
  _AnimatedCounterState createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with TickerProviderStateMixin { // Use TickerProviderStateMixin
  late int _currentNumber;
  late Animation<int> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _currentNumber = 0;

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this, // Now _AnimatedCounterState can be used as TickerProvider
    );

    _animation = IntTween(begin: 0, end: widget.targetNumber).animate(_controller);

    _animation.addListener(() {
      setState(() {
        _currentNumber = _animation.value;
      });
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            'Registered Agencies: ',
            style: TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
          ),
      Text(
      '$_currentNumber', // Use _currentNumber here
      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.green),
      )
        ],
      ),
    );

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}



Widget loadingDesign = Center(
  child: Container(
    width: 80.0,
    height: 80.0,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white,
      border: Border.all(
        color: Color(0xFFB90000),
        width: 2.0,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0, 2),
          blurRadius: 4.0,
        ),
      ],
    ),
    padding: EdgeInsets.all(20.0),
    child: Center(child: CircularProgressIndicator(
      color: Colors.black,
    )),
  ),
);


class InputBoxes extends StatefulWidget {
  final String boxNameText;
  final String boxHintText;
  final Icon boxPrefixIcon;
  final TextEditingController controller;
  final String? Function(String?) validator;

  InputBoxes({
    required this.boxNameText,
    required this.boxHintText,
    required this.boxPrefixIcon,
    required this.controller,
    required this.validator,
  });

  @override
  State<InputBoxes> createState() => _InputBoxesState();
}

class _InputBoxesState extends State<InputBoxes> {
  bool hasError = false; // Track validation error

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 5),
            child: Text(
              widget.boxNameText,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            controller: widget.controller,
            validator: (value) {
              final error = widget.validator(value);
              setState(() {
                hasError = error != null;
              });
              return error;
            },
            decoration: InputDecoration(
              hintText: widget.boxHintText,
              prefixIcon: widget.boxPrefixIcon,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 0.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: hasError ? Colors.red : Colors.grey, // Change border color on error
                  width: 0.0,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 12.0),
            ),
          ),
        ),
      ],
    );
  }
}

class MyDropdownField<T> extends StatefulWidget {
  final String fieldName;
  final String hintText;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final Function(T?)? onChanged;
  final String? Function(T?)? validator;

  MyDropdownField({
    required this.fieldName,
    required this.hintText,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.validator,
  });

  @override
  _MyDropdownFieldState<T> createState() => _MyDropdownFieldState<T>();
}

class _MyDropdownFieldState<T> extends State<MyDropdownField<T>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 5),
            child: Text(
              widget.fieldName,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            height: 50.0, // Set a fixed height for the dropdown
            child: ListView(
              children: [
                DropdownButtonFormField<T>(
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    prefixIcon: Icon(Icons.arrow_drop_down),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 0.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 0.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                  ),
                  value: widget.value,
                  onChanged: widget.onChanged,
                  items: widget.items,
                  validator: widget.validator,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MyButton extends StatelessWidget {
  MyButton({
    required this.buttonName,
    required this.onPressed, // Add onPressed function as a parameter
  });
  final String buttonName;
  final VoidCallback onPressed; // Define a callback function for onPressed

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed, // Use the custom onPressed function
          style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all<Color>(Colors.blue[900]!),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              buttonName, // Use the custom buttonName for the text
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  MyCard({required this.agencyName, required this.aoe, required this.location, required this.imageurl,
  required this.email, required this.adminstratorName, required this.agencyType,
  required this.phoneNum, required this.pincode, required this.registrationNum, required this.state,
     });
  final String aoe;
  final String agencyName;
  final String location;
  final String imageurl;
  final String registrationNum;
  final String agencyType;
  final String adminstratorName;
  final String email;
  final String phoneNum;
  final String pincode;
  final String state;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to DetailScreenPage and pass agency details
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreenPage(
              agencyDetails: {
                'AgencyName': agencyName,
                'areaExpertise': aoe,
                'district': location,
                'imageUrl': imageurl,
                "RegistrationNum":registrationNum,
                "agencyType":agencyType,
                "adminstratorName":adminstratorName,
                "email":email,
                "phoneNum":phoneNum,
                "pincode":pincode,
                "state":state,
                // Add more fields here as needed
              },
            ),
          ),
        );
      },
      child: Card(
        //color: Colors.red[400],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Set the border radius
        ),
        elevation: 1, // Add elevation to the card
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: 60,
                    height: 65,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.blue[900]!, // Set the outline color to blue
                        width: 2.0, // Adjust the border width as needed
                      ),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        imageurl, // Replace with your image URL
                        fit: BoxFit.cover, // You can adjust the fit property as needed
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5,),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( agencyName, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                    SizedBox(height: 5,),
                    Text("AOE: "+ aoe, style: TextStyle(color: Colors.black),),
                    SizedBox(height: 5,),
                    Text("Location: "+ location, style: TextStyle(color: Colors.black),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class BottomAppBarItem extends StatelessWidget {
  final IconData icon;
  final Color defaultColor;
  final Color activeColor;
  final bool isActive;
  final VoidCallback onTap;

  BottomAppBarItem({
    required this.icon,
    required this.defaultColor,
    required this.activeColor,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? Colors.blue[900] : Colors.white,
          border: Border.all(
            color: isActive ? Colors.white : Colors.transparent,
            width: 2.0,
          ),
        ),
        child: Icon(
          icon,
          color: isActive ? Colors.white : defaultColor,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';


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
  MyCard({required this.cardText, required this.circleIcon, required this.circleColor, required this.titleText});
  final Icon circleIcon;
  final String cardText;
  final Color circleColor;
  final String titleText;
//
  //
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 160,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Set the border radius
        ),
        elevation: 0.5, // Add elevation to the card
        child: Column(
          children: [
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: circleColor, // Circular container background color
                    shape: BoxShape.circle,
                  ),
                  child: circleIcon, // Replace with your image asset path
                ),
              ),
            ),
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 0, right: 10, left: 10, bottom: 0),
                child: Text(titleText, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
              ),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.only(top: 0, right: 10, left: 10, bottom: 0),
              child: Text(cardText, style: TextStyle(color: Colors.grey),),
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
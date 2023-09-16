import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class DetailScreenPage extends StatelessWidget {
  final Map<String, dynamic> agencyDetails;

  DetailScreenPage({required this.agencyDetails});

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff161c2c),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.blue[900],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Agency Detail",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Row containing network image and agency details
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container for the network image
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 20),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.blue[900]!,
                        width: 3,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(agencyDetails['imageUrl']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  // Column for agency details
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Text(
                          capitalizeFirstLetter(agencyDetails['AgencyName']),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        height: 3,
                        width: 180,
                        color: Colors.blue[900],
                        margin: EdgeInsets.symmetric(vertical: 5),
                      ),
                      SizedBox(height: 5),
                      Text(
                        capitalizeFirstLetter(agencyDetails['areaExpertise']),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Add more details as needed
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  color:  Colors.blue[800]!,
                  elevation: 2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          "Description",
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "A Disaster Management Agency is a vital organization tasked with proactively planning,"
                              " coordinating, and responding to natural or man-made disasters. Its primary mission is "
                              "to safeguard lives, property.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  color:  Colors.blue[800]!,
                  elevation: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          "Other Information",
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                        Text(
                        "Email: ${agencyDetails['email'] ?? ""}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                          SizedBox(height: 5,),
                          Text(
                            "Registration Number: ${agencyDetails['registrationNum'] ?? ""}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                            SizedBox(height: 5,),
                          Text(
                            "State: ${agencyDetails['state'] ?? ""}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                            SizedBox(height: 5,),
                          Text(
                            "Phone Number: ${agencyDetails['phoneNum'] ?? ""}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                            SizedBox(height: 5,),
                          Text(
                            "Pincode: ${agencyDetails['pincode'] ?? ""}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                            SizedBox(height: 5,),
                          Text(
                            "Administrator Name: ${agencyDetails['adminstratorName'] ?? ""}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                            SizedBox(height: 5,),
                          Text(
                            "Agency Type: ${agencyDetails['agencyType'] ?? ""}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          )

                          ],
                        )
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


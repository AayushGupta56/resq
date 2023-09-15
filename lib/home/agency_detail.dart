import 'package:flutter/material.dart';

class DetailScreenPage extends StatelessWidget {
  final Map<String, dynamic> agencyDetails;

  DetailScreenPage({required this.agencyDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agency Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display agency details here
            ListTile(
              title: Text('Agency Name: ${agencyDetails['AgencyName']}'),
            ),
            ListTile(
              title: Text('Area of Expertise: ${agencyDetails['areaExpertise']}'),
            ),
            ListTile(
              title: Text('Location: ${agencyDetails['district']}'),
            ),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}

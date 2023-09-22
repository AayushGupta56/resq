import 'package:flutter/material.dart';
import 'package:resq/auth/login_screen.dart';
import 'package:resq/chat/hchat_screen.dart';
import 'package:resq/chat/notification_screen.dart';
import 'package:resq/services/auth_services.dart';
import 'package:resq/widgets/widgets.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../comman_design_code.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  AuthService authService = AuthService();
  TextEditingController _controller = TextEditingController();

  // Firestore reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  // Future method to fetch data from Firestore
  Future<List<QueryDocumentSnapshot>> fetchData() async {
    QuerySnapshot querySnapshot = await usersCollection.get();
    return querySnapshot.docs;
  }

  // Future method to fetch data from Firestore and get the total number of users
  Future<int> fetchTotalUsers() async {
    QuerySnapshot querySnapshot = await usersCollection.get();
    int totalUsers = querySnapshot.size;
    return totalUsers;
  }

  void _onSearch() {
    String searchText = _controller.text;
    // You can perform search operations with searchText here
    print('Searching for: $searchText');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff161c2c),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _page,
        height: 60.0,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
          ),
          Icon(
            Icons.message,
            size: 30,
          ),
          Icon(
            Icons.notifications_active,
            size: 30,
          ),
        ],
        color: Colors.blue[700]!,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _page = index;
          });
          switch (_page) {
            case 0:
              // Navigate to the HomeScreen
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomePage(),
              ));
              break;
            case 1:
              // Navigate to the ChatScreen
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CHomePage(),
              ));
              break;
            case 2:
              // Navigate to the NotificationScreen
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NotificationScreen(),
              ));
              break;
          }
        },
        letIndexChange: (index) => true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              // Set the width as needed
              height: MediaQuery.of(context).size.height * 0.23,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.blue[900],
                // Set the container's background color to blue
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  // Row with yellow circle and menu icon
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                //  height: 40,
                                width: MediaQuery.sizeOf(context).width * 0.6,
                                child: Card(
                                  elevation: 4.0, // Add elevation to the card
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: _controller,
                                            decoration: InputDecoration(
                                              hintText: 'Search',
                                              border: InputBorder
                                                  .none, // Remove the default border
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.search),
                                          onPressed: _onSearch,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  // Set the outline color to white
                                  width: 2.0, // Set the outline width
                                ),
                              ),
                              child: Icon(Icons.menu, color: Colors.white),
                            ),
                            onTap: (){
                              authService.signOut();
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: FutureBuilder<int>(
                      future: fetchTotalUsers(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData) {
                          return Text('Loading...');
                        } else {
                          int totalUsers = snapshot.data!;
                          return AnimatedCounter(
                            targetNumber: totalUsers,
                            duration: Duration(seconds: 3),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Use FutureBuilder to fetch data and build UI when data is available
            FutureBuilder<List<QueryDocumentSnapshot>>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No data available');
                } else {
                  // Use GridView.builder to display data in a grid
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            2, // You can adjust the number of columns
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        // Access data for each document and pass it to MyCard
                        Map<String, dynamic> userData = snapshot.data?[index]
                            .data() as Map<String, dynamic>;
                        return MyCard(
                          agencyName: userData['AgencyName'] ?? "",
                          aoe: userData['areaExpertise'] ?? "",
                          location: userData['district'] ?? "",
                          imageurl: userData['imageUrl'] ?? "",
                          email: userData['email'] ?? "",
                          registrationNum: userData['RegistrationNum'] ?? "",
                          state: userData['state'] ?? "",
                          phoneNum: userData['phoneNum'] ?? "",
                          pincode: userData['pincode'] ?? "",
                          adminstratorName: userData['adminstratorName'] ?? "",
                          agencyType: userData['agencyType'] ?? "",
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

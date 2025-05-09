import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.pink[50],
        centerTitle: true,
        title: Text("Profile"),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Get.back();
        //       },
        //       icon: Icon(Icons.arrow_back)),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage("assets/images/Bobo.jpg"),
              ),
            ),
            SizedBox(height: 20), // Add spacing if necessary
            Center(
                child: Text(
              "You are viewing the profile page",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
            ))
          ],
        ),
      ),
    );
  }
}

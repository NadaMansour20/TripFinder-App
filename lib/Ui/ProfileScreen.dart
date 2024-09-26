import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';  // Import Firebase Auth

class ProfileScreen extends StatelessWidget {
  final User? currentUser = FirebaseAuth.instance.currentUser;  // Fetch current logged-in user

  @override
  Widget build(BuildContext context) {
    String? name = currentUser?.displayName ?? "Trip Finder";  // Display user name
    String? email = currentUser?.email ?? "example@gmail.com";  // Display user email
    String password = '********';  // Hide password

    return Scaffold(
      backgroundColor: Colors.white,  // White background for the page
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with gradient and user info
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFA40CB7),  // Light Blue
                      Color(0xFFD26EE3),  // Purple
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('images/Untitled.png'),  // Replace with your asset path
                    ),
                    SizedBox(height: 16),
                    Text(
                      name,  // User name
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      email,  // User email
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Editable name field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  initialValue: name,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: Icon(Icons.person, color: Colors.purpleAccent),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Editable email field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  initialValue: email,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: Icon(Icons.email, color: Colors.purpleAccent),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Editable password field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  obscureText: true,
                  initialValue: password,  // To hide password
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: Icon(Icons.lock, color: Colors.purpleAccent),
                  ),
                ),
              ),
              SizedBox(height: 40),

              // Save button
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Success"),
                        content: Text("Changes saved successfully!"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();  // Close dialog
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.purple,
                  backgroundColor: Colors.white,
                ),
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Authentication

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  String? name;
  String? email;
  String? password;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;

    // Populate fields with user data
    if (user != null) {
      name = user!.displayName ?? "TripFinder";
      email = user!.email ?? "example@gmail.com";
      nameController.text = name!;
      emailController.text = email!;
    }
  }

  Future<void> _updateUserInfo() async {
    try {
      // Update the display name if changed
      if (nameController.text != name) {
        await user!.updateDisplayName(nameController.text);
      }

      // Update email if changed
      if (emailController.text != email) {
        await user!.updateEmail(emailController.text);
      }

      // Update password if entered
      if (passwordController.text.isNotEmpty) {
        await user!.updatePassword(passwordController.text);
      }

      await user!.reload(); // Reload user to get updated info

      setState(() {
        user = _auth.currentUser; // Update user instance
        name = user!.displayName;
        email = user!.email;
      });

      // Show success message
      _showSuccessDialog();
    } catch (e) {
      // Handle error, such as re-authentication or other issues
      print(e.toString());
      _showErrorDialog(e);
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("Changes saved successfully!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(dynamic error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text("Failed to save changes: $error"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background for the page
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
                      Color(0xFFA40CB7), // Light Blue
                      Color(0xFFD26EE3), // Purple
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
                      backgroundImage: AssetImage(
                          'images/Untitled.png'), // Replace with your asset path
                    ),
                    SizedBox(height: 16),
                    Text(
                      name ?? "Trip Finder", // Use Firebase $name
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      email ?? "example@gmail.com", // Use Firebase $email
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
                  controller: nameController,
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
                  controller: emailController,
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
                  controller: passwordController,
                  obscureText: true, // Hide password
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
                  _updateUserInfo(); // Save changes to Firebase
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

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tripfinder_app/Login.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? currentUser;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    fetchUserData(); // استدعاء وظيفة لجلب بيانات المستخدم
  }

  // دالة لجلب بيانات المستخدم من Firestore
  Future<void> fetchUserData() async {
    if (currentUser != null) {
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          nameController.text = userDoc.data()?['username'] ?? 'User';
          emailController.text = userDoc.data()?['email'] ?? '*****@.com';
          passwordController.text = '*******';
        });
      } else {
        print('Document does not exist');
      }
    } else {
      print('No user logged in');
    }
  }

  Future<void> updateUserData() async {
    if (currentUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .update({
        'username': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Editable name field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: nameController,  // يربط TextField بالبيانات
                    decoration: InputDecoration(
                      labelText: 'Name',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Editable email field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: emailController,  // يربط TextField بالبيانات
                    decoration: InputDecoration(
                      labelText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Password field (for display purposes only)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: passwordController,  // placeholder للباسورد
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                ),
                SizedBox(height: 40),

                // Save button
                ElevatedButton(
                  onPressed: () {
                    updateUserData();  // استدعاء الدالة لتحديث البيانات
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Success!"),
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
                SizedBox(height: 20),

                // Logout button
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[300],
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text('Logout'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

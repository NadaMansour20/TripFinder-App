import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isEditing = false;
  User? _user;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _user = _auth.currentUser;
    if (_user != null) {
      // Load user name from Firestore
     // var userData = await _firestore.collection('users').doc(_user!.uid).get();
     //  setState(() {
     //    _nameController.text = userData['name'];
     //    _emailController.text = _user!.email!;
     //  });
    }
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  Future<void> _saveChanges() async {
    try {
      if (_user != null) {
        // Update Firebase Authentication email
        await _user!.updateEmail(_emailController.text);

        // Update Firebase Authentication password
        if (_passwordController.text.isNotEmpty) {
          await _user!.updatePassword(_passwordController.text);
        }

        // Update Firestore with new name
      /*  await _firestore.collection('users').doc(_user!.uid).update({
          'name': _nameController.text,
        });*/

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $e')),
      );
    }

    setState(() {
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          _isEditing
              ? IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveChanges,
          )
              : IconButton(
            icon: Icon(Icons.edit),
            onPressed: _toggleEditMode,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
              enabled: _isEditing,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              enabled: _isEditing,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'New Password'),
              enabled: _isEditing,
              obscureText: true,
            ),
            if (_isEditing)
              ElevatedButton(
                onPressed: _saveChanges,
                child: Text('Save Changes'),
              ),
          ],
        ),
      ),
    );
  }
}

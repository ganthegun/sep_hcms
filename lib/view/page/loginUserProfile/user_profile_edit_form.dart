import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sep_hcms/provider/login_user_profile_provider.dart'; // Import the provider
import 'package:sep_hcms/domain/login_user_profile.dart'; // Import the model
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileEditForm extends StatefulWidget {
  final LoginUserProfileProvider controller;
  UserProfileEditForm({super.key, required this.controller});

  @override
  State<UserProfileEditForm> createState() => _UserProfileEditFormState();
}

class _UserProfileEditFormState extends State<UserProfileEditForm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _icController = TextEditingController();
  final _genderController = TextEditingController();
  final _ageController = TextEditingController();

  LoginUserProfile? _userProfile;
  var _userEmail;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    User? user = _auth.currentUser;
    if (user == null) {
      throw Exception('No user is logged in');
    }
    try {
      LoginUserProfile? profile =
          await widget.controller.indexProfile(user.uid);
      setState(() {
        _userProfile = profile;
        _nameController.text = profile?.userName ?? "N/A";
        _icController.text = profile?.userIc ?? "N/A";
        _genderController.text = profile?.userGender ?? "N/A";
        _ageController.text = profile?.userAge.toString() ?? "N/A";
        _userEmail = profile?.userEmail ?? "N/A";
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching profile: $e')),
      );
    }
  }

  Future<void> _updateProfile() async {
    // Validate the form
    if (_formKey.currentState!.validate()) {
      try {
        await widget.controller.updateProfile(
          name: _nameController.text,
          ic: _icController.text,
          gender: _genderController.text,
          age: int.parse(_ageController.text),
          email: _userEmail,
          password: _userProfile?.userPassword ?? '',
          confirmedPassword: _userProfile?.userConfirmedPassword ?? '',
          role: _userProfile?.userRole ?? '',
        );
        context.go('/userProfileEditSuccess');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          BackButton(
                            onPressed: () {
                              context.go('/userProfilePage');
                            },
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Editing My Profile',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: Image.asset(
                              'assets/ProfilePicture.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 5,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 125, 185, 14),
                                elevation: 5,
                              ),
                              onPressed: () {},
                              child: Icon(
                                Icons.edit,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Table(
                        columnWidths: {0: FlexColumnWidth(0.35)},
                        children: [
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Name: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SizedBox(
                                  height: 30,
                                  child: TextFormField(
                                    controller: _nameController,
                                    decoration: InputDecoration(
                                      hintText: _nameController.text,
                                      hintStyle: TextStyle(color: Colors.grey),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          context.go('/UserProfileEditError');
                                        });
                                        return ''; // Return an empty string to indicate validation failure
                                      }
                                      return null; // Return null if the input is valid
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'NRIC: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SizedBox(
                                  height: 30,
                                  child: TextFormField(
                                    controller: _icController,
                                    decoration: InputDecoration(
                                      hintText: _icController.text,
                                      hintStyle: TextStyle(color: Colors.grey),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          context.go('/UserProfileEditError');
                                        });
                                        return ''; // Return an empty string to indicate validation failure
                                      }
                                      return null; // Return null if the input is valid
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Gender: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SizedBox(
                                  height: 30,
                                  child: TextFormField(
                                    controller: _genderController,
                                    decoration: InputDecoration(
                                      hintText: _genderController.text,
                                      hintStyle: TextStyle(color: Colors.grey),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          context.go('/UserProfileEditError');
                                        });
                                        return ''; // Return an empty string to indicate validation failure
                                      }
                                      return null; // Return null if the input is valid
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Age: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SizedBox(
                                  height: 30,
                                  child: TextFormField(
                                    controller: _ageController,
                                    keyboardType:
                                        TextInputType.numberWithOptions(),
                                    decoration: InputDecoration(
                                      hintText: _ageController.text,
                                      hintStyle: TextStyle(color: Colors.grey),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          context.go('/UserProfileEditError');
                                        });
                                        return ''; // Return an empty string to indicate validation failure
                                      }
                                      return null; // Return null if the input is valid
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Email Address: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 15, 0, 0),
                                child: SizedBox(
                                  height: 30,
                                  child: Text(
                                    _userEmail,
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 120,
                        child: ElevatedButton(
                          onPressed: () {
                            _updateProfile();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 125, 185, 14),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

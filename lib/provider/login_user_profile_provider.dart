import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sep_hcms/domain/login_user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginUserProfileProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Read: Fetch a single user profile by userId
  Future<LoginUserProfile?> indexProfile(String userId) async {
    User? user = _auth.currentUser;
    if (user == null) {
      throw Exception('No user is logged in');
    }

    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(user.uid).get();

      return LoginUserProfile.read(doc.data() as Map<String, dynamic>);
    } catch (e) {
      print('Error fetching user profile: $e');
    }
    return null;
  }

  // Update: Update an existing user profile
  Future<void> updateProfile(
      {required String name,
      required String ic,
      required String gender,
      required int age,
      required String email,
      required String password,
      required String confirmedPassword,
      required String role}) async {
    User? user = _auth.currentUser;
    if (user == null) {
      throw Exception('No user is logged in');
    }

    // Update profile data in Firestore
    await _firestore.collection('users').doc(user.uid).set({
      'user_name': name,
      'user_ic': ic,
      'user_gender': gender,
      'user_age': age,
      'user_email': email,
      'user_password': password,
      'user_confirmedPassword': confirmedPassword,
      'user_role': role,
    });
  }
}

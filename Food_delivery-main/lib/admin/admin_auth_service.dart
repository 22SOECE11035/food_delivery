import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to register a new admin
  Future<String?> registerAdmin({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Create user with email and password
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user from the credential
      User? user = userCredential.user;

      // Check if user is not null
      if (user != null) {
        // Add user details to Firestore
        await _firestore.collection('Users').doc(user.uid).set({
          'name': name,
          'email': email,
          'isAdmin': true, // Set isAdmin to true for admin registration
          'createdAt': Timestamp.now(),
        });

        return null; // No error
      } else {
        return 'Admin registration failed';
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase Auth errors
      return e.message;
    } catch (e) {
      // Handle any other errors
      return 'An error occurred: $e';
    }
  }
}

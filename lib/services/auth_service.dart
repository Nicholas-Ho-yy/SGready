// SGReady Final Year Project
// Developed by: Nicholas Ho
//
// The SGReady-specific authentication service and account creation logic
// in this file were developed by me.
//
// Firebase Authentication and Cloud Firestore are external Firebase services
// used to manage user accounts, authentication and account information.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Handles user authentication and account details.
class AuthService {
  AuthService({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Creates a new account and saves the user's details in Firestore.
  Future<UserCredential> createAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    // After Firebase creates the account, save the user's name and
    // initial SGReady account information.
    final user = credential.user;

    if (user != null) {
      await user.updateDisplayName(name.trim());

      // Store the account details in Firestore and start new users
      // with onboarding not yet completed.
      await _firestore.collection('users').doc(user.uid).set({
        'name': name.trim(),
        'email': email.trim(),
        'onboardingCompleted': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    return credential;
  }

  /// Signs an existing user in using their email and password.
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  /// Signs the currently authenticated user out.
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  /// Sends a Firebase password reset email to the user's email address.
  Future<void> sendPasswordResetEmail({
    required String email,
  }) {
    return _firebaseAuth.sendPasswordResetEmail(
      email: email.trim(),
    );
  }
}

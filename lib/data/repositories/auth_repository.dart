

import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// LOGIN
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {

      switch (e.code) {

        case 'user-not-found':
          throw Exception('User not found');

        case 'wrong-password':
          throw Exception('Wrong password');

        case 'invalid-email':
          throw Exception('Invalid email');

        case 'invalid-credential':
          throw Exception('Invalid email or password');

        default:
          throw Exception(
            e.message ?? 'Login failed',
          );
      }
    }
  }

  /// CURRENT USER
  User? get currentUser => _auth.currentUser;

  /// CHECK LOGIN
  bool get isLoggedIn => _auth.currentUser != null;

  /// LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
  }
}
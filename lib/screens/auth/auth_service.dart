import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

/// Wraps Firebase Authentication: sign up, login, logout, password reset.
/// Extends ChangeNotifier so UI can react to loading/error state.
class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool isLoading = false;
  String? errorMessage;

  /// Stream that fires whenever the login state changes
  /// (used by AuthGate in main.dart to switch screens automatically).
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

  /// ---------- SIGN UP (create new account) ----------
  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      // Save display name on the Firebase Auth profile
      await credential.user?.updateDisplayName(name);

      errorMessage = null;
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      errorMessage = _friendlyError(e.code);
      _setLoading(false);
      return false;
    }
  }

  /// ---------- LOGIN ----------
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      errorMessage = null;
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      errorMessage = _friendlyError(e.code);
      _setLoading(false);
      return false;
    }
  }

  /// ---------- LOGOUT ----------
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// ---------- FORGOT PASSWORD ----------
  Future<bool> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
      return true;
    } on FirebaseAuthException catch (e) {
      errorMessage = _friendlyError(e.code);
      return false;
    }
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  /// Converts Firebase's raw error codes into readable messages.
  String _friendlyError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered. Please login instead.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'Password should be at least 6 characters.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
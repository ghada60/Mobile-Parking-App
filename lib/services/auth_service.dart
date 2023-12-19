// firebase auth service class
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // create user obj based on firebase user
  User? _userFromFirebaseUser(User? user) {
    return user! != null ? user : null;
  }
  // auth change user stream
  Stream<User?> get user {
    return _auth.authStateChanges()
      .map(_userFromFirebaseUser);
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential  result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
  // register with email and password
  Future registerWithEmailAndPassword(String? email, String? password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email!, password: password!);
      User? user = result.user;
      print(user!);
      return _userFromFirebaseUser(user!);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.message;
    }
  }
  // sign out
  Future signOut() async {
    try {
       await _auth.signOut();
       return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // signin as a guest
  Future signInAsGuest() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      print(user!);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return false;
    }
  }

  // forgot password
  Future<Map<bool, String>> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return {true: 'Password reset email sent'};
    } on FirebaseAuthException catch (e) {
      return {false: e.message.toString()};
    }
  }
  // get signed in user
  Future<User?> getCurrentUser() async {
    try {
      User? user = _auth.currentUser;
      return user;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
  }
}
import 'package:fresh_fish/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'database.dart';
class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// sign in with email and password

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
  // sign in with facebook
  Future signInWithfacebook() async {

      final facebookLogin = new FacebookLogin();
      final result = await facebookLogin.logIn(['email']);
      FacebookAccessToken facebookAccessToken = result.accessToken;
      AuthCredential authCredential = FacebookAuthProvider.getCredential(accessToken: facebookAccessToken.token);
      FirebaseUser fbUser;
      fbUser = (await _auth.signInWithCredential(authCredential)).user;
      return fbUser;
  }
  // sign in with google
  Future signInWithgoogle() async {

    GoogleSignIn _googleSignIn = new GoogleSignIn();
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult  User = (await _auth.signInWithCredential(credential));
    return User.user;
  }
// register with email and password
  Future registerWithEmailAndPassword(String name,String email, String password,String address, String phone) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseService(uid:user.uid).setUserData(email,name,address,phone);
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
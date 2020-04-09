import 'package:app/views/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseUser _firebaseUser;
GoogleSignIn _googleSignIn = GoogleSignIn();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.amber, accentColor: Colors.amberAccent),
      initialRoute: '/',
      routes: {
        '/': (context) => Welkom(),
        '/bibs': (context) => Home(),
      },
    );
  }
}

class Welkom extends StatefulWidget {
  @override
  _WelkomState createState() => _WelkomState();
}

Future<FirebaseUser> _handleSignIn() async {
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
  print("signed in " + user.displayName);
  return user;
}

class _WelkomState extends State<Welkom> {
  @override
  void initState() {
    super.initState();
    login();
  }

  void login() async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home(user: user)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GoogleSignInButton(
          splashColor: Colors.white70,
          onPressed: () async {
            FirebaseUser user = await _handleSignIn();
            if (user != null) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Home(user: user)));
            }
          },
        ),
      ),
    );
  }
}

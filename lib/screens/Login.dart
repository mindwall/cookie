import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
/* import 'package:font_awesome_flutter/font_awesome_flutter.dart'; */
import '../services/services.dart';
import '../shared/shared.dart';
import 'package:apple_sign_in/apple_sign_in.dart';

class LoginScreen extends StatefulWidget {
  createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  AuthService auth = AuthService();

  @override
  void initState() {
    super.initState();
    auth.getUser.then(
      (user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFC400),
      body: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 30),
            CookieLogo(
              title: 'Cookie',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Image.asset(
              "assets/cookie@2x.png",
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            Text(
              'Login to open the cookie jar',
              style: GoogleFonts.marmelad(
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            LoginButton(
              text: 'LOGIN WITH GOOGLE',
              icon: Image.asset(
                "assets/G_Logo.svg.png",
                width: 30.0,
                height: 30.0,
              ),
              color: Colors.white,
              loginMethod: auth.googleSignIn,
            ),
            SizedBox(height: 20),
            FlatButton(
                child: Text('Continue as Guest',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: auth.anonLogin),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

/// A resuable login button for multiple auth methods
class LoginButton extends StatelessWidget {
  final Color color;
  final Image icon;
  final String text;
  final Function loginMethod;

  const LoginButton(
      {Key key, this.text, this.icon, this.color, this.loginMethod})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 0),
      child: FlatButton.icon(
        padding: EdgeInsets.all(20),
        icon: icon,
        color: color,
        onPressed: () async {
          var user = await loginMethod();
          if (user != null) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
        label: Expanded(
          child: Text('$text',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black38)),
        ),
      ),
    );
  }
}
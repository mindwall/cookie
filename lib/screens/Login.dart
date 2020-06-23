import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
/* import 'package:font_awesome_flutter/font_awesome_flutter.dart'; */
import '../services/services.dart';
import '../shared/shared.dart';
/* import 'package:apple_sign_in/apple_sign_in.dart'; */

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
            SizedBox(height: 90),
            CookieLogo(
              title: 'Cookie',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Image.asset(
              "assets/cookie@2x.png",
              width: 130,
              height: 130,
            ),
            SizedBox(height: 20),
            Text(
              'Login to open the cookie jar',
              style: GoogleFonts.marmelad(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            LoginButton(
              text: 'Sign in with Google',
              icon: Image.asset(
                "assets/G_Logo.svg.png",
                width: 24.0,
                height: 24.0,
              ),
              color: Colors.white,
              loginMethod: auth.googleSignIn,
            ),
            SizedBox(height: 20),
            LoginButtonGuest(
              text: 'Continiue as Guest',
              logAnon: auth.anonLogin,
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class LoginButtonGuest extends StatelessWidget {
  final String text;
  final Function logAnon;

  const LoginButtonGuest({this.text, this.logAnon});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
        onPressed: () async {
          var user = await logAnon();
          if (user != null) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        });
  }
}

/// A resuable login button for multiple auth methods
class LoginButton extends StatelessWidget {
  final Color color;
  final Image icon;
  final String text;
  final Function loginMethod;

  const LoginButton(
      {Key key, this.text, this.loginMethod, this.icon, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(7)),
      child: Container(
        margin: EdgeInsets.only(bottom: 0, left: 0),
        child: FlatButton.icon(
          padding: EdgeInsets.only(left: 70, top: 20, bottom: 20, right: 55),
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
                style: TextStyle(color: Colors.black45)),
          ),
        ),
      ),
    );
  }
}

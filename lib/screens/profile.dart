import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class ProfileView extends StatelessWidget {
  final double topMargin;
  final double leftMargin;
  final double height;
  final bool isVisible;

  const ProfileView({
    Key key,
    this.topMargin,
    this.height,
    this.isVisible,
    this.leftMargin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topMargin,
      left: leftMargin,
      right: 0,
      height: height,
      child: AnimatedOpacity(
        opacity: isVisible ? 1 : 0,
        duration: Duration(milliseconds: 200),
        child: Container(

            /*  padding: EdgeInsets.only(left: height).add(EdgeInsets.all(8)), */
            child: _buildContent()),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: <Widget>[
        Text(
          'Profile',
          style: GoogleFonts.josefinSlab(
            fontSize: 30,
            fontWeight: FontWeight.w300,
            letterSpacing: 2.5,
          ),
        ),
        SizedBox(height: 20),
        CircleAvatar(
          backgroundColor: Color(0xFFFF5800),
          radius: 50,
          backgroundImage: AssetImage('assets/me.jpg'),
        ),
        SizedBox(height: 10),
        Text(
          'Ivan Tonev',
          style: GoogleFonts.josefinSlab(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.5,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Recipes : 2',
          style: GoogleFonts.josefinSlab(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            letterSpacing: 1,
          ),
        ),
        Spacer(),
        FlatButton(
          color: Colors.red[600],
          onPressed: () {
            navigatorKey.currentState.pushNamed("/");
          },
          child: Text('Logout',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              )),
        ),
        SizedBox(height: 10),
        Text(
          'read the legals',
          style: GoogleFonts.josefinSlab(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.5,
          ),
        )
      ],
    );
  }
}

import 'package:cookie/shared/shared.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 8),
                SizedBox(height: 40),
                SizedBox(height: 8),
              ],
            ),
          ),
          CoolMenu(), //use this or ScrollableExhibitionSheet
        ],
      ),
    );
  }
}

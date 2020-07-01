import 'package:cookie/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Basket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF362E2E),
      body: Stack(
        children: <Widget>[
          PreferredSize(
            preferredSize: Size.fromHeight(80.0 +
                MediaQuery.of(context).padding.top), // here the desired height
            child: MyAppBar(),
          ),
          Pantry(),
          CoolMenu()
        ],
      ),
    );
  }
}

class Pantry extends StatelessWidget {
  const Pantry({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 130),
          Text(
            'Shop by Recipe',
            style: GoogleFonts.josefinSlab(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                letterSpacing: 2.5,
                height: 0.1),
          ),
          SizedBox(height: 20),
          ButtonsRow(),
          SizedBox(height: 50),
          Text(
            'You might by out of',
            style: GoogleFonts.josefinSlab(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                letterSpacing: 2.5,
                height: 0.1),
          ),
          SizedBox(height: 20),
          ButtonsRow(),
          SizedBox(height: 50),
          Text(
            'Create a New Shopping List',
            style: GoogleFonts.josefinSlab(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                letterSpacing: 2.5,
                height: 0.1),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: OutlineButton(
              onPressed: () {},
              /* fillColor: Colors.transparent, */
              child: Icon(
                Icons.add,
                size: 45.0,
                color: Colors.white12,
              ),
              padding: EdgeInsets.all(20.0),
              shape: CircleBorder(
                  side: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                      style: BorderStyle.solid)),
            ),
          ),
        ],
      ),
    );
  }
}

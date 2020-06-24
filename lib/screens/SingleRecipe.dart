import 'package:cookie/services/Models.dart';
import 'package:cookie/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleRecipe extends StatelessWidget {
  final Recipe recipe;

  SingleRecipe({this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF362E2E),
      body: Column(children: [
        Hero(
          tag: recipe.image,
          child: Image(image: recipe.image),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                recipe.title,
                style: GoogleFonts.libreBaskerville(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2,
                    color: Color(0xFFFFA143)),
              ),
              Text(
                recipe.cusine,
                style: GoogleFonts.josefinSlab(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 2.5,
                ),
              ),
            ],
          ),
        ),
        // Time and Cook
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Row(
            children: [
              SizedBox(width: 5),
              Icon(
                Icons.access_alarm,
                color: Colors.green[300],
                size: 14,
              ),
              Text(
                recipe.time,
                style: GoogleFonts.josefinSlab(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                  color: Colors.green[300],
                ),
              ),
              SizedBox(width: 155),
              Text(
                'By ${recipe.cook}',
                style: GoogleFonts.josefinSlab(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 2.5,
                ),
              ),
            ],
          )),
        ),
        SizedBox(height: 15),
        OutlineButton(
          child: Text(
            'View Steps',
            style: GoogleFonts.libreBaskerville(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: 2,
                color: Color(0xFFFFA143)),
          ),
          onPressed: () {
            //bottommodalsheet
          },
          padding:
              EdgeInsets.only(top: 12.5, bottom: 12.5, left: 70, right: 70),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                  color: Colors.black, width: 2.0, style: BorderStyle.solid)),
        ),
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends StatelessWidget {
  String label;
  InputField({
    Key key,
    this.label,
    @required this.editingController,
  }) : super(key: key);

  final TextEditingController editingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: TextField(
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Lato',
          ),
          onChanged: (value) {
            /*  filterSearchResults(value); */
          },
          controller: editingController,
          decoration: InputDecoration(
              labelText: label,
              /* hintText: "Title", */
              //hintStyle: Theme.of(context).textTheme.headline4)
              labelStyle: GoogleFonts.satisfy(
                fontSize: 20,
                color: Colors.white24,
                height: 1,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18.0)))),
        ),
      ),
    );
  }
}

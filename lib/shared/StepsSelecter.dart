import 'package:cookie/services/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextEditingController stepEditor = TextEditingController();

var steps = List<Steps>();
var recipeSteps = List<Steps>();

class StepsSelecter extends StatefulWidget {
  StepsSelecter({Key key}) : super(key: key);
  static List<Steps> getRecipeSteps() => steps;

  @override
  _StepsSelecterState createState() => _StepsSelecterState();
}

Steps addStep() {
  return Steps(
    action: stepEditor.text,
    orderId: steps.length + 1,
  );
}

void addStepList(Steps step) {
  steps.add(step);
}

class _StepsSelecterState extends State<StepsSelecter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(7.0),
          child: TextField(
            style: TextStyle(
              fontSize: 24.0,
              fontFamily: 'Lato',
            ),
            maxLines: 5,
            onChanged: (value) {
              /*   filterSearchResults(value); */
            },
            controller: stepEditor,
            decoration: InputDecoration(
                labelText: "Step",
                hintText: "Step",
                //hintStyle: Theme.of(context).textTheme.headline4)
                labelStyle: GoogleFonts.satisfy(
                  fontSize: 24,
                ),
                hintStyle: GoogleFonts.satisfy(
                    fontSize: 24, color: Colors.white10, height: 1),
                prefixIcon: SizedBox(width: 10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)))),
          ),
        ),
        MaterialButton(
          onPressed: () {
            setState(() {
              Steps a = addStep();
              addStepList(a);
              stepEditor.clear();
            });
          },
          minWidth: MediaQuery.of(context).size.width * 0.9,
          color: Colors.amber,
          child: Text('Add Step',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              )),
        ),
        Container(
          child: ListView.builder(
            padding: const EdgeInsets.all(3.0),
            shrinkWrap: true,
            itemCount: steps.length,
            itemBuilder: (context, index) {
              return Card(
                color: Color(0xFF4A3E3E),
                child: ListTile(
                  /*  onTap: DatabaseService().tappedOn(items[index].toString()), */
                  title: Text(
                    '${steps[index].action}',
                    style: GoogleFonts.libreBaskerville(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 3,
                        color: Color(0xFFFFA143)),
                    /* style: TextStyle(fontSize: 32.0, color: Color(0xFFFFA143)), */
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}

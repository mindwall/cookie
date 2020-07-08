import 'package:cookie/services/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextEditingController editingController = TextEditingController();

var items = List<Ingredient>();
var recipeIngredients = List<Ingredient>();
List<Ingredient> allIngredients;

class IngredientSelecter extends StatefulWidget {
  IngredientSelecter({Key key}) : super(key: key);
  static List<Ingredient> getRecipeIngredient() {
    return recipeIngredients;
  }

  @override
  _IngredientSelecterState createState() => _IngredientSelecterState();
}

class _IngredientSelecterState extends State<IngredientSelecter> {
  /*  List<Ingredient> ingredients = allIngredients; */

  void fetchAllIngredients() async {
    allIngredients = await DatabaseService().getAllIngredients();
  }

  void initState() {
    super.initState();
    fetchAllIngredients();
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<Ingredient> listData = List<Ingredient>();
      allIngredients.forEach((item) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          listData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(listData);
      });
      return;
    } else {
      setState(() {
        items.clear();
      });
    }
  }

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
            onChanged: (value) {
              filterSearchResults(value);
            },
            controller: editingController,
            decoration: InputDecoration(
                labelText: "Search",
                hintText: "search",
                //hintStyle: Theme.of(context).textTheme.headline4)
                labelStyle: GoogleFonts.satisfy(
                  fontSize: 24,
                ),
                hintStyle: GoogleFonts.satisfy(
                    fontSize: 24, color: Colors.white10, height: 1),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)))),
          ),
        ),
        if (items.length > 0)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(3.0),
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      items[index].isSelected = true;
                      recipeIngredients.add(items[index]);
                      editingController.clear();
                    });
                  },
                  onLongPress: () {
                    setState(() {
                      items[index].isSelected = true;
                    });
                  },
                  child: Card(
                    color: Color(0xFF4A3E3E),
                    child: ListTile(
                      /*  onTap: DatabaseService().tappedOn(items[index].toString()), */
                      title: Text(
                        '${items[index].name}',
                        style: GoogleFonts.libreBaskerville(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 3,
                            color: items[index].isSelected
                                ? Colors.white
                                : Color(0xFFFFA143)),
                        /* style: TextStyle(fontSize: 32.0, color: Color(0xFFFFA143)), */
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        if (recipeIngredients.length > 0)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(3.0),
              shrinkWrap: true,
              itemCount: recipeIngredients.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Color(0xFF4A3E3E),
                  child: ListTile(
                    /*  onTap: DatabaseService().tappedOn(items[index].toString()), */
                    title: Text(
                      '${recipeIngredients[index].name}',
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

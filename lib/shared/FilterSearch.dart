import 'package:cookie/localData/IngridientsData.dart';
import 'package:cookie/services/Models.dart';
import 'package:cookie/services/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipeFilterSearch extends StatefulWidget {
  RecipeFilterSearch({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RecipeFilterSearch createState() => _RecipeFilterSearch();
}

class _RecipeFilterSearch extends State<RecipeFilterSearch> {
  List<Ingredient> allIngredients;
  TextEditingController editingController = TextEditingController();
  var items = List<String>();
  var duplicatedItems = List<String>();
  bool pressed = true;

  void _showSearch() {
    setState(() {
      pressed = false;
    });
  }

  void initState() {
    super.initState();
  }

  void filterSearchResults(String query) {
    List<Ingredient> searchList = List<Ingredient>();
    searchList.addAll(allIngredients);
    if (query.isNotEmpty) {
      List<String> listData = List<String>();
      searchList.forEach((item) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          listData.add(item.name);
        }
      });
      setState(() {
        items.clear();
        items.addAll(listData);
      });
      return;
    } else {
      List<String> displayList = List<String>();
      searchList.forEach((element) {
        displayList.add(element.name);
      });
      setState(() {
        items.clear();
        items.addAll(displayList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Fish',
          style: GoogleFonts.josefinSlab(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
            color: Color(0xFFFF5800),
          ),
        ),
        Text(
          'Dinner',
          style: GoogleFonts.josefinSlab(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              color: Color(0xFFFF5800)),
        ),
        Text(
          'Sweet',
          style: GoogleFonts.josefinSlab(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              color: Color(0xFFFF5800)),
        ),
        Text(
          'Veggie',
          style: GoogleFonts.josefinSlab(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              color: Color(0xFFFF5800)),
        ),
        ImageIcon(
          AssetImage("assets/search@2x.png"),
          color: Colors.white24,
        )
      ],
    );
  }
}

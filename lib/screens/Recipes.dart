import 'package:cookie/screens/screens.dart';
import 'package:cookie/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:cookie/localData/RecipeData.dart';
import 'package:cookie/services/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Recipes extends StatelessWidget {
  final List<Recipe> recipes = cookBook;

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
          Column(
            children: [
              SizedBox(height: 120),
              ButtonsRow(),
              SizedBox(height: 20),
              RecipeFilterSearch(),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: GridView.count(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(8),
                  crossAxisCount: 2,
                  childAspectRatio: 4 / 5,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 8,
                  children: recipes
                      .map((recipe) => RecipeThumb(recipe: recipe))
                      .toList(),
                ),
              )
            ],
          ),
          CoolMenu(),
        ],
      ),
    );
  }
}

class RecipeThumb extends StatelessWidget {
  final Recipe recipe;
  // New dup method for Recipe Thumb and change above from list to single
  const RecipeThumb({Key key, this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: recipe.image,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => SingleRecipe(recipe: recipe),
            ),
          );
        },
        child: Container(
          width: 160,
          height: 300,
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: recipe.image,
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.black38, BlendMode.darken)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black45, blurRadius: 10, offset: Offset(5, 2))
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title,
                      style: GoogleFonts.libreBaskerville(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 2,
                          color: Color(0xFFFFA143)),
                      /* style: TextStyle(fontSize: 32.0, color: Color(0xFFFFA143)), */
                    ),
                    Text(
                      recipe.cusine,
                      style: GoogleFonts.josefinSlab(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 2.5,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Row(
                    children: [
                      SizedBox(width: 5),
                      Icon(
                        Icons.access_alarm,
                        color: Colors.green[300],
                        size: 12,
                      ),
                      Text(
                        recipe.time,
                        style: GoogleFonts.josefinSlab(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                          color: Colors.green[300],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

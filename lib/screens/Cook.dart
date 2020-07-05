import 'package:cookie/screens/screens.dart';
import 'package:cookie/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:cookie/localData/RecipeData.dart';
import 'package:cookie/services/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Cook extends StatelessWidget {
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
          RecipeSlider(),
          CoolMenu(), //use this or ScrollableExhibitionSheet
        ],
      ),
      /*  bottomNavigationBar: AppBottomNav(), */
    );
  }
}

class RecipeSlider extends StatefulWidget {
  @override
  _RecipeSliderState createState() => _RecipeSliderState();
}

class _RecipeSliderState extends State<RecipeSlider> {
  final PageController ctrl = PageController(viewportFraction: 0.85);
  List<Recipe> recipes = cookBook;
  int currentPage = 0;

  @override
  void initState() {
    ctrl.addListener(() {
      int next = ctrl.page.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 130,
          left: 123,
          child: Center(
            child: Text(
              'Top Recipes',
              style: GoogleFonts.josefinSlab(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 2.5,
                  height: 0.1),
            ),
          ),
        ),
        Positioned(
          child: PageView(
            controller: ctrl,
            children: recipes
                .map((recipe) => RecipePreview(
                    recipe: recipe,
                    top: recipes.indexOf(recipe) == currentPage ? 170 : 260,
                    blur: 30,
                    offset: 10))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class RecipePreview extends StatelessWidget {
  const RecipePreview(
      {Key key,
      @required this.top,
      @required this.blur,
      @required this.offset,
      this.recipe})
      : super(key: key);

  final double top;
  final double blur;
  final double offset;
  final Recipe recipe;

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
        child: AnimatedContainer(
          duration: Duration(milliseconds: 700),
          curve: Curves.easeOutQuint,
          margin: EdgeInsets.only(top: top, bottom: 120, right: 33),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: recipe.image,
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.black38, BlendMode.darken)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black45,
                  blurRadius: blur,
                  offset: Offset(offset, offset))
            ],
          ),
          child: Material(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Widget
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Material(
                        child: Text(
                          recipe.title,
                          style: GoogleFonts.libreBaskerville(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 2,
                              color: Color(0xFFFFA143)),
                        ),
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
                      Spacer(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

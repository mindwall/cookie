import 'dart:io';

import 'package:cookie/services/Auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/services.dart';
import 'screens/screens.dart';
import 'shared/shared.dart';
import 'package:provider/provider.dart';
import 'localData/IngridientsData.dart';
import 'dart:developer' as developer;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<FirebaseUser>.value(
            value: AuthService().user,
          )
        ],
        child: MaterialApp(
          title: 'Cookie',
          navigatorKey: navigatorKey,
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
          ],
          // ignore: missing_return
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 250),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        child: child,
                        opacity: animation,
                      );
                    },
                    pageBuilder: (context, animation, secAnimation) =>
                        LoginScreen());
              case '/recipes':
                return PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 250),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        child: child,
                        opacity: animation,
                      );
                    },
                    pageBuilder: (context, animation, secAnimation) =>
                        Recipes());
              case '/shopping':
                return PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 250),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        child: child,
                        opacity: animation,
                      );
                    },
                    pageBuilder: (context, animation, secAnimation) =>
                        Basket());
              case '/cooking':
                return PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 250),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        child: child,
                        opacity: animation,
                      );
                    },
                    pageBuilder: (context, animation, secAnimation) => Cook());
              case '/addrecipe':
                return PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 250),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        child: child,
                        opacity: animation,
                      );
                    },
                    pageBuilder: (context, animation, secAnimation) =>
                        AddRecipe());
              case '/profile':
                return PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 250),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        child: child,
                        opacity: animation,
                      );
                    },
                    pageBuilder: (context, animation, secAnimation) =>
                        Profile());
              case '/home':
                return PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 250),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        child: child,
                        opacity: animation,
                      );
                    },
                    pageBuilder: (context, animation, secAnimation) =>
                        MyHomePage());
            }
          },
          /*    routes: {
            '/': (context) => LoginScreen(),
            '/recipes': (context) => Recipes(),
            '/shopping': (context) => Basket(),
            '/cooking': (context) => Cook(),
            '/home': (context) => MyHomePage(),
          }, */
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // Define the default brightness and colors.
            brightness: Brightness.dark,
            primaryColor: Colors.amber[700],
            backgroundColor: Color(0xFF362E2E),
            accentColor: Colors.amber[700],
            canvasColor: Colors.transparent,

            fontFamily: 'Lato',
            appBarTheme: AppBarTheme(),
            // Define the default TextTheme. Use this to specify the default
            // text styling for headlines, titles, bodies of text, and more.
            textTheme: TextTheme(
              headline1: TextStyle(
                  fontSize: 72.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              headline3: TextStyle(fontSize: 36.0, color: Colors.white),
              headline4: TextStyle(fontSize: 26.0, color: Color(0xFFFFA143)),
              caption: TextStyle(
                  fontSize: 64.0,
                  fontFamily: 'BrushScript',
                  color: Colors.white),
              headline5: GoogleFonts.pacifico(
                  fontSize: 42,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.5,
                  color: Colors.white),
              subtitle1: TextStyle(
                  fontSize: 95, fontFamily: 'BrushScript', color: Colors.white),
              bodyText2: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}

TextEditingController editingController = TextEditingController();
var items = List<String>();
bool pressed = true;
List<Ingredient> allIngredients;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*  List<Ingredient> ingredients = allIngredients; */

  void _showSearch() {
    setState(() {
      pressed == true ? pressed = false : pressed = false;
    });
  }

  void fetchAllIngredients() async {
    allIngredients = await DatabaseService().getAllIngredients();
  }

  void initState() {
    super.initState();
    fetchAllIngredients();
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<String> listData = List<String>();
      allIngredients.forEach((item) {
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
      allIngredients.forEach((element) {
        displayList.add(element.name);
      });
      setState(() {
        items.clear();
        items.addAll(displayList);
      });
    }
  }

  addTappedToList(String ingredient) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF362E2E),
      resizeToAvoidBottomPadding: false,
      /* appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0 +
            MediaQuery.of(context).padding.top), // here the desired height
        child: MyAppBar(),
      ), */
      body: Stack(
        children: <Widget>[
          PreferredSize(
            preferredSize: Size.fromHeight(80.0 +
                MediaQuery.of(context).padding.top), // here the desired height
            child: MyAppBar(),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/backdrop.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                pressed
                    ? OutlineButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                        /* fillColor: Colors.transparent, */

                        padding: EdgeInsets.all(42.5),
                        shape: CircleBorder(
                            side: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                                style: BorderStyle.solid)),
                      )
                    : PreferredSize(
                        preferredSize: Size.fromHeight(
                            220.0 + MediaQuery.of(context).padding.top),
                        child: Container(
                          height: 100,
                          child: Padding(
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
                                      fontSize: 24,
                                      color: Colors.white10,
                                      height: 1),
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)))),
                            ),
                          ),
                        ),
                      ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(3.0),
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Color(0xFF4A3E3E),
                        child: ListTile(
                          onTap: DatabaseService()
                              .tappedOn(items[index].toString()),
                          title: Text(
                            '${items[index]}',
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
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 50,
            child: FlatButton(
              onPressed: _showSearch,
              child: ImageIcon(
                AssetImage("assets/search@2x.png"),
                color: Colors.white24,
              ),
            ),
          ),
          CoolMenu(),
        ],
      ),
    );
  }
}

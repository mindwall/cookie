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
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
          ],
          routes: {
            '/': (context) => LoginScreen(),
            '/recipes': (context) => Recipes(),
            '/shopping': (context) => Basket(),
            '/cooking': (context) => Cook(),
            '/home': (context) => MyHomePage(),
          },
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // Define the default brightness and colors.
            brightness: Brightness.dark,
            primaryColor: Colors.amber[700],
            backgroundColor: Color(0xFF362E2E),
            accentColor: Colors.amber[700],

            fontFamily: 'Lato',
            appBarTheme: AppBarTheme(),
            // Define the default TextTheme. Use this to specify the default
            // text styling for headlines, titles, bodies of text, and more.
            textTheme: TextTheme(
              headline1: TextStyle(
                  fontSize: 72.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              headline4: TextStyle(fontSize: 36.0, color: Colors.white),
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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF362E2E),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0 +
            MediaQuery.of(context).padding.top), // here the desired height
        child: MyAppBar(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the Button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            FlatButton(
                child: Text('Nuff Cookies'),
                onPressed: () async {
                  await AuthService().signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                }),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar:
          AppBottomNav(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

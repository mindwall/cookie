import "package:flutter/material.dart";

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[new MyAppBar(), new Container()],
    );
  }
}

class MyAppBar extends StatelessWidget {
  final double barHeight = 80.0; // change this for different heights
  final Color backgroundcolor = Color(0xFF362E2E);
  final String title = 'Cookie';

  MyAppBar();

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      padding: new EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: new Center(
        child: Transform(
            transform: Matrix4(1.0, -0.067156, 0.0, 0.0, -0.007156, 1.0, 0.0,
                0.0, 0.0, 0.0, 10.0, 0.0, 0.0, -15.0, 0.0, 1.0),
            child: new Text(title, style: Theme.of(context).textTheme.caption)),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AppBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xFFFF5800),
      items: [
        BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/cook.png"),
              color: Color(0xFFffffff),
            ),
            title: Text('Cook')),
        BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/chef.png"),
              color: Color(0xFFffffff),
            ),
            title: Text('Recipes')),
        BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/basket.png"),
              color: Color(0xFFffffff),
            ),
            title: Text('Basket')),
      ].toList(),
      fixedColor: Color(0xFFffffff),
      onTap: (int idx) {
        switch (idx) {
          case 0:
            // do nuttin
            Navigator.pushNamed(context, '/cooking');
            break;
          case 1:
            Navigator.pushNamed(context, '/recipes');
            break;
          case 2:
            Navigator.pushNamed(context, '/shopping');
            break;
        }
      },
    );
  }
}

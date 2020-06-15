import 'package:flutter/material.dart';

class AppBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(17),
        topRight: Radius.circular(17),
      ),
      child: BottomNavigationBar(
        backgroundColor: Color(0xFFFF5800),
        items: [
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/cook@2x.png"),
                color: Color(0xFFffffff),
              ),
              title: Text('Cook', style: TextStyle(fontSize: 12.0))),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/chef@2x.png"),
                color: Color(0xFFffffff),
              ),
              title: Text('Recipes', style: TextStyle(fontSize: 12.0))),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/basket@2x.png"),
                color: Color(0xFFffffff),
              ),
              title: Text('Basket', style: TextStyle(fontSize: 12.0))),
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
      ),
    );
  }
}

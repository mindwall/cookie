import 'package:cookie/shared/shared.dart';
import 'package:flutter/material.dart';

class Recipes extends StatelessWidget {
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
        child: Text('List of Recipes'),
      ),
      bottomNavigationBar: AppBottomNav(),
    );
  }
}

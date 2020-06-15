import 'package:flutter/material.dart';

class AddRecipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Recipe'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text('Add a new Recipe...'),
      ),
    );
  }
}

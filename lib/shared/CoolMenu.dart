import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';

const double minHeight = 120;

class ExhibitionBottomSheet extends StatefulWidget {
  createState() => _ExhibitionBottomSheetState();
}

class _ExhibitionBottomSheetState extends State<ExhibitionBottomSheet>
    with SingleTickerProviderStateMixin {
  AnimationController _controller; //<-- Create a controller

  double get maxHeight =>
      MediaQuery.of(context).size.height; //<-- Get max height of the screen

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      //<-- initialize a controller
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); //<-- and remember to dispose it!
    super.dispose();
  }

  double lerp(double min, double max) =>
      lerpDouble(min, max, _controller.value);

  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          height: lerp(minHeight,
              maxHeight), //<-- update height value to scale with controller
          left: 0,
          right: 0,
          bottom: 0,
          child: GestureDetector(
            //<-- add a gesture detector
            onTap: _toggle,
            onVerticalDragUpdate:
                _handleDragUpdate, //<-- Add verticalDragUpdate callback
            onVerticalDragEnd: _handleDragEnd, //<-- on tap...
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              decoration: const BoxDecoration(
                color: Color(0xFFFF5800),
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Stack(
                //<-- Add a stack
                children: <Widget>[
                  BottomNavigationBar(
                    backgroundColor: Color(0xFFFF5800),
                    elevation: 0,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    iconSize: 36,
                    items: [
                      BottomNavigationBarItem(
                          icon: ImageIcon(
                            AssetImage("assets/cook@2x.png"),
                            color: Color(0xFFffffff),
                          ),
                          title:
                              Text('Cook', style: TextStyle(fontSize: 12.0))),
                      BottomNavigationBarItem(
                          icon: ImageIcon(
                            AssetImage("assets/chef@2x.png"),
                            color: Color(0xFFffffff),
                          ),
                          title: Text('Recipes',
                              style: TextStyle(fontSize: 12.0))),
                      BottomNavigationBarItem(
                          icon: ImageIcon(
                            AssetImage("assets/basket@2x.png"),
                            color: Color(0xFFffffff),
                          ),
                          title:
                              Text('Basket', style: TextStyle(fontSize: 12.0))),
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
                  ), //<-- With a menu button
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _toggle() {
    final bool isOpen = _controller.status == AnimationStatus.completed;
    _controller.fling(
        velocity: isOpen ? -2 : 2); //<-- ...snap the sheet in proper direction
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _controller.value -= details.primaryDelta /
        maxHeight; //<-- Update the _controller.value by the movement done by user.
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;

    final double flingVelocity = details.velocity.pixelsPerSecond.dy /
        maxHeight; //<-- calculate the velocity of the gesture
    if (flingVelocity < 0.0)
      _controller.fling(
          velocity: max(2.0, -flingVelocity)); //<-- either continue it upwards
    else if (flingVelocity > 0.0)
      _controller.fling(
          velocity: min(-2.0, -flingVelocity)); //<-- or continue it downwards
    else
      _controller.fling(
          velocity: _controller.value < 0.5
              ? -2.0
              : 2.0); //<-- or just continue to whichever edge is closer
  }
}

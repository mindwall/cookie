import 'dart:ui';
import 'dart:math';

import 'package:cookie/screens/screens.dart';
import 'package:flutter/material.dart';

const double minHeight = 95;
const double iconStartSize = 34; //<-- add edge values
const double iconEndSize = 32; //<-- add edge values
const double iconStartMarginTop = 22; //<-- add edge values
const double iconEndMarginTop = 100; //<-- add edge values //<-- add edge values
const double iconsVerticalSpacing = 100; //<-- add edge values
const double iconsHorizontalSpacing = 20; //<-- add edge values

class CoolMenu extends StatefulWidget {
  createState() => _CoolMenuState();
}

class _CoolMenuState extends State<CoolMenu>
    with SingleTickerProviderStateMixin {
  AnimationController _controller; //<-- Create a controller

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

//<-- Get max height of the screen
  double get maxHeight => MediaQuery.of(context).size.height;
  double get itemBorderRadius => lerp(8, 24); //<-- increase item border radius

  double get iconSize =>
      lerp(iconStartSize, iconEndSize); //<-- increase icon size

  double iconTopMargin(int index) => lerp(iconStartMarginTop,
      iconEndMarginTop + index * (iconsVerticalSpacing + iconEndSize));
  /* + headerTopMargin; */ //<-- calculate top margin based on header margin, and size of all of icons above (from small to big)

  double iconLeftMargin(int index) => lerp(
      index * 0.9 * (35 + iconStartSize * 1.5),
      0); //<-- calculate left margin (from big to small)

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
                  MenuIcon(),
                  Container(
                    child: Positioned(
                      height: iconSize, //<-- Specify icon's size
                      width: iconSize, //<-- Specify icon's size
                      top: iconTopMargin(1), //<-- Specify icon's top margin
                      left: iconLeftMargin(1),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/cooking');
                        },
                        child: Image.asset(
                          'assets/cook@2x.png',
                          fit: BoxFit.cover,
                          alignment: Alignment(lerp(1, 0), 0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Positioned(
                      height: iconSize, //<-- Specify icon's size
                      width: iconSize, //<-- Specify icon's size
                      top: iconTopMargin(2), //<-- Specify icon's top margin
                      left: iconLeftMargin(2),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/recipes');
                        },
                        child: Image.asset(
                          'assets/chef@2x.png',
                          fit: BoxFit.cover,
                          alignment: Alignment(lerp(1, 0), 0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Positioned(
                      height: iconSize, //<-- Specify icon's size
                      width: iconSize, //<-- Specify icon's size
                      top: iconTopMargin(3), //<-- Specify icon's top margin
                      left: iconLeftMargin(3),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/shopping');
                        },
                        child: Image.asset(
                          'assets/basket@2x.png',
                          fit: BoxFit.cover,
                          alignment: Alignment(lerp(1, 0), 0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: ProfileView(
                      topMargin:
                          150, //<--provide margins and height same as for icon
                      leftMargin: 70,
                      height: 500,
                      isVisible: _controller.status ==
                          AnimationStatus.completed, //<--set visibility
                    ),
                  ),
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

class MenuIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      //<-- Align the icon to bottom right corner
      left: 0,
      bottom: 35,
      child: Icon(
        Icons.menu,
        color: Colors.white,
        size: 28,
      ),
    );
  }
}

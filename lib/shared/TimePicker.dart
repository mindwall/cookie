import 'package:cookie/screens/AddRecipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final minutes = Iterable<int>.generate(61).toList();
final hours = Iterable<int>.generate(13).toList();
int selectedMinutes;
int selectedHours;

class TimePicker extends StatefulWidget {
  static int getSelectedMinutes() => selectedMinutes;
  static int getSelectedHours() => selectedHours;
  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  final PageController ctrl = PageController(
    viewportFraction: 0.15,
    initialPage: 0,
  );
  final PageController ctrl2 = PageController(
    viewportFraction: 0.15,
    initialPage: 0,
  );

  int currentPage = 0;
  int currentPageH = 0;
  int t; //Tid
  double p; //Position

  @override
  // ignore: must_call_super
  void initState() {
    ctrl.addListener(() {
      int next = ctrl.page.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
          selectedMinutes = currentPage;
        });
      }
    });
    ctrl2.addListener(() {
      int nextH = ctrl2.page.round();
      if (currentPageH != nextH) {
        setState(() {
          currentPageH = nextH;
          selectedHours = currentPageH;
        });
      }
    });
  }

  @override
  void dispose() {
    ctrl.dispose();
    ctrl2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Text('Hours',
            style: GoogleFonts.josefinSlab(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              letterSpacing: 2.5,
            )),
        Container(
          height: 70,
          width: width * 0.9,
          child: PageView(
            controller: ctrl2,
            /* padding: EdgeInsets.only(left: (MediaQuery.of(context).size.width / 2)), */
            scrollDirection: Axis.horizontal,
            physics: CustomScrollPhysics(),
            children: hours
                .map((e) => Picker(
                    time: e,
                    color: hours.indexOf(e) == currentPageH
                        ? Colors.white
                        : (hours.indexOf(e) < currentPageH - 2)
                            ? Colors.white10
                            : (hours.indexOf(e) > currentPageH + 2)
                                ? Colors.white10
                                : Colors.white24,
                    hero: hours.indexOf(e) == currentPageH ? 24 : 20))
                .toList(),
          ),
        ),
        Text('Minutes',
            style: GoogleFonts.josefinSlab(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              letterSpacing: 2.5,
            )),
        Listener(
          onPointerMove: (pos) {
            //Get pointer position when pointer moves
            //If time since last scroll is undefined or over 100 milliseconds
            if (t == null || DateTime.now().millisecondsSinceEpoch - t > 100) {
              t = DateTime.now().millisecondsSinceEpoch;
              p = pos.position.dx; //x position
            } else {
              //Calculate velocity
              double v = (p - pos.position.dx) /
                  (DateTime.now().millisecondsSinceEpoch - t);
              if (v < -2 || v > 2) {
                //Don't run if velocity is to low
                //Move to page based on velocity (increase velocity multiplier to scroll further)
                ctrl.animateToPage(currentPage + (v * 2.8).round(),
                    duration: Duration(milliseconds: 600),
                    curve: Curves.easeOutCubic);
              }
            }
          },
          child: Container(
            height: 70,
            width: width * 0.9,
            child: PageView(
              controller: ctrl,

              /* padding: EdgeInsets.only(left: (MediaQuery.of(context).size.width / 2)), */
              scrollDirection: Axis.horizontal,
              physics: CustomScrollPhysics(),
              children: minutes
                  .map((e) => Picker(
                      time: e,
                      color: minutes.indexOf(e) == currentPage
                          ? Colors.white
                          : (minutes.indexOf(e) < currentPage - 2)
                              ? Colors.white10
                              : (minutes.indexOf(e) > currentPage + 2)
                                  ? Colors.white10
                                  : Colors.white24,
                      hero: minutes.indexOf(e) == currentPage ? 23 : 18))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomScrollPhysics extends ClampingScrollPhysics {
  const CustomScrollPhysics({ScrollPhysics parent}) : super(parent: parent);

  @override
  double get minFlingVelocity => double.infinity;

  @override
  double get maxFlingVelocity => double.infinity;

  @override
  double get minFlingDistance => double.infinity;

  double carriedMomentum(double existingVelocity) {
    if (parent == null) return 0.0;
    return parent.carriedMomentum(existingVelocity);
  }

  @override
  CustomScrollPhysics applyTo(ScrollPhysics ancestor) {
    return CustomScrollPhysics(parent: buildParent(ancestor));
  }
}

class Picker extends StatelessWidget {
  final int time;
  final double hero;
  final Color color;

  const Picker({
    this.color,
    this.hero,
    this.time,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
        child: Center(
          child: Text(
            time.toString(),
            style: GoogleFonts.josefinSlab(
              fontSize: hero,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cookie/screens/AddRecipe.dart';
import 'package:flutter/material.dart';

class ButtonsRow extends StatelessWidget {
  const ButtonsRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 20, right: 30),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: OutlineButton(
              onPressed: () {
                showModalBottomSheet(
                    useRootNavigator: true,
                    barrierColor: Colors.black26,
                    enableDrag: true,
                    isScrollControlled: true,
                    context: context,
                    clipBehavior: Clip.antiAlias,
                    builder: (context) {
                      return FractionallySizedBox(
                        heightFactor: 0.8,
                        child: AddRecipe(),
                      );
                    });
                /* Navigator.pushNamed(context, '/addrecipe'); */
              },
              /* fillColor: Colors.transparent, */
              child: Icon(
                Icons.add,
                size: 45.0,
                color: Colors.white12,
              ),
              padding: EdgeInsets.all(20.0),
              shape: CircleBorder(
                  side: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                      style: BorderStyle.solid)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: OutlineButton(
              onPressed: () {},
              /* fillColor: Colors.transparent, */

              padding: EdgeInsets.all(42.5),
              shape: CircleBorder(
                  side: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                      style: BorderStyle.solid)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: OutlineButton(
              onPressed: () {},
              /* fillColor: Colors.transparent, */

              padding: EdgeInsets.all(42.5),
              shape: CircleBorder(
                  side: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                      style: BorderStyle.solid)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: OutlineButton(
              onPressed: () {},
              /* fillColor: Colors.transparent, */

              padding: EdgeInsets.all(42.5),
              shape: CircleBorder(
                  side: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                      style: BorderStyle.solid)),
            ),
          )
        ],
      ),
    );
  }
}

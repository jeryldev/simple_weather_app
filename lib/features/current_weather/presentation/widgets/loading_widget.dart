import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.tealAccent[400],
                Colors.cyan[300],
                // Colors.orange,
                // Colors.orange[900]
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              // stops: [0.15, 1.00],
            ),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          )),
    );
  }
}

import 'package:flutter/material.dart';

class MessageDisplayWidget extends StatelessWidget {
  final String messageText;
  final List<Color> gradientColorList;
  const MessageDisplayWidget({
    Key key,
    @required this.messageText,
    @required this.gradientColorList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColorList,
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            // stops: [0.15, 1.00],
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Center(
          child: Text(
            messageText,
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              // fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

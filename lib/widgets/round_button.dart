import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class RoundButton extends StatelessWidget {
  final String title;
  const RoundButton({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.deepPurple,
      ),
      child: Center(child: Text(title),),
    );
  }
}

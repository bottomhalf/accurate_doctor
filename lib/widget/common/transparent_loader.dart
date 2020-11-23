import 'package:flutter/material.dart';

class TransparentLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, .6),
      ),
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

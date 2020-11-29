import 'package:flutter/material.dart';

class OnBoarding extends StatelessWidget {
  String title;
  String message1;
  String message2;
  String imgpath = '';
  OnBoarding({
    @required this.title,
    @required imgpath,
    @required this.message1,
    this.message2,
  }) {
    this.imgpath = imgpath;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Image(
              image: AssetImage(this.imgpath),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            this.title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Wrap(
            children: [
              Text(
                this.message1,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                this.message2,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

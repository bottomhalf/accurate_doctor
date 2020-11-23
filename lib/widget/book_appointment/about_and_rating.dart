import 'package:flutter/material.dart';

class AboutAndRating extends StatelessWidget {
  String aboutMessage;
  double rating;

  AboutAndRating({@required this.aboutMessage, @required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'About',
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(
              top: 10,
              bottom: 20,
            ),
            child: Text(
              this.aboutMessage,
            ),
          ),
          Text(
            'Rate',
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star),
                Icon(Icons.star_half),
                Icon(Icons.star_border),
              ],
            ),
          )
        ],
      ),
    );
  }
}

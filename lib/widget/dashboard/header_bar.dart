import 'package:flutter/material.dart';

class HeaderBar extends StatelessWidget {
  final String Username;
  final String Location;

  HeaderBar(this.Username, this.Location);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white30,
          ),
        ),
        color: Theme.of(context).textTheme.headline1.color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 20,
            height: MediaQuery.of(context).size.height * .02,
            child: MaterialButton(
              elevation: 0,
              onPressed: null,
              padding: EdgeInsets.zero,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).textTheme.headline1.color,
                ),
                child: Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ),
          ),
          Text(
            'Location',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            this.Location,
            style: TextStyle(color: Colors.white),
          ),
          Container(
            width: 20,
            height: MediaQuery.of(context).size.height * .025,
            child: MaterialButton(
              elevation: 0,
              onPressed: () {},
              padding: EdgeInsets.zero,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).textTheme.headline1.color,
                ),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

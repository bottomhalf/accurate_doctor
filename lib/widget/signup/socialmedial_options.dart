import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SocialMedialOptions extends StatelessWidget {
  final double _fieldGap = 12;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Alerady have an account?',
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              MaterialButton(
                minWidth: 0,
                padding: EdgeInsets.all(0),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Or',
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
            ],
          ),
          SizedBox(
            height: _fieldGap,
          ),
          Center(
            child: Text(
              'Enter via social networks',
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
          ),
          SizedBox(
            height: _fieldGap,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: RaisedButton(
                  child: Container(
                    height: 42,
                    child: Icon(AntDesign.googleplus),
                  ),
                  color: Colors.redAccent,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: Colors.redAccent,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: RaisedButton(
                  child: Container(
                    height: 42,
                    child: Icon(FontAwesome.facebook_f),
                  ),
                  color: Configuration.ColorFromHex('#3898ab'),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: Configuration.ColorFromHex('#3898ab'),
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

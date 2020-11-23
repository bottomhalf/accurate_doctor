import '../../navigation/NavigationPage.dart';
import 'package:flutter/material.dart';

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
              const Text('Alerady have an account?'),
              MaterialButton(
                minWidth: 0,
                padding: EdgeInsets.all(0),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(NavigationPage.SignIn);
                },
                child: const Text('Sign In'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Divider(
                thickness: 2.0,
              ),
              Text('Or'),
              Divider(
                thickness: 2.0,
              ),
            ],
          ),
          SizedBox(
            height: _fieldGap,
          ),
          Center(
            child: Text('Enter via social networks'),
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
                    child: Icon(Icons.plus_one),
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
                    child: Icon(Icons.plus_one),
                  ),
                  color: Colors.deepPurpleAccent,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: Colors.deepPurpleAccent,
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

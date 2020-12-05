import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Configuration {
  static double _height;
  static double _width;
  static bool _isAndroid;
  static double _pagePadding = 18;
  static double fieldGap = 12;
  static String _defaultImgUrl =
      'https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png';

  static double get pagePadding => _pagePadding;
  static String get defaultImgUrl => _defaultImgUrl;
  static bool isDoctor = false;
  static String _currency = "INR";

  static double get height => _height;

  static set height(double value) {
    _height = value;
  }

  static double get width => _width;

  static String get currency => _currency;

  static set currency(String value) {
    _currency = value;
  }

  static bool get isAndroid => _isAndroid;

  static set isAndroid(bool value) {
    _isAndroid = value;
  }

  static set width(double value) {
    _width = value;
  }

  static Color ColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }

  static bool isValidEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  static String getStringValue(dynamic value) {
    String returnValue = "";
    if (value != null) {
      returnValue = value.toString();
    }
    return returnValue;
  }

  static Widget getImage(String imageUrl) {
    CachedNetworkImage image;
    try {
      image = CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Image.network(
            "http://imobicloud1.healthygx.com/Images/users/83588-1593068015553_3-512.png"),
      );

      return image;
    } catch (e) {
      return Image.network(
          "http://imobicloud1.healthygx.com/Images/users/83588-1593068015553_3-512.png");
    }
  }

  static Future<void> showPopup(
      BuildContext context, String title, List<String> msgs) {
    return showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w700,
              color: Theme.of(context).accentColor,
              fontStyle: FontStyle.normal,
              fontSize: 20,
            ),
          ),
          content: Wrap(
            children: [
              ...msgs.map((e) {
                return Container(
                  child: Text(e),
                );
              }).toList(),
            ],
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Ok',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

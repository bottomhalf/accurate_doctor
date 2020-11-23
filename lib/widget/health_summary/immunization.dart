import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class Immunizations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Configuration.pagePadding),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.help),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.print),
              ),
            ],
          ),
          Container(
            child: Text(
                'This is a list of immunizations that your clinic has a file for you'),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Influenza Quadrivalent MDCK preservative',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text('Dates on file: '),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.info),
                    ),
                    Text('Learn More'),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 15,
            ),
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Meningococcal MCV40',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text('Dates on file: '),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.info),
                    ),
                    Text('Learn More'),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 15,
            ),
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tdap',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text('Dates on file: '),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.info),
                    ),
                    Text('Learn More'),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 15,
            ),
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: TextField(
              maxLines: 4,
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: OutlineButton(
              color: Theme.of(context).accentColor,
              borderSide: BorderSide(
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {},
              child: Text('Add a Personal Note'),
            ),
          )
        ],
      ),
    );
  }
}

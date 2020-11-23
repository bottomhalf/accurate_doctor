import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:flutter/material.dart';

class AppointmentFor extends StatefulWidget {
  @override
  _AppointmentForState createState() => _AppointmentForState();
}

class _AppointmentForState extends State<AppointmentFor> {
  bool forMe = true;
  void _secondOpinionForMe() {}
  void _secondOpinionForFamily() {}
  Color textColorMe;
  Color bgColorMe;
  Color textColor;
  Color bgColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      changeApptType(true);
    });
  }

  void changeApptType(bool isFamily) {
    setState(() {
      this.textColorMe =
          isFamily ? Theme.of(context).accentColor : Colors.white;
      this.bgColorMe = isFamily ? Colors.white : Theme.of(context).accentColor;
      this.textColor = isFamily ? Colors.white : Theme.of(context).accentColor;
      this.bgColor = isFamily ? Theme.of(context).accentColor : Colors.white;
      forMe = !isFamily;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'For whom are you booking appointment',
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  this.changeApptType(false);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: this.bgColorMe == null
                        ? Theme.of(context).accentColor
                        : this.bgColorMe,
                    border: Border.all(
                      color: Theme.of(context).accentColor,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  margin: EdgeInsets.symmetric(horizontal: 0),
                  child: Text(
                    'For me',
                    style: TextStyle(
                      color: this.textColorMe == null
                          ? Colors.white
                          : this.textColorMe,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  this.changeApptType(true);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: this.bgColor == null ? Colors.white : this.bgColor,
                    border: Border.all(
                      color: Theme.of(context).accentColor,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin: EdgeInsets.symmetric(horizontal: 0),
                  child: Text(
                    'For family member',
                    style: TextStyle(
                      color: this.textColor == null
                          ? Colors.white
                          : this.textColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

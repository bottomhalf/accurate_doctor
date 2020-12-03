import 'package:accurate_doctor/modal/map.dart';
import 'package:accurate_doctor/modal/personal_detail.dart';
import 'package:accurate_doctor/modal/user_detail.dart';
import 'package:accurate_doctor/provider/localDb.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class DrawerItem extends StatefulWidget {
  final IconData icon;
  final String name;
  final String nav;
  final bool isReplaced;
  final bool isSubmenu;
  final List<KeyMap> subMunes;
  dynamic args;

  DrawerItem({
    @required this.name,
    @required this.icon,
    @required this.nav,
    this.isReplaced = true,
    this.isSubmenu = false,
    this.subMunes,
    this.args,
  }) {
    if (this.args == null || this.args == "") this.args = "";
  }

  @override
  _DrawerItemState createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  bool isExpanded = false;
  final double subMenuVerticalSpace = 10;

  Widget subMenu() {
    if (this.widget.isSubmenu) {
      return Container(
        height: 20,
        alignment: Alignment.bottomRight,
        child: IconButton(
          alignment: Alignment.bottomRight,
          padding: EdgeInsets.all(0),
          color: Colors.black,
          icon: Icon(
            this.isExpanded
                ? Icons.keyboard_arrow_up
                : Icons.keyboard_arrow_down,
            size: 20,
            color: Colors.black,
          ),
          onPressed: null,
        ),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      /*decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),*/
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              if (widget.isSubmenu) {
                setState(() {
                  this.isExpanded = !this.isExpanded;
                });
              } else {
                if (this.widget.isReplaced) {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.of(context).pushReplacementNamed(this.widget.nav,
                      arguments: widget.args);
                } else {
                  print('Testing: ${this.widget.name}');
                  switch (this.widget.name) {
                    case 'Logout':
                      LocalDb local = LocalDb.internal();
                      UserDetail userDetail = UserDetail.instance;
                      local
                          .deleteById(PersonalDetailModal.UserDetailTable,
                              userDetail.UserId)
                          .then((value) {
                        if (value) {
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.of(context)
                              .pushReplacementNamed(this.widget.nav);
                        }
                      });
                      break;
                    default:
                      Navigator.of(context).pop();
                      Navigator.of(context)
                          .pushNamed(this.widget.nav, arguments: widget.args);
                      break;
                  }
                }
              }
            },
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  color: Theme.of(context).accentColor,
                  size: 20.0,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                this.subMenu(),
              ],
            ),
          ),
          isExpanded
              ? Container(
                  padding: EdgeInsets.only(
                    left: 30,
                  ),
                  margin: EdgeInsets.only(
                    top: 10,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.subMunes.length,
                    itemBuilder: (ctx, index) {
                      return Container(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed(
                                widget.subMunes.elementAt(index).value);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: subMenuVerticalSpace,
                            ),
                            child: Text(
                              widget.subMunes.elementAt(index).key,
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                        ),
                        width: double.infinity,
                      );
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

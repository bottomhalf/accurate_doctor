import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpandableCard extends StatefulWidget {
  Widget cardTitle;
  Widget body;
  ExpandableCard({this.cardTitle, this.body});
  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  bool isForward = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceOut,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              if (!isForward)
                _animationController.forward();
              else
                _animationController.reverse();
              isForward = !isForward;
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: widget.cardTitle,
            ),
          ),
          SizeTransition(
            sizeFactor: _animation,
            axis: Axis.vertical,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
              padding: EdgeInsets.all(Configuration.fieldGap),
              child: widget.body,
            ),
          ),
        ],
      ),
    );
  }
}

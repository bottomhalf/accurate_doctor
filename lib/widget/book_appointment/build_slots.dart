import 'package:accurate_doctor/modal/Configuration.dart';

import '../../modal/booking_request.dart';
import '../../widget/book_appointment/appointment_button.dart';
import 'package:flutter/material.dart';

class BuildSlots extends StatefulWidget {
  List<dynamic> slots;
  bool isMorning;
  BookingSlotModal modal;

  BuildSlots({@required this.slots, this.isMorning, this.modal});

  @override
  _BuildSlotsState createState() => _BuildSlotsState();
}

class _BuildSlotsState extends State<BuildSlots> {
  List<dynamic> bindingSlots;

  @override
  void initState() {
    this.bindingSlots = widget.slots;
    super.initState();
  }

  void updateSelectedSlot(int requestedIndex) {
    int index = 0;
    while (index < this.bindingSlots.length) {
      if (this.bindingSlots.elementAt(index)['index'] == requestedIndex) {
        this.bindingSlots.elementAt(index)['IsEnabled'] = true;
        widget.modal.strBookTime =
            this.bindingSlots.elementAt(index)['StartTime'];
        widget.modal.intPatientId =
            this.bindingSlots.elementAt(index)['UserId'];

        widget.modal.intBranchId =
            this.bindingSlots.elementAt(index)['intBranchId'];

        print(
            'Slot: ${widget.modal.strBookTime}, Id: ${widget.modal.intPatientId}, BranchId: ${widget.modal.intBranchId}');
      } else {
        this.bindingSlots.elementAt(index)['IsEnabled'] = false;
      }
      index++;
    }

    setState(() {
      bindingSlots = this.bindingSlots;
    });
  }

  List<Widget> _buildSlotCard(bool isMorning) {
    List<Widget> cards = List<Widget>();
    int index = 0;
    while (index < this.bindingSlots.length) {
      if (isMorning &&
          this.bindingSlots.elementAt(index)['StatusDay'] == 'Morning') {
        cards.add(
          AppointmentButton(
            index: this.bindingSlots.elementAt(index)['index'],
            text: this.bindingSlots.elementAt(index)['StartTime'],
            marginGeometry: EdgeInsets.all(4),
            paddingGeometry: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            textColor: Colors.deepPurple,
            minWidth: 0,
            bgColor: Colors.white,
            isAvaible:
                this.bindingSlots.elementAt(index)['SlotStatus'] == "Booked"
                    ? false
                    : true,
            isEnabled: this.bindingSlots.elementAt(index)['IsEnabled'],
            onSelected: updateSelectedSlot,
          ),
        );
      } else if (!isMorning &&
          this.bindingSlots.elementAt(index)['StatusDay'] != 'Morning') {
        cards.add(
          AppointmentButton(
            index: this.bindingSlots.elementAt(index)['index'],
            text: this.bindingSlots.elementAt(index)['StartTime'],
            marginGeometry: EdgeInsets.all(4),
            paddingGeometry: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            textColor: Colors.deepPurple,
            minWidth: 0,
            bgColor: Colors.white,
            isAvaible:
                this.bindingSlots.elementAt(index)['SlotStatus'] == "Booked"
                    ? false
                    : true,
            isEnabled: this.bindingSlots.elementAt(index)['IsEnabled'],
            onSelected: updateSelectedSlot,
          ),
        );
      }
      index++;
    }
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Configuration.pagePadding),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.wb_sunny),
              SizedBox(
                width: 4,
              ),
              Text(
                'Morning',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: 4,
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: _buildSlotCard(true),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Icon(
                Icons.brightness_4,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                'Evening',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: 4,
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: _buildSlotCard(false),
            ),
          ),
        ],
      ),
    );

    /*Wrap(
      alignment: WrapAlignment.spaceBetween,
      children: _buildSlotCard(),
    );*/
  }
}

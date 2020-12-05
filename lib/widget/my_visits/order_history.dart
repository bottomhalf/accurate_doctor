import 'package:accurate_doctor/services/ajax_call.dart';
import 'package:accurate_doctor/widget/my_visits/order_history_filter.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  List<dynamic> serviceTypes = [];
  List<dynamic> booked = [];
  AjaxCall http;
  dynamic searchQuery = {
    "intPatientId": -1,
    "intServiceTypeId": 0,
    "intStatusId": 0,
    "strOrderDate": "",
    "strScheduleDate": ""
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    http = AjaxCall.getInstance;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      http.get("Common/GetServicetype").then((serviceStateData) {
        if (serviceStateData != null) {
          List<dynamic> data = json.decode(serviceStateData);
          serviceTypes = [];
          serviceTypes.add({
            "intServiceTypeId": -1,
            "strServiceType": "All Service",
            "strSpecialityName": null
          });

          if (data != null) {
            int index = 0;
            while (index < data.length) {
              this.serviceTypes.add(data.elementAt(index));
              index++;
            }
          }
        }
        setState(() {
          booked = booked;
          serviceTypes = serviceTypes;
        });
      });

      http.get("Common/GetStatusList").then((bookedStateDate) {
        if (bookedStateDate != null) {
          List<dynamic> data = json.decode(bookedStateDate);
          booked = [];
          booked.add({"intStatusId": -1, "strStatus": "Status"});

          if (data != null) {
            int index = 0;
            while (index < data.length) {
              this.booked.add(data.elementAt(index));
              index++;
            }
          }

          setState(() {
            booked = booked;
            serviceTypes = serviceTypes;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderHistoryFilter(
              serviceTypes: this.serviceTypes,
              booked: this.booked,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/modal/user_detail.dart';
import 'package:accurate_doctor/services/ajax_call.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class NetBankingCard extends StatefulWidget {
  double amount;
  String appointmentId;
  String doctorName;
  String date;
  String time;
  String location;
  NetBankingCard(
      {this.amount,
      this.appointmentId,
      this.doctorName,
      this.date,
      this.time,
      this.location}) {
/*    print(
        'Amount: $amount, AppointmentId: $appointmentId, doctorName: $doctorName, '
        'date: $date, time: $time, location: $location');*/
  }

  @override
  _NetBankingCardState createState() => _NetBankingCardState();
}

class _NetBankingCardState extends State<NetBankingCard> {
  Razorpay _razorpay;
  double _payableAmount;
  String _appointmentId;
  String _orderId;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    setState(() {
      _payableAmount = widget.amount;
      _appointmentId = widget.appointmentId;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    AjaxCall http = AjaxCall.getInstance;
    http.post("AppointmentsCommon/PaymentGatewayordercreate", {
      "amount": 100 * widget.amount,
      "currency": Configuration.currency,
      "rcptid": "Receipt" + widget.appointmentId
    }).then((orderId) {
      print(
          'Order id: ${orderId.toString().replaceAll("\"", "").trim()}  ------------------->');
      if (orderId != null) {
        this._orderId = orderId.toString().replaceAll("\"", "").trim();
        UserDetail userDetail = UserDetail.instance;
        var options = {
          'key': 'rzp_live_bUVQEjF4AGSaxo',
          'amount': 100 * widget.amount,
          'name': userDetail.firstName,
          'order_id': this._orderId,
          'description': 'Appointment booking',
          'prefill': {
            'contact': userDetail.MobileNo,
            'email': userDetail.Email
          },
          'external': {
            'wallets': ['paytm']
          }
        };

        try {
          _razorpay.open(options);
        } catch (e) {
          debugPrint(e);
        }
      } else {
        Fluttertoast.showToast(msg: 'Not able ');
      }
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    try {
      this.showPaymentStatus();
      AjaxCall http = AjaxCall.getInstance;
      http
          .get(
              'AppointmentsCommon/SavePaymentGatewayDetails/${this._orderId}/${widget.appointmentId}')
          .then((value) {
        Fluttertoast.showToast(msg: "Done successfully");
      });
    } catch (ex) {
      print('ShowToast error');
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    try {
      String message =
          "ERROR: " + response.code.toString() + " - " + response.message;
      Fluttertoast.showToast(msg: response.message);
    } catch (ex) {
      print('ShowToast error');
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    try {
      Fluttertoast.showToast(msg: "EXTERNAL_WALLET: " + response.walletName);
    } catch (ex) {
      print('ShowToast error');
    }
  }

  Future<void> showPaymentStatus() {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Container(
          height: Configuration.height * .4,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: Text(
                  'Appointment booked successfully',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: Column(
                  children: [
                    Text(
                      'Doctor',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(widget.doctorName),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: Column(
                  children: [
                    Text(
                      'Date & time',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text('${widget.date} at ${widget.time}'),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: Column(
                  children: [
                    Text(
                      'Address',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(widget.location),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              width: Configuration.width * .8,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Theme.of(context).accentColor,
              ),
              child: Text(
                'Done',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Net banking',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Card(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            child: Image.asset("assets/img/nda.png"),
                          ),
                          Text(
                            'NBD',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                      trailing: InkWell(
                        onTap: this.openCheckout,
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Pay now',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 8,
                                color:
                                    Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.deepPurple,
                            child: CircleAvatar(
                              radius: 27,
                              backgroundColor: Colors.white,
                              child: Image.asset("assets/img/nbad.png"),
                            ),
                          ),
                          Text(
                            'NBAD',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      trailing: InkWell(
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Pay now',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 8,
                                color:
                                    Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text('More banks'),
                          padding: EdgeInsets.only(left: 20),
                        ),
                        Container(
                          child: Icon(Icons.keyboard_arrow_down),
                          padding: EdgeInsets.only(right: 20),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.lightBlueAccent,
                  blurRadius: 20.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

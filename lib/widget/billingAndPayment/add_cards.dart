import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddCards extends StatefulWidget {
  @override
  _AddCardsState createState() => _AddCardsState();
}

class _AddCardsState extends State<AddCards> {
  final _form = GlobalKey<FormState>();
  var expiryTextController = TextEditingController();
  bool addCard = false;
  final double _fieldGap = 12;

  Widget addNewCard() {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            child: Card(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Debit/Credit card'),
                      SizedBox(
                        height: 10,
                      ),
                      Text('CARD NUMBER'),
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'xxxx-xxxx-xxxx-xxxx',
                            isDense: true,
                            fillColor: Theme.of(context).backgroundColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                          ),
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          onFieldSubmitted: (_) {
                            //FocusScope.of(context).requestFocus(this._dateOfBirth);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Full name is madatory field';
                            }
                            return null;
                          },
                          onSaved: (value) {},
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('NAME ON CARD'),
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'NAME ON CARD',
                            isDense: true,
                            fillColor: Theme.of(context).backgroundColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                          ),
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (_) {
                            //FocusScope.of(context).requestFocus(this._dateOfBirth);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Full name is madatory field';
                            }
                            return null;
                          },
                          onSaved: (value) {},
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('EXPIRY DATE'),
                                Container(
                                  margin: EdgeInsets.only(top: 4),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                  ),
                                  child: SizedBox(
                                    width: 120,
                                    child: TextFormField(
                                      style: TextStyle(
                                        backgroundColor:
                                            Theme.of(context).backgroundColor,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'MM/YY',
                                        isDense: true,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      textAlign: TextAlign.start,
                                      keyboardType: TextInputType.number,
                                      controller: expiryTextController,
                                      onChanged: (value) {
                                        if (value.length == 2) {
                                          expiryTextController.text =
                                              value + "\/";

                                          print(expiryTextController.text);
                                          expiryTextController.selection =
                                              TextSelection.fromPosition(
                                            TextPosition(
                                                offset: expiryTextController
                                                    .text.length),
                                          );
                                          setState(() {});
                                        }
                                      },
                                      onFieldSubmitted: (_) {
                                        //FocusScope.of(context).requestFocus(this._dateOfBirth);
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Full name is madatory field';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {},
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('CVV'),
                                Container(
                                  margin: EdgeInsets.only(top: 4),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                  ),
                                  child: SizedBox(
                                    width: 100,
                                    child: TextFormField(
                                      style: TextStyle(
                                        backgroundColor:
                                            Theme.of(context).backgroundColor,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'CVV',
                                        isDense: true,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      textAlign: TextAlign.start,
                                      keyboardType: TextInputType.number,
                                      onFieldSubmitted: (_) {
                                        //FocusScope.of(context).requestFocus(this._dateOfBirth);
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Full name is madatory field';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {},
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
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
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: RaisedButton(
              onPressed: () {},
              padding: EdgeInsets.all(16),
              child: Text(
                'Pay now',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _switchToAddMode() {
    setState(() {
      addCard = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'My Cards',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          addCard
              ? addNewCard()
              : Container(
                  width: double.infinity,
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: ListTile(
                        leading: InkWell(
                          onTap: _switchToAddMode,
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).backgroundColor,
                            child: Icon(
                              Icons.add,
                              size: 18,
                            ),
                          ),
                        ),
                        title: Text(
                          'Add a Debit/Credit',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
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

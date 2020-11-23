import 'dart:io';

import 'package:accurate_doctor/widget/secondopinion/appointment_for.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';

import '../../modal/Configuration.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateNewOpinion extends StatefulWidget {
  @override
  _CreateNewOpinionState createState() => _CreateNewOpinionState();
}

class _CreateNewOpinionState extends State<CreateNewOpinion> {
  final _key = GlobalKey<FormState>();
  bool isPictureAval = false;
  File _filePath;

  Future<void> _getPicture() async {
    try {
      ImagePicker _picker = ImagePicker();
      final pickedFile = await _picker.getImage(source: ImageSource.camera);
      setState(() {
        isPictureAval = true;
        _filePath = File(pickedFile.path);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Appointment request from a Specialist doctor on some other doctor\'s advice',
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(Configuration.pagePadding),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppointmentFor(),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Specify symptoms',
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        labelText: 'Enter',
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.left,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Describe issue',
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.zero,
                      alignment: Alignment.bottomLeft,
                      child: this.isPictureAval
                          ? Image.file(
                              _filePath,
                              width: 50,
                            )
                          : Icon(
                              Icons.image,
                              size: 50,
                              color: Colors.grey,
                            ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'File name .pdf',
                      style: TextStyle(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Upload Previous Reports/Scannings',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 8,
                        bottom: 20,
                      ),
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.deepPurpleAccent,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: InkWell(
                        onTap: () {
                          _getPicture();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                            ),
                            Text(
                              'Upload File',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.zero,
                      alignment: Alignment.bottomLeft,
                      child: Icon(
                        Icons.image,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'File name .pdf',
                      style: TextStyle(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Upload Previous Prescriptions',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 8,
                        left: 10,
                        right: 10,
                        bottom: 10,
                      ),
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.deepPurpleAccent,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                            ),
                            Text(
                              'Upload File',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () {},
                        textColor: Colors.white,
                        color: Theme.of(context).accentColor,
                        padding: EdgeInsets.all(16),
                        child: Text('Submit second opinion request'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

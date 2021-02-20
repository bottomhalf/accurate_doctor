import 'package:accurate_doctor/modal/Configuration.dart';
import 'package:accurate_doctor/modal/user_detail.dart';
import 'package:accurate_doctor/widget/dashboard/app_bar.dart';
import 'package:accurate_doctor/widget/drawer/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const CHAT_ROOM = 'pchat/18DSbR7WJyakDnEAEbQT/messages';

class LiveChat extends StatefulWidget {
  @override
  _LiveChatState createState() => _LiveChatState();
}

class _LiveChatState extends State<LiveChat> {
  List<dynamic> messages = [];
  TextEditingController textMessage = TextEditingController();
  TextEditingController textPass = TextEditingController();
  UserDetail userDetail = UserDetail.instance;
  bool isPassed = false;

  @override
  void initState() {
    setState(() {
      this.messages = [];
      this.isPassed = false;
    });
    super.initState();
  }

  Future<void> _sendText() async {
    DateTime date = DateTime.now();
    if (textMessage.text != null && textMessage.text.trim() != "") {
      FirebaseFirestore.instance.collection(CHAT_ROOM).add({
        "id": userDetail.UserId,
        "sendAt": Timestamp.now(),
        "text": textMessage.text
      });
      textMessage.text = '';
    }
  }

  Future<void> _deleteChat() async {
    DateTime date = DateTime.now();
    if (textMessage.text != null && textMessage.text.trim() != "") {
      textMessage.text = '';
    }
  }

  Widget _buildSender() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        height: 60.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(children: <Widget>[
          Flexible(
            child: Card(
              color: Colors.white,
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.black12,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: textMessage,
                  onChanged: (String text) {
                    //updateSubmitButton();
                  },
                  onSubmitted: (text) {
                    //_handleSubmitted(text, context);
                  },
                  decoration: const InputDecoration.collapsed(
                    hintText: "Start typing...",
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: IconButton(
              icon: const Icon(
                Icons.send,
                color: Color(0xFF2196F3),
              ),
              onPressed: _sendText,
            ),
          ),
        ]),
      ),
    );
  }

  Widget _generateMessage(DocumentSnapshot snapshot) {
    if (userDetail.UserId == snapshot['id']) {
      return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: Text(
            snapshot['text'],
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
    } else {
      return Container(
        alignment: Alignment.centerRight,
        width: 100,
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Text(
              snapshot['text'],
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget _getSender() {
    return Container(
      padding: EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 34,
            width: Configuration.width * .85,
            margin: EdgeInsets.only(top: Configuration.fieldGap),
            child: TextField(
              enableInteractiveSelection: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10, bottom: 10),
              ),
              textAlign: TextAlign.start,
              controller: textMessage,
              keyboardType: TextInputType.text,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: Configuration.fieldGap,
            ),
            //width: Configuration.width * .15,
            child: ClipOval(
              child: Material(
                color: Colors.blue, // button color
                child: InkWell(
                  splashColor: Colors.red, // inkwell color
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.send,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
                  onTap: _sendText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _getChat() {
    if (textPass.text != null && textPass.text != "") {
      if (textPass.text == "3.14") {
        setState(() {
          this.isPassed = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(
        appBarHeader: 'Dashboard',
        defaultSearchText: '',
      ),
      body: !isPassed
          ? Container(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Hi... Please wait.'),
                    Card(
                      color: Colors.white,
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          controller: textPass,
                          onChanged: (String text) {
                            //updateSubmitButton();
                          },
                          onSubmitted: (text) {
                            if (text != null && text != "") return null;
                          },
                          decoration: const InputDecoration.collapsed(
                            hintText: "",
                          ),
                        ),
                      ),
                    ),
                    RaisedButton(
                      child: Text('Go'),
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: _getChat,
                    )
                  ],
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(CHAT_ROOM)
                        .orderBy('sendAt', descending: true)
                        .snapshots(),
                    builder: (_, stream) {
                      if (stream.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (stream.hasError) {
                        return Center(child: Text(stream.error.toString()));
                      }

                      QuerySnapshot querySnapshot = stream.data;
                      return ListView.builder(
                        itemCount: querySnapshot.size,
                        itemBuilder: (_, index) {
                          return this
                              ._generateMessage(querySnapshot.docs[index]);
                        },
                        reverse: true,
                      );
                    },
                  ),
                ),
                Container(
                  child: _buildSender(),
                )
              ],
            ),
      drawer: AppDrawer(),
      //bottomNavigationBar: _getSender(),
    );
  }
}

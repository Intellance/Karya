import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class edit_database extends StatefulWidget {
  edit_database({Key? key, required this.user_name}) : super(key: key);
  String user_name;

  @override
  _edit_databaseState createState() => _edit_databaseState();
}

class _edit_databaseState extends State<edit_database> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _username = TextEditingController();
    TextEditingController _passcode = TextEditingController();
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      height: _height,
      width: _width,
      color: Color(0xff050f14),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Container(
            height: _height / 1.1,
            width: _width / 3.1,
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(30))),
        Container(
            height: _height / 1.1,
            width: _width / 3.1,
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(30))),
        Container(
          height: _height / 1.1,
          width: _width / 3.1,
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.05),
              borderRadius: BorderRadius.circular(30)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Text('Select Subject',
                    style:
                        TextStyle(color: Colors.white, fontSize: _width / 40)),
              ),
              Container(
                height: _height / 1.5,
                width: _width / 5,
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(30)),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('DailyNews')
                        .doc('news_subjects')
                        .snapshots(),
                    builder: (context, AsyncSnapshot sub_snapshot) {
                      if (sub_snapshot.data == null) {
                        return Center(
                          child: Container(
                            width: _width / 40,
                            height: _width / 40,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: sub_snapshot.data['subjects'].length,
                        itemBuilder: (BuildContext, int index) {
                          return Center(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => update_news(
                                            subject_name: sub_snapshot
                                                .data['subjects'][index],
                                            user_name: widget.user_name),
                                      ));
                                },
                                child: Text(
                                  '${sub_snapshot.data['subjects'][index]}',
                                  style: TextStyle(
                                      color: Colors.lightBlueAccent,
                                      fontSize: _width / 60),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
              )
            ],
          ),
        )
      ]),
    ));
  }
}

class update_news extends StatefulWidget {
  update_news({Key? key, required this.subject_name, required this.user_name})
      : super(key: key);
  final String subject_name;
  String user_name;

  @override
  _update_newsState createState() => _update_newsState();
}

class _update_newsState extends State<update_news> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _channel_name = TextEditingController();
    TextEditingController _profile_url = TextEditingController();
    TextEditingController _title = TextEditingController();
    TextEditingController _description = TextEditingController();
    TextEditingController _img_url = TextEditingController();
    TextEditingController _site_url = TextEditingController();
    TextEditingController _status = TextEditingController();

    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Container(
      height: _height,
      width: _width,
      color: Color(0xff050f14),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Container(
          height: _height / 1.1,
          width: _width / 4,
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.05),
              borderRadius: BorderRadius.circular(30)),
          child: Center(
            child: Text('${widget.subject_name}',
                style: TextStyle(color: Colors.blue, fontSize: _width / 30)),
          ),
        ),
        Container(
          height: _height / 1.1,
          width: _width / 4,
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.05),
              borderRadius: BorderRadius.circular(30)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Text('Select Channel',
                    style:
                        TextStyle(color: Colors.white, fontSize: _width / 40)),
              ),
              Container(
                height: _height / 1.5,
                width: _width / 5,
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(30)),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('DailyNews')
                        .doc('channel_names')
                        .snapshots(),
                    builder: (context, AsyncSnapshot cha_snapshot) {
                      if (cha_snapshot.data == null) {
                        return Center(
                          child: Container(
                            width: _width / 40,
                            height: _width / 40,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: cha_snapshot.data['channels'].length,
                        itemBuilder: (BuildContext, int index) {
                          return Center(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: GestureDetector(
                                onTap: () {
                                  _profile_url.text = cha_snapshot
                                      .data['channels'][index]['profile_url'];
                                  _channel_name.text = cha_snapshot
                                      .data['channels'][index]['channel_name'];
                                },
                                child: Text(
                                  '${cha_snapshot.data['channels'][index]['channel_name']}',
                                  style: TextStyle(
                                      color: Colors.lightBlueAccent,
                                      fontSize: _width / 60),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
              )
            ],
          ),
        ),
        Container(
            height: _height / 1.1,
            width: _width / 2.2,
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(30)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: _width / 4,
                    child: Center(
                      child: TextField(
                          controller: _channel_name,
                          readOnly: true,
                          decoration: InputDecoration(
                              hintText: 'Select Channel name',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: Colors.white12,
                                  fontSize: _width / 50)),
                          style: TextStyle(
                              color: Colors.red, fontSize: _width / 40)),
                    ),
                  ),
                ),
                Container(
                  height: _width / 15,
                  width: _width / 2.5,
                  decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: _title,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: 'Title',
                            hintStyle: TextStyle(color: Colors.white24),
                            border: InputBorder.none),
                        maxLines: 10),
                  ),
                ),
                Container(
                  height: _width / 10,
                  width: _width / 2.5,
                  decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: _description,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: 'Description',
                            hintStyle: TextStyle(color: Colors.white24),
                            border: InputBorder.none),
                        maxLines: 20),
                  ),
                ),
                Container(
                  height: _width / 25,
                  width: _width / 2.5,
                  decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: _img_url,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: 'Image url',
                            hintStyle: TextStyle(color: Colors.white24),
                            border: InputBorder.none),
                        maxLines: 10),
                  ),
                ),
                Container(
                  height: _width / 25,
                  width: _width / 2.5,
                  decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: _site_url,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: 'Site url',
                            hintStyle: TextStyle(color: Colors.white24),
                            border: InputBorder.none),
                        maxLines: 10),
                  ),
                ),
                Container(
                  height: _width / 30,
                  width: _width / 8,
                  decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(30)),
                  child: TextButton(
                      onPressed: () async {
                        String _timestamp = DateTime.now().toString();
                        // final snapShot = await FirebaseFirestore.instance
                        //     .collection('DailyNews')
                        //     .doc('All_news')
                        //     .get();
                        print('1');
                        // final _snapShot = await FirebaseFirestore.instance
                        //     .collection('DailyNews')
                        //     .doc('channel_names')
                        //     .get();
                        print('2');
                        print(
                            '${_timestamp}/${_channel_name.text}/${widget.subject_name}');
                        print('3');

                        Map<String,dynamic> _update_data = {
                          'title': _title.text,
                          'description': _description.text,
                          'timestamp': _timestamp,
                          'channel_name': _channel_name.text,
                          'profile_url': _profile_url.text,
                          'subject': widget.subject_name,
                          'img_url': _img_url.text,
                          'editedby': widget.user_name,
                          'news_id':
                              '${_timestamp}${_channel_name.text}${widget.subject_name}',
                          'likes': '',
                          'shares': '',
                          'site_url': _site_url.text,
                        };
                        print('5');
                        if (_title.text.length != 0 &&
                            _description.text.length != 0 &&
                            _img_url.text.length != 0 &&
                            _site_url.text.length != 0 &&
                            _channel_name.text.length != 0) {
                          FirebaseFirestore.instance
                              .collection('DailyNews')
                              .doc('All_news')
                              .collection('user_newsdata')
                              .doc( '${_timestamp}${_channel_name.text}${widget.subject_name}')
                              .set(_update_data);
                          print('9');
                          FirebaseFirestore.instance
                              .collection('DailyNews')
                              .doc('All_news')
                              .collection('admin_newsdata')
                              .doc( '${_timestamp}${_channel_name.text}${widget.subject_name}')
                              .set(_update_data);
                          print('10');
                          success_showDialog();
                          setState(() {
                            _title.text.length == 0;
                            _description.text.length == 0;
                            _img_url.text.length == 0;
                            _site_url.text.length == 0;
                          });
                        } else {
                          print('Every textfield id mandatary to fill!');
                          showDialog();
                          setState(() {
                            _title.text.length == 0;
                            _description.text.length == 0;
                            _img_url.text.length == 0;
                            _site_url.text.length == 0;
                          });
                        }
                      },
                      child: Text('Save & Upload')),
                ),
              ],
            ))
      ]),
    ));
  }

  void success_showDialog() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 100),
      context: context,
      pageBuilder: (_, __, ___) {
        double _height = MediaQuery.of(context).size.height;
        double _width = MediaQuery.of(context).size.width;
        return Material(
          type: MaterialType.transparency,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: _height / 2,
              width: _width / 1.5,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.all(_width / 20),
                      child: Text(
                        'Data saved successfully!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: _height / 45,
                          letterSpacing: 3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, -1), end: Offset(0, -.3)).animate(anim),
          child: child,
        );
      },
    );
  }

  void showDialog() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 100),
      context: context,
      pageBuilder: (_, __, ___) {
        double _height = MediaQuery.of(context).size.height;
        double _width = MediaQuery.of(context).size.width;
        return Material(
          type: MaterialType.transparency,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: _height / 2,
              width: _width / 1.5,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.all(_width / 20),
                      child: Text(
                        'Every field is mandatory,\nfill check if any!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: _height / 45,
                          letterSpacing: 3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, -1), end: Offset(0, -.3)).animate(anim),
          child: child,
        );
      },
    );
  }

  void _showDialog() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 100),
      context: context,
      pageBuilder: (_, __, ___) {
        double _height = MediaQuery.of(context).size.height;
        double _width = MediaQuery.of(context).size.width;
        return Material(
          type: MaterialType.transparency,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: _height / 2,
              width: _width / 1.5,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.all(_width / 20),
                      child: Text(
                        'Something going horribly wrong!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: _height / 45,
                          letterSpacing: 3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, -1), end: Offset(0, -.3)).animate(anim),
          child: child,
        );
      },
    );
  }
}

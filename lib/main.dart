import 'package:admin_karya/edit_data/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.all(_width / 30),
                    height: _height / 2,
                    width: _width / 3,
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                      child: Text(
                        'This is Admin Control Panel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('admin_karya')
                          .doc('admins')
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        return Container(
                            margin: EdgeInsets.all(_width / 30),
                            height: _height / 2,
                            width: _width / 3,
                            decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(50)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    height: _width / 30,
                                    width: _width / 5,
                                    decoration: BoxDecoration(
                                        color: Colors.white10,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                          controller: _username,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: 'Username',
                                            hintStyle: TextStyle(
                                              color: Colors.white24,
                                            ),
                                            border: InputBorder.none,
                                          )),
                                    )),
                                Container(
                                    height: _width / 30,
                                    width: _width / 5,
                                    decoration: BoxDecoration(
                                        color: Colors.white10,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                          controller: _passcode,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            hintText: 'Passcode',
                                            hintStyle: TextStyle(
                                              color: Colors.white24,
                                            ),
                                            border: InputBorder.none,
                                          )),
                                    )),
                                Container(
                                  height: _width / 30,
                                  width: _width / 10,
                                  decoration: BoxDecoration(
                                      color: Colors.white10,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: TextButton(
                                      onPressed: () async {
                                        List usernames =
                                            await snapshot.data['editors'];

                                        String passcode =
                                            await snapshot.data['passcodes'];

                                        if (_username.text != null &&
                                            _passcode.text != null) {
                                          if (usernames
                                                  .contains(_username.text) &&
                                              passcode == _passcode.text) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      edit_database(
                                                          user_name:
                                                              _username.text),
                                                ));
                                            print('yes');
                                          }
                                        } else {
                                          print('Every text box is mandatory!');
                                        }
                                      },
                                      child: Text('Login')),
                                )
                              ],
                            ));
                      }),
                )
              ],
            )));
  }
}

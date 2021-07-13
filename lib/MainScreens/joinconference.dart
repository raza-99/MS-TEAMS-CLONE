import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:uiscreen/MainScreens/ReviewService.dart';

class JoinCon extends StatefulWidget {
  @override
  _JoinConState createState() => _JoinConState();
}

class _JoinConState extends State<JoinCon> {
  late bool existflag = false;
  late String user_entered_id;
  late bool correct=true;
  late String titleindex="Join a team with a code";
  final _firestore = FirebaseFirestore.instance;

  _joinMeeting(meetingid) async {
    try {
      var options = JitsiMeetingOptions(room: meetingid);
      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    late bool exist;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 100.0, left: 30.0),
              child: Column(
                children: [
                  Text(

                    "$titleindex",
                    style: TextStyle(
                      color: Color(0xffF40612),
                      fontSize: 25.0,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    onChanged: (value) {
                      user_entered_id = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter Meeting Code',
                      labelStyle: TextStyle(
                        fontSize: 13.0,
                        color: Color(0xffF40612),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        onPressed: () async {
                          await ReviewService()
                              .getmeetrecor("$user_entered_id")
                              .then((QuerySnapshot document) {
                            if (document.docs.isNotEmpty) {
                             //TODO


                              existflag = true;
                            } else {
                              existflag = false;
                            }
                          });

                          existflag ? _joinMeeting(user_entered_id) : null;
                          if(existflag==false){
                            setState(() {
                              titleindex="Incorrect Code";
                            });
                          }
                          print(existflag);
                        },
                        child: Text(
                          'Join',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        color: Color(0xffF40612),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

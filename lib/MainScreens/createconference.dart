import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';


import 'package:uiscreen/Providerdata/Meetingdata.dart';

class createcon extends StatefulWidget {
  @override
  _createconState createState() => _createconState();
}

class _createconState extends State<createcon> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late User loggedInUser;
  late String meetname;
  late String meetdes;
late var usermail;
  @override
  void initState() {
    super.initState();

  }


  _joinMeeting(meetingid) async {
    try {
      var options = JitsiMeetingOptions(room: meetingid);
      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      print(error);
    }
  }

  bool isvald() {
    if (meetname != null && meetdes != null) {
      return true;
    } else {
      return false;
    }
  }

  _createMeeting(context) {
    Provider.of<Meetingdata>(context, listen: false)
        .addMeeting(meetname, meetdes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: Column(children: [
              Container(
                padding: EdgeInsets.only(top: 100.0, left: 30.0),
                child: Column(
                  children: [
                    Text(
                      'Create Your Own Team',
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
                        meetname = value;
                      },
                      decoration: InputDecoration(
                        labelText: ' Meeting Name',
                        labelStyle: TextStyle(
                          fontSize: 13.0,
                          color: Color(0xffF40612),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    TextField(
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        meetdes = value;
                      },
                      decoration: InputDecoration(
                        labelText: ' Description',
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
                        Container(
                          padding: EdgeInsets.only(right: 60.0),
                          child: FlatButton(
                            minWidth: 120.0,
                            onPressed: () async{
                              isvald() ? _createMeeting(context) : null;



                            },
                            child: Text(
                              'Create',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            color: Color(0xffF40612),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Flexible(
                child: StreamBuilder(
                  stream:
                      _firestore.collection('MeetingsCollection').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot MeetingsCollection =
                            snapshot.data!.docs[index];
                        return ListTile(
                          leading: FlatButton(
                              color: Color(0xff00003f),
                              onPressed: () {
                                Share.share('Join with Me with MeetingID' +
                                    MeetingsCollection['UUID']);
                              },
                              child: Text('Share Link',
                                  style: TextStyle(color: Colors.white))),
                          title: FlatButton(
                            color: Color(0xff323232),
                            onPressed: () {
                              _joinMeeting(MeetingsCollection['UUID']);
                            },
                            child: Text(MeetingsCollection['Name'],
                                style: TextStyle(color: Colors.white)),
                          ),
                          subtitle: FlatButton(
                            color: Color(0xff323232),
                            onPressed: () {
                              _joinMeeting(MeetingsCollection['UUID']);
                            },
                            child: Text(MeetingsCollection['Description'],
                                style: TextStyle(color: Colors.white)),
                          ),
                          trailing: FlatButton(
                            color: Color(0xff323232),
                            onPressed: () async {
                              await Meetingdata()
                                  .messageStream(MeetingsCollection['UUID']);
                            },
                            //TODO
                            child: Text("Delete Meeting",
                                style: TextStyle(color: Colors.white)),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Meetingdata extends ChangeNotifier {


late String email;

  final _firestore =
      FirebaseFirestore.instance.collection("MeetingsCollection");
  late var docId;


  addMeeting(name, des) async {
    var uuid = Uuid();
    var meetingid = uuid.v1();
    _firestore.add({
      'Description': des,
      'Name': name,
      'UUID': meetingid,
    });

    notifyListeners();
  }


  getemail(String emailid){
   email=emailid;
  }
  addMessage(message)async{
FirebaseFirestore.instance.collection("USERDETAILS").add({
  'NAME':email,
  'data':message,
}

);
notifyListeners();
  }


  messageStream(meetingid) async {
    await for (var snapshot in _firestore.snapshots()) {
      for (var message in snapshot.docs) {
        if (message.data()["UUID"] == "$meetingid") {
          docId = message.id;

          _firestore.doc(docId).delete().then((value) {
            print("success");
          });
        }
      }
    }
  }
}

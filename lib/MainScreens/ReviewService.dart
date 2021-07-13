import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ReviewService {
  final _firebase = FirebaseFirestore.instance;

  getmeetrecor(String uid) {
    return _firebase
        .collection('MeetingsCollection')
        .where('UUID', isEqualTo: "$uid")
        .get();
  }

}




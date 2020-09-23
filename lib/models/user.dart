import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  String uid;
  String displayName;
  String email;
  Timestamp lastSeen;
  String photoURL;

  User({this.uid, this.displayName, this.email, this.lastSeen, this.photoURL});

  factory User.fromDocumentSnapshot(DocumentSnapshot snap) {
    return User(
      uid: snap.data['uid'],
      displayName: snap.data['displayName'],
      email: snap.data['email'],
      lastSeen: snap.data['lastSeen'],
      photoURL: snap.data['photoURL'],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class UserService {
  Observable<List<FirebaseUser>> users;
  final Firestore _db = Firestore.instance;

  Stream<QuerySnapshot> getAllUsersStream() {
    return _db.collection('users').snapshots();
  }

  UserService() {}
}

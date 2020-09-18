import 'package:firebase_auth/firebase_auth.dart';

class Group {
  int id;
  List<FirebaseUser> people;

  Group({this.id, this.people});
}

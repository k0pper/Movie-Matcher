import 'package:flutter/material.dart';
import 'package:swipecards/main.dart';
import 'package:swipecards/services/nav.dart';
import 'package:swipecards/widgets/groupthumbnail.dart';

class GroupsPage extends StatefulWidget {
  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
        onPressed: () {
          locator<NavigationService>().navigateTo('addPeople');
        },
      ),
      backgroundColor: Colors.grey[900],
      body: Container(
          padding: EdgeInsets.all(5),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              if (index == 0) return Header();
              return GroupThumbnail();
            },
          )),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Groups",
            style: TextStyle(
                color: Colors.white, fontSize: 38, fontWeight: FontWeight.w400),
          ),
          Text(
            "Choose People to watch with",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300),
          ),
          SizedBox(height: 6)
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class GroupThumbnail extends StatefulWidget {
  @override
  _GroupThumbnailState createState() => _GroupThumbnailState();
}

class _GroupThumbnailState extends State<GroupThumbnail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Stack(
        overflow: Overflow.visible,
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
              padding: EdgeInsets.fromLTRB(12, 14, 12, 14),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: -1,
                        blurRadius: 5,
                        offset: Offset(0, 3))
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/group.png',
                    width: 50,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("5 Mitglieder",
                          style: TextStyle(color: Colors.grey, fontSize: 11)),
                      Text("Alex Miller, Simon Broß",
                          style: TextStyle(color: Colors.black, fontSize: 14)),
                    ],
                  )
                ],
              )),
          Positioned(
            top: -5,
            right: -5,
            child: Container(
              width: 22,
              height: 22,
              child: Center(
                child: Text(
                  "22",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(200))),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const InfoTile({Key key, this.title, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'SF-Pro-Bold',
            color: Color(0xff909fb4),
          ),
          children: <TextSpan>[
            TextSpan(text: title, style: TextStyle(color: Colors.white)),
            TextSpan(text: "$value", style: TextStyle(fontSize: 15))
          ],
        ),
      ),
    );
  }
}

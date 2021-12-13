import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class TaskCardWidget extends StatelessWidget {
  final String? title;
  final String? desc;
 TaskCardWidget({this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 32.0,
        horizontal: 24.0,
      ),
      margin: EdgeInsets.only(
        bottom: 20.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular((20.0))
      ),
      child: Column(
        crossAxisAlignment:  CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "(Unnamed Task)",
            style: TextStyle(
              color: Color(0xFF211551),
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
           desc ?? "(No Description Added)",
             style: TextStyle  (
              fontSize: 16.0,
              color: Color(0xFF868290),
              height: 1.5,
           ),
          )
        ],
      ),
    );
  }
}

class TodoWidget extends StatelessWidget {
   final String? title;
   final bool? isDone;
   TodoWidget({this.title,@required this.isDone,text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      child: Row(
        children: [
          Container(
            width: 20.0,
            height: 20.0,
            margin: EdgeInsets.only(
              right: 12.0,
            ),
            decoration: BoxDecoration(
              color: (isDone ?? true) ? Color(0xFF7349FE) : Colors.transparent,
              borderRadius: BorderRadius.circular(6.0),
                border : (isDone ?? true) ? null : Border.all(
                width: 1.5,
                color: Color(0xFF868290)
            )
            ),
            child: Image(
              image: AssetImage('assets/images/check_icon.png'),
            ),
          ),
           Text(
            title ?? "Unnamed Todo",
            style: TextStyle(
              color: Color(0xFF211551),
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]
      ),
    );
  }
}

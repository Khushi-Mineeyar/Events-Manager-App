import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widget.dart';
import 'taskpage.dart';
import 'database_helper.dart';
class  Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DatabaseHelper _dbHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 32.0,
          ),
          color: Color(0xFFF6F6F6),
          child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Container(
                    margin: EdgeInsets.only(
                      bottom: 32.0,
                    ),
                 child:
                Image(image: AssetImage(
                  'assets/images/logo.png'
                  )
                )
               ),
                 Expanded(
                   child: FutureBuilder(
                     initialData: [],
                   future: _dbHelper.getTasks(),
                   builder: (context, AsyncSnapshot snapshot) {
                     return ListView.builder(
                       itemCount: snapshot.data!.length,
                       itemBuilder: (context, index) {
                         return GestureDetector(
                             onTap: () {
                               Navigator.push(context,
                                 MaterialPageRoute(builder: (context) =>
                                     Taskpage(
                                       task: snapshot.data![index],
                                     )),
                               );
                             },
                             child: TaskCardWidget(
                               title: snapshot.data[index].title,
                             )

                         );
                       },
                     );
                   }
                 ),
                 )
              ],
            ),
                Positioned(
                  bottom:0.0,
                  right:0.0,
                  child: GestureDetector(
                    onTap:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>Taskpage(task: null,)
                        ),
                      ).then((value){
                        setState(() {});
                      }
                      );
                    },
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Color(0xFF7349FE),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Image(
                      image : AssetImage(
                        "assets/images/add_icon.png",
                      ),
                    ),
                  ),
                ),
           ),
          ]
          ),
        ),
       ),
      );
  }
}

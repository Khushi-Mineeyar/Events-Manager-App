import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widget.dart' ;
import 'database_helper.dart';

class Taskpage extends StatefulWidget {
  final Task? task;
  Taskpage({@required this.task});
  @override
  _TaskpageState createState() => _TaskpageState();
}

class _TaskpageState extends State<Taskpage> {
  DatabaseHelper _dbHelper = DatabaseHelper();
  int _taskId =0;
  String _taskTitle="";

  late FocusNode _titleFocus;
  late FocusNode _descriptionFocus;
  late FocusNode _todoFocus;


  @override
  void initState(){
    if(widget.task != null){
      _taskTitle = widget.task!.title! ;
      _taskId =widget.task!.id!;
    }
    _titleFocus= FocusNode();
    _descriptionFocus= FocusNode();
    _todoFocus= FocusNode();

    super.initState();
  }

  @override
  void dispose(){
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _todoFocus.dispose();
    super.dispose();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
        children: [
          Stack(
          children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 24.0,
                    bottom: 6.0,
                  ),
                child : Row(
                   children :[
                     InkWell(
                       onTap: (){
                         Navigator.pop(context);
                       },
                     child : Padding(
                       padding: const EdgeInsets.all(24.0),
                       child : Image(
                         image: AssetImage('assets/images/back_arrow_icon.png'),
                       ),
                    ),
                ),
                Expanded(
                  child: TextField(
                    focusNode: _titleFocus,
                     onSubmitted: (value) async{
                       if(value !=""){
                         if(widget.task ==null) {

                           Task _newTask = Task(
                               title: value
                           );
                           await _dbHelper.insertTask(_newTask);
                         }
                         else{
                           print("update the existing task");
                         }
                         _descriptionFocus.requestFocus();
                       }
                     },
                    controller: TextEditingController()..text= _taskTitle,
                      decoration: InputDecoration(
                       hintText: "Enter task Title",
                       border: InputBorder.none,
                     ),
                       style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                         color :Color(0xFF211551),
                      ),
                ),
               )
               ],
               )
                ),
                TextField(
                  focusNode: _descriptionFocus,
                  onSubmitted: (value){
                    _todoFocus.requestFocus();
                  },

                  decoration: InputDecoration(
                      hintText:"Enter description for the task.",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 24.0,
                      )
                  ),
                ),
                FutureBuilder(
                  initialData: [],
                  future: _dbHelper.getTodo(_taskId),
                    builder: (context,AsyncSnapshot snapshot){
                    return Expanded(
                    child:  ListView.builder(
                       itemCount: snapshot.data!.length,
                       itemBuilder: (context,index){
                       return GestureDetector(
                        onTap: () {

                        },
                      child: TodoWidget(
                        text:snapshot.data![index].title,
                        isDone: snapshot.data[index].isDone == 0 ? false: true,
                      ),
                    );
                  },
                ),
                    );
                 },
                ),
                Padding(
                       padding: EdgeInsets.symmetric(
                         horizontal: 24.0,
                       ),
                      child:Row(
                      children: [
                        Container(
                          width: 20.0,
                          height: 20.0,
                          margin: EdgeInsets.only(
                            right: 12.0,
                          ),
                          decoration: BoxDecoration(
                              color:  Colors.transparent,
                              borderRadius: BorderRadius.circular(6.0),
                              border :  Border.all(
                                  width: 1.5,
                                  color: Color(0xFF868290)
                              )
                          ),
                          child: Image(
                            image: AssetImage('assets/images/check_icon.png'),
                          ),
                        ),
                        Expanded(
                            child:TextField(
                              focusNode: _todoFocus,
                              onSubmitted: (value) async {
                                 if (value != "") {
                                   if (widget.task != null) {
                                   DatabaseHelper _dbHelper = DatabaseHelper();
                                       Todo _newTodo = Todo(
                                       title: value,
                                       isDone: 0,
                                       taskId: widget.task!.id,
                                      );
                               await _dbHelper.insertTodo(_newTodo);
                                setState(() {});
                                   }
                                 }
                                },
                                decoration: InputDecoration(
                                  hintText: "Enter Todo item..",
                                  border: InputBorder.none,
                                )
                            )
                        )
                      ]
                    )
                   )
            ],
        ),
            Positioned(
              bottom:24.0,
              right:24.0,
              child: GestureDetector(
                onTap:(){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>Taskpage(task: null,)
                      )
                  );
                },
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFFE3577),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Image(
                    image : AssetImage(
                      "assets/images/delete_icon.png",
                    ),
                  ),
                ),
              ),
            ),
          ]
          )
         ]
      )
      ),
      ),
    );
  }
}


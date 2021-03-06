import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
//import 'task.dart';

class Task{
  final int? id;
  final String? title;
  final String? description;
  Task({this.id,this.title,this.description, isDone, taskId});

  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'title':title,
      'description':description,
    };
  }
}
class Todo{
  final int? id;
  final int? taskId;
  final String? title;
  final int? isDone;
  Todo({this.id,this.taskId,this.title,this.isDone});

  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'title':title,
      'isDone':isDone,
      'taskId': taskId,
    };
  }
}

class DatabaseHelper {
   Future<Database> database() async{
     return openDatabase(
       join(await getDatabasesPath(), 'todo.db'),
       onCreate:(db,version) async {
         await db.execute( "CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,description TEXT)");
         await db.execute( "CREATE TABLE todo(id INTEGER PRIMARY KEY,taskId INTEGER,title TEXT,isDone INTEGER)");

         return Future.value();
       },
       version:1,
     );
   }

   Future<void> insertTask(Task task) async{
     Database _db =await database();
     await _db.insert('tasks',task.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
   }

   Future<void> insertTodo(Todo todo) async{
     Database _db =await database();
     await _db.insert('todo',todo.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
   }

   Future<List<Task>> getTasks() async{
     Database _db = await database();
     List<Map<String, dynamic>> taskMap = await _db.query('tasks');
     return List.generate(taskMap.length, (index){
       return Task(id: taskMap[index]['id'],title: taskMap[index]['title'], description: taskMap[index]['description']);
     },
     );
   }

   Future<List<Task>> getTodo(int taskId) async{
     Database _db = await database();
     List<Map<String, dynamic>> todoMap = await _db.rawQuery("SELECT FROM todo WHERE taskId= $taskId");
     return List.generate(todoMap.length, (index){
       return Task(id: todoMap[index]['id'],title: todoMap[index]['title'], taskId: todoMap[index]['taskId'],isDone: todoMap[index]['isDone']);
     },
     );
   }
}


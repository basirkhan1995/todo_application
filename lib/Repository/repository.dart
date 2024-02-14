import 'dart:convert';
import '../Model/todo.dart';
import '../Services/api_base.dart';
import 'package:http/http.dart' as http;
class TodoServices {

  // Future<List<Todo>> getTodos()async{
  //   const url = 'http://zaitoon.tech/API/TodoApi/selectTodo.php';
  //   final uri = Uri.parse(url);
  //   final response = await http.get(uri);
  //   if(response.statusCode == 200){
  //     final json = jsonDecode(response.body) as List;
  //     final todos = json.map((e) => Todo.fromMap(e)).toList();
  //     return todos;
  //   }else{
  //     return [];
  //   }
  // }

  //Get Todo
  Future<List<Todo>> getTodo()async{
      final response = await BaseClient().get('https://zaitoon.tech/TodoApi' , '/select.php');
      final todos = response.map((e) => Todo.fromMap(e)).toList();
      return todos;
  }



  Future<void> addTodo(Todo todo)async{
    await BaseClient().post('https://zaitoon.tech/TodoApi', '/insert.php', todo.toMap());
  }

  Future<void> updateTodo(id)async{
    await BaseClient().post('https://zaitoon.tech/todo', '/delete.php', id);
  }

  Future<void> deleteTodo()async{}

 }

import 'package:flutter/material.dart';
import 'package:http_todo_provider/Repository/repository.dart';
import 'package:http_todo_provider/Services/exception_handlers.dart';
import '../Model/todo.dart';


class TodoProvider extends ChangeNotifier{
  final TodoServices _todoServices = TodoServices();
  final ExceptionHandler _handler = ExceptionHandler();

  List<Todo> _todo = [];
  List<Todo> get allTodoList => _todo;

  String? _error;
  String? get error => _error;

  bool _loading = false;
  bool get loading => _loading;

  void enableLoading(){
    _loading = true;
    notifyListeners();
  }

  void disableLoading ()async{
    _loading = false;
    notifyListeners();
  }

  Future<void> getTodos()async{
    try{
      enableLoading();
      _todo = await _todoServices.getTodo();
      _error = null;
      disableLoading();

   }catch(e){
     disableLoading();
     _error = _handler.exceptionError(e);
   }
  }

  Future<void> addTodo(Todo todo)async{
    try{
      enableLoading();
      _todoServices.addTodo(todo);
      notifyListeners();
      await getTodos();

      _error = null;
      disableLoading();
    }catch(e){
      disableLoading();
      _error = _handler.exceptionError(e);
      notifyListeners();
    }


  }

   init(){
    getTodos();
    notifyListeners();
  }

}
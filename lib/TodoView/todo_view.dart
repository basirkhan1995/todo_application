import 'package:flutter/material.dart';
import 'package:http_todo_provider/TodoProvider/todo_provider.dart';
import 'package:http_todo_provider/TodoView/add_todo.dart';
import 'package:provider/provider.dart';
import '../Model/todo.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TodoProvider>(context,listen: false).getTodos();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddTodo()));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Todo"),
      ),
      body:  Consumer<TodoProvider>(
          builder: (context, notifier, child) {
            final todo = notifier.allTodoList;
            if (notifier.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            else if (notifier.error != null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text("${notifier.error}",style: const TextStyle(fontSize: 16),)),
                  TextButton(
                      onPressed: (){
                        notifier.getTodos();
                      } , child: const Text("Retry")),
                ],
              );
            } else if (notifier.allTodoList.isEmpty) {
              return const Center(child: Text("No Todo"));
            } else {
              return Scrollbar(
                child: RefreshIndicator(
                  onRefresh: notifier.getTodos,
                  child: ListView.builder(
                      itemCount: todo.length,
                      itemBuilder: (context, index) {
                        Todo todos = notifier.allTodoList[index];
                        return ListTile(
                          subtitle: Text(todos.title),
                          title: Text(
                            todos.title,
                            style: TextStyle(
                                color: todos.isCompleted ? Colors.grey : Colors.black),
                          ),
                          leading: CircleAvatar(
                            child: Text(todos.id.toString()),
                          ),
                        );
                      }),
                ),
              );
            }
          }),
    );
  }
}

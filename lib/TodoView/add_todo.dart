import 'package:flutter/material.dart';
import 'package:http_todo_provider/Model/todo.dart';
import 'package:http_todo_provider/TodoProvider/todo_provider.dart';
import 'package:provider/provider.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final content = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
        actions: [
          Consumer<TodoProvider>(
            builder: (context,notifier, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: IconButton(
                    onPressed: (){

                      if(formKey.currentState!.validate()){
                        notifier.addTodo(
                            Todo(
                                title: title.text,
                                content: content.text,
                                isCompleted: true)).then((value) => Navigator.pop(context));
                      }

                    },
                    icon: Visibility(
                        visible: !notifier.loading,
                        replacement: const CircularProgressIndicator(
                          backgroundColor: Colors.transparent),
                        child: const Icon(Icons.check))),
              );
            }
          )
        ],
      ),

      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: title,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Title is required";
                    }
                    return null;
                  },

                  decoration: InputDecoration(
                    hintText: "title",
                    labelText: "title",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      )
                    ),

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.deepPurple,
                          width: 2
                        )
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: content,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Content is required";
                    }
                    return null;
                  },

                  decoration: InputDecoration(
                      hintText: "Content",
                      labelText: "Content",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        )
                    ),

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            color: Colors.deepPurple,
                            width: 2
                        )
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}

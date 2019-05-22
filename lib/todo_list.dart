import 'package:flutter/material.dart';
//! From class Todo
import 'package:todo_list/todo.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Todo> todos = [];

//! TextEditingController is to acces the value of a TextField to create todo 
  TextEditingController controller = new TextEditingController();

  _toggleTodo(Todo todo, bool isChecked) {
  //! setState to render the checklist 
    setState(() {
    //! isChecked to toggle true and false 
      todo.isDone = isChecked;
    });
  }

  Widget _buildItem(BuildContext context, int index) {
    final todo = todos[index];
  //! CheckboxListTile is from material.dart libary
    return CheckboxListTile(
      value: todo.isDone,
      title: Text(todo.title),
      onChanged: (bool isChecked) {
        _toggleTodo(todo, isChecked);
      },
    );
  }

  _addTodo() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('New Todo'),
            content: TextField(
            //! controller is from TextEditingController 
              controller: controller,
              autofocus: true,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Add'),
                onPressed: () {
                  setState(() {
                    final todo = new Todo(title: controller.value.text);

                    todos.add(todo);
                    controller.clear();

                    Navigator.of(context).pop();
                  });
                },
              ),
            ],
          );
        });
  }

//! First Look When Starts
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List')),
    //! listView to render todos items
      body: ListView.builder(
        itemBuilder: _buildItem,
        itemCount: todos.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addTodo,
      ),
    );
  }
}




import 'package:flutter/material.dart';
import 'http/backend.dart';
import 'models/ToDo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        backgroundColor: Colors.grey[700],
      ),
      body: Container(
        color: Colors.grey,
        child: TodoList(),
      ),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<ToDo> todolist=[];
  TextEditingController _textEditingController = TextEditingController();

  void refreshTodos() async {
    todolist = await todos.getAllTodos();
    setState(() {});
  }

  void addTodo()async{
   await todos.addToDo(ToDo(0,_textEditingController.text,false));
    setState(() {
      refreshTodos();
      _textEditingController.clear();
    });
  }

  void removeTodo(int index)async {
    await todos.deleteToDo(todolist[index].id);
    setState(() {
      refreshTodos();
    });
  }

  void toggleDone(int index)async {
   var todo=todolist[index];
   todo.checked=!todo.checked;
   await todos.deleteToDo(todolist[index].id);
   await todos.addToDo(todo);
    setState(() {
     refreshTodos();
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    refreshTodos();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: todolist.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(todolist[index].text),
                onDismissed: (direction) {
                  removeTodo(index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Todo deleted')),
                  );
                },
                child: ListTile(
                  leading: Checkbox(
                    value: todolist[index].checked,
                    onChanged: (bool? value) {
                      toggleDone(index);
                    },
                  ),
                  title: Text(
                    todolist[index].text,
                    style: TextStyle(
                      decoration: todolist[index].checked
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      removeTodo(index);
                    },
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(labelText: 'Add todo'),
            onSubmitted: (value) {
              addTodo();
            },
          ),
        ),
        CenterFloatingActionButton(addTodo),
      ],
    );
  }
}

class CenterFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  CenterFloatingActionButton(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: FloatingActionButton(
        backgroundColor: Colors.grey[700],
        onPressed: onPressed,
        child: Icon(Icons.add),
      ),
    );
  }
}

// TODO Complete the file main_screen.dart
//-----------------------------------------------------------------------------------------------------------------------------
//? Things to do:
//
//   1. Declare all the states required for this screen. To be done in this file.
//      You may also want to define getters and setters for the states.
//      The states should include:
//        a. the 'logged in user'
//        b. the 'list of todos'
//        c. a 'Future' data for the todo list
//
//   2. Define several methods in the 'MainScreenState' class
//      to synchronize changes on UI and data update on REST server:
//        a. to get all the list of todos for the current user
//        b. addTodo(): to add a new todo
//        c. updateTodo(): to edit a todo
//        d. deleteTodo(): to delete a todo
//
//   3. Build this screen with conditional UI technique (based on
//      whether the user has logged in or not).
//      This includes:
//        a. The app bar shows 'unknown user' or 'logged user'
//           This part is to be done in 'bar.dart'
//
//        b. The body shows nothing if the user hasn't logged in. Otherwise,
//           it shows the list of todo items for the logged in user.
//           This part is to be done here in this file.
//
//        c. The floatingActionButton shows nothing if the user hasn't logged in.
//           Otherwise, it shows the 'Plus' and 'Refresh' buttons
//           This part is to be done here in this file.
//
//   3. Build the UI by composing from its components, i.e., Bar, Body and Float.
//      Besides, you will also need to pass the 'states' to the components.
//-----------------------------------------------------------------------------------------------------------------------------

import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../models/todo.dart';
import '../../services/todo_service.dart';

import 'bar.dart';
import 'body.dart';
import 'float.dart';

class MainScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => MainScreen());

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  User _user;
  List<Todo> _todoList;
  Future<List<Todo>> _todoListFuture;

  get user => _user;
  set user(value) {
    setState(() {
      _user = value;
      getAllTodoList();
    });
  }

  get todoList => _todoList;
  set todoList(value) => _todoList = value;

  get todoListFuture => _todoListFuture;
  set todoListFuture(value) => _todoListFuture = value;

  void getAllTodoList() {
    if (_user != null) {
      setState(() {
        _todoListFuture = TodoService.getTodoListByUser(user.id);
      });
    }
  }

  void addTodo(Todo todo) async {
    final Todo _todo = await TodoService.addTodo(todo);
    setState(() => _todoList.add(_todo));
  }

  void updateTodo({int index, Todo todo}) async {
    final Todo _todo = await TodoService.updateTodo(todo);

    if (_todo != null) {
      setState(() {
        _todoList[index] = _todo;
      });
    }
  }

  void removeTodo(int index) async {
    await TodoService.removeTodo(todoList[index]);

    setState(() {
      _todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: SafeArea(
        child: Scaffold(
          appBar: Bar(state: this),
          body: user != null ? Body(state: this) : null,
          floatingActionButton: Float(
            state: this,
          ),
        ),
      ),
    );
  }
}

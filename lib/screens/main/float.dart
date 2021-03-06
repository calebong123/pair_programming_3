// TODO Complete the file, main/float.dart
//-----------------------------------------------------------------------------------------------------------------------------
//? Things to do:
//   1. Perform the following operations:
//        a. Add a new todo  - i.e. when the user taps on the 'plus' button
//           This operation will navigate to the '/new' route.
//        b. Refresh the screen - i.e. when the user taps on the 'Refresh' button
//-----------------------------------------------------------------------------------------------------------------------------

import 'package:flutter/material.dart';

import 'main_screen.dart';

class Float extends StatelessWidget {
  const Float({state}) : _state = state;

  final MainScreenState _state;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          tooltip: 'Add a new todo',
          child: Icon(Icons.add),
          heroTag: null,
          onPressed: () => _onAddPressed(context),
        ),
        FloatingActionButton(
            tooltip: 'Refresh',
            child: Icon(Icons.refresh),
            heroTag: null,
            onPressed: () => _onRefreshPressed())
      ],
    );
  }

  void _onAddPressed(BuildContext context) async {
    final _newTodo =
        await Navigator.pushNamed(context, '/new', arguments: _state.user.id);

    if (_newTodo != null) _state.addTodo(_newTodo);
  }

  void _onRefreshPressed() => _state.getAllTodoList();
}

// TODO Complete the file, edit/body.dart
//-----------------------------------------------------------------------------------------------------------------------------
//? Things to do:
//   1. Build this screen with conditional UI technique (based on
//      whether it is for 'editing an existing todo' or 'creating a new todo').
//      This includes:
//        a. The 'done' field will only be enabled if it is an 'editing' mode
//
//   2. Update the states and reflect the changes on the UI:
//        a. when the user types in the 'title'.
//        b. when the user types in the 'description'.
//        c. when the user taps on the 'done' checkbox.
//
//   3. Perform the following operations:
//        a. Accept the updated / created item - i.e. when the 'Ok' button is tapped on.
//        b. Cancel the changes - i.e. when the 'Cancel' button is tapped on.
//-----------------------------------------------------------------------------------------------------------------------------

import 'package:flutter/material.dart';

import 'edit_screen.dart';

class Body extends StatelessWidget {
  const Body({state}) : _state = state;

  final EditScreenState _state;

  @override
  Widget build(BuildContext context) {
    return _state.widget.isEditing
        ? ListView(
            children: [
              _buildTextLisTile(
                  label: 'Title',
                  value: '${_state.widget.data.title}',
                  onChanged: (value) => _state.widget.data.title = value),
              _buildTextLisTile(
                  label: 'Description',
                  value: '${_state.widget.data.description}',
                  onChanged: (value) => _state.widget.data.description = value),
              CheckboxListTile(
                value: _state.widget.data.done,
                onChanged: (value) => _onDonePressed(value),
                title: Text('Done'),
              ),
              _buildButtons(context)
            ],
          )
        : ListView(
            children: [
              _buildTextLisTile(
                  label: 'Title',
                  value: '',
                  onChanged: (value) => _state.widget.data.title = value),
              _buildTextLisTile(
                  label: 'Description',
                  value: '',
                  onChanged: (value) => _state.widget.data.description = value),
              _buildButtons(context)
            ],
          );
  }

  ListTile _buildTextLisTile({label, value, onChanged}) {
    return ListTile(
      title: TextFormField(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
        ),
        onChanged: onChanged,
      ),
    );
  }

  Row _buildButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          child: Text('Ok'),
          onPressed: () => _onOkPressed(context),
        ),
        SizedBox(width: 10.0),
        ElevatedButton(
          child: Text('Cancel'),
          onPressed: () => _onCancelPressed(context),
        ),
      ],
    );
  }

  void _onDonePressed(bool value) {
    _state.isDone(value);
  }

  void _onOkPressed(BuildContext context) {
    Navigator.pop(context, _state.widget.data);
  }

  void _onCancelPressed(BuildContext context) {
    Navigator.pop(context, null);
  }
}


import 'package:crud/models/firebaseUser.dart';

abstract class TodoEvent {}

class LoadTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final FirebaseUser todo;

  AddTodo(this.todo);
}

// class UpdateTodo extends TodoEvent {
//   final FirebaseUser todo;

//   UpdateTodo(this.todo);
// }

// class DeleteTodo extends TodoEvent {
//   final String todoId;

//   DeleteTodo(this.todoId);
// }
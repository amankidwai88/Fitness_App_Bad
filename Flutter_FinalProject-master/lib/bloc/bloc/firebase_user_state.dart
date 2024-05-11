
import 'package:crud/models/firebaseUser.dart';

abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<FirebaseUser> todos;

  TodoLoaded(this.todos);
}

class TodoOperationSuccess extends TodoState {
  final String message;

  TodoOperationSuccess(this.message);
}

class TodoError extends TodoState {
  final String errorMessage;

  TodoError(this.errorMessage);
}
/* Developed by: Eng Mouaz M. Al-Shahmeh */
import 'package:firebase_example/controllers/services/firebase/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_example/models/todo.dart';

class TodoProvider extends ChangeNotifier {
  // initialize data
  String? _title;
  String? _dsc;
  List<TodoModel?> _listTodos = [];
  TodoModel? _selectedTodo;
  int? _loading = 0;

  // setters
  setTitle(String val) {
    _title = val;
    notifyListeners();
  }

  setDsc(String val) {
    _dsc = val;
    notifyListeners();
  }

  selectTodo(TodoModel val) {
    _selectedTodo = val;
    notifyListeners();
  }

  getTodosList() async {
    _loading = 1;
    _listTodos = [];
    Future.delayed(const Duration(seconds: 0), () async {
      // TODO: get all documents into collection
      final querySnapshot = await FirebaseService().todosCollection.get();
      final todos = querySnapshot.docs.map((e) {
        final model = TodoModel.fromJson(e.data() as Map<String, dynamic>);
        model.id = e.id;
        return model;
      }).toList();
      _listTodos = todos;
      _loading = 0;
      notifyListeners();
      return;
    });
  }

  addToList(TodoModel todo) {
    FirebaseService().addTodoData(todo);
    getTodosList();
    notifyListeners();
  }

  removeFromList(String id) {
    FirebaseService().removeTodoData(id);
    getTodosList();
    notifyListeners();
  }

  updateList(TodoModel todo) {
    FirebaseService().updateTodoData(todo);
    getTodosList();
    notifyListeners();
  }

  // getters
  int? get loading => _loading;
  String? get title => _title;
  String? get dsc => _dsc;
  List<TodoModel?> get listTodos => _listTodos;
  TodoModel? get selectedTodo => _selectedTodo;
}

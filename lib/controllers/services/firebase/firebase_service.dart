/* Developed by Eng Mouaz M. AlShahmeh */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_example/models/todo.dart';

class FirebaseService {
  // TODO: collection reference
  final CollectionReference todosCollection =
      FirebaseFirestore.instance.collection('todos');

  // TODO: add new todo data
  Future addTodoData(TodoModel todo) {
    return todosCollection.doc().set({
      'title': todo.title,
      'dsc': todo.dsc,
    });
  }

  // Todo: update todo data by document id
  Future updateTodoData(TodoModel todo) {
    return todosCollection.doc(todo.id).update({
      'title': todo.title,
      'dsc': todo.dsc,
    });
  }

  // TODO: remove todo item by document id
  Future removeTodoData(String id) {
    return todosCollection.doc(id).delete();
  }

  // todos list from snapshot
  List<TodoModel> _todosListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => TodoModel(
              id: doc['id'] ?? '', // TODO: id of the document no sql database
              title: doc['title'] ?? '',
              dsc: doc['dsc'] ?? '',
            ))
        .toList();
  }

  // TODO: get todos stream
  Stream<List<TodoModel>> get todos {
    return todosCollection.snapshots().map((e) => _todosListFromSnapshot(e));
  }
}

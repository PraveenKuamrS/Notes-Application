import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Core/internetConnectivity.dart';
import '../models/todo_model.dart';

class DatabaseServices {
  bool isInternetConnected = false;

  final CollectionReference todoCollection =
      FirebaseFirestore.instance.collection("todos");

  User? user = FirebaseAuth.instance.currentUser;

  Future<void> checkConnection() async {
    bool result = await isInternetConnectedGlobal();
    isInternetConnected = result; // Update the reactive variable
  }

  //add data
  Future<DocumentReference> addTododItem(
      String title, String description) async {
    return await todoCollection.add({
      'uid': user!.uid,
      'title': title,
      'description': description,
      'completed': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  //Update data
  Future<void> updateTodo(String id, String title, String description) async {
    final updateTodoCollection =
        FirebaseFirestore.instance.collection("todos").doc(id);
    return await updateTodoCollection.update({
      'title': title,
      'description': description,
    });
  }

//   Update todo status
  Future<void> updateTodoStatus(String id, bool completed) async {
    return await todoCollection.doc(id).update({
      'completed': completed,
    });
  }

// delete todo
  Future<void> deleteTodoTask(String id) async {
    return await todoCollection.doc(id).delete();
  }

  Stream<List<Todo>> get todos {
    return todoCollection
        .where('uid', isEqualTo: user?.uid)
        .where('completed', isEqualTo: false)
        .snapshots()
        .map(_todoListFromSnapshot);
  }

  Stream<List<Todo>> get completedTodos {
    return todoCollection
        .where('uid', isEqualTo: user?.uid)
        .where('completed', isEqualTo: true)
        .snapshots()
        .map(_todoListFromSnapshot);
  }

  List<Todo> _todoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Todo(
        id: doc.id,
        title: doc['title'] ?? '',
        description: doc['description'] ?? '',
        completed: doc['completed'] ?? '',
        timestamp: doc['createdAt'] ?? '',
      );
    }).toList();
  }
}

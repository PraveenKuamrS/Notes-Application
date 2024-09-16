import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:notesapplication/Services/todoServices.dart';
import 'package:notesapplication/models/todo_model.dart';

import '../controllers/home_controller.dart';

class PendingWidgetViewView extends GetView<HomeController> {
  PendingWidgetViewView({Key? key}) : super(key: key);
  final HomeController _homeController = HomeController();
  final DatabaseServices _databaseServices = DatabaseServices();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Todo>>(
        stream: _databaseServices.todos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Todo> todos = snapshot.data!;
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                Todo todo = todos[index];
                final DateTime dt = todo.timestamp.toDate();
                return Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: Colors.black12, style: BorderStyle.solid),
                  ),
                  child: Slidable(
                    key: ValueKey(todo.id),
                    endActionPane: ActionPane(
                      motion: DrawerMotion(),
                      children: [
                        SlidableAction(
                          autoClose: true,
                          onPressed: (context) async {
                            await _databaseServices.updateTodoStatus(
                                todo.id, true);
                          },
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          icon: Icons.done,
                          label: 'Completed',
                        ),
                      ],
                    ),
                    startActionPane: ActionPane(
                      motion: DrawerMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) async {
                            _showTaskDialog(context, todo: todo);
                          },
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: 'Edit',
                        ),
                        SlidableAction(
                          onPressed: (context) async {
                            await _databaseServices.deleteTodoTask(todo.id);
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        todo.description,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Text(
                        '${dt.day} / ${dt.month}/${dt.year}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
        });
  }

  void _showTaskDialog(BuildContext context, {Todo? todo}) {
    _homeController.titleController.text = todo!.title;
    _homeController.descriptionController.text = todo!.description;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            todo == null ? 'Add Task' : 'Update Task',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          content: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  TextField(
                    controller: _homeController.titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _homeController.descriptionController,
                    decoration: InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  )
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                if (todo == null) {
                  var addResponse = await _databaseServices.addTododItem(
                      _homeController.titleController.text,
                      _homeController.descriptionController.text);
                  print('addResponse $addResponse');
                } else {
                  await _databaseServices.updateTodo(
                      todo.id,
                      _homeController.titleController.text,
                      _homeController.descriptionController.text);
                }
                Navigator.pop(context);
              },
              child: Text(todo == null ? 'Add' : 'Update'),
            ),
          ],
        );
      },
    );
  }
}

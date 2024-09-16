import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:notesapplication/app/modules/home/controllers/home_controller.dart';

import '../../../../Services/todoServices.dart';
import '../../../../models/todo_model.dart';

class CompletedWidgetViewView extends GetView<HomeController> {
  CompletedWidgetViewView({Key? key}) : super(key: key);
  final HomeController _homeController = HomeController();
  final DatabaseServices _databaseServices = DatabaseServices();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Todo>>(
        stream: _databaseServices.completedTodos,
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
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(10)),
                  child: Slidable(
                    key: ValueKey(todo.id),
                    startActionPane: ActionPane(
                      motion: DrawerMotion(),
                      children: [
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
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      subtitle: Text(
                        todo.description,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.lineThrough,
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
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:notesapplication/Core/getStorage.dart';
import 'package:notesapplication/Services/todoServices.dart';
import 'package:notesapplication/app/modules/home/views/completed_widget_view_view.dart';
import 'package:notesapplication/app/modules/home/views/pending_widget_view_view.dart';

import '../../../../models/todo_model.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final HomeController homeController = Get.find<HomeController>();
  final DatabaseServices _databaseServices = DatabaseServices();

  final _widgets = [
    PendingWidgetViewView(),
    CompletedWidgetViewView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: const Text('Take Notes'),
        centerTitle: true,
        actions: [
          Icon(
            controller.isInternetConnected.value
                ? Icons.wifi
                : Icons.wifi_off_outlined,
            color: controller.isInternetConnected.value
                ? Colors.green
                : Colors.red,
          ),
          IconButton(
            onPressed: () {
              controller.logout();
            },
            icon: Icon(
              Icons.logout_rounded,
              color: Colors.red,
            ),
          )
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      homeController.buttonIndex.value = 0;
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 2.2,
                      decoration: BoxDecoration(
                        color: homeController.buttonIndex.value == 0
                            ? Colors.blue
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Pending',
                          style: TextStyle(
                            fontSize:
                                homeController.buttonIndex.value == 0 ? 16 : 14,
                            fontWeight: FontWeight.w500,
                            color: homeController.buttonIndex.value == 0
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      homeController.buttonIndex.value = 1;
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 2.2,
                      decoration: BoxDecoration(
                        color: homeController.buttonIndex.value == 1
                            ? Colors.blue
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Completed',
                          style: TextStyle(
                            fontSize:
                                homeController.buttonIndex.value == 1 ? 16 : 14,
                            fontWeight: FontWeight.w500,
                            color: homeController.buttonIndex.value == 1
                                ? Colors.white
                                : Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
              _widgets[homeController.buttonIndex.value],
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTaskDialog(context);
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  void _showTaskDialog(BuildContext context, {Todo? todo}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shadowColor: Colors.white60,
          backgroundColor: Colors.white,
          title: Text(
            todo == null ? 'Add Task' : 'Update Task',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  TextField(
                    controller: homeController.titleController,
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
                    controller: homeController.descriptionController,
                    maxLength: 500, // Limit the number of characters to 100
                    minLines: 1, // Start with one line
                    maxLines: 5, // Expand up to 5 lines
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    textInputAction: TextInputAction.newline,
                    cursorColor: Colors.blue,
                    showCursor: true,
                    // TextField will automatically become scrollable when maxLines is reached
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
                  if (controller.isInternetConnected.value == true) {
                    var addResponse = await _databaseServices.addTododItem(
                        homeController.titleController.text,
                        homeController.descriptionController.text);
                    print('addResponse $addResponse');
                  } else {
                    var data = {
                      'title': homeController.titleController.text,
                      'description': homeController.descriptionController.text
                    };
                    setValueToLocal('SAVEDATAFROMLOCAL', data);
                  }
                } else {
                  if (homeController.isInternetConnected.value) {
                    await _databaseServices.updateTodo(
                        todo.id,
                        homeController.titleController.text,
                        homeController.descriptionController.text);
                  } else {
                    var data = {
                      'id': todo.id,
                      'title': homeController.titleController.text,
                      'description': homeController.descriptionController.text
                    };
                    setValueToLocal('SAVEDATAFROMLOCAL', data);
                  }
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

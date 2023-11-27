import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/home/controller/home_controller.dart';
import 'package:to_do_app/home/model/to_do_list_model.dart';
import 'package:to_do_app/widget/custom_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: toDoList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addToDo,
        tooltip: 'add Todo',
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget toDoList() {
    return Container(
      color: Colors.white,
      child: Obx(() {
        final todoList = _homeController.toDoList;
        return todoList.isEmpty
            ? const Center(child: Text('No to do item avalible'))
            : SingleChildScrollView(
                child: Column(
                children: todoList.map((item) => itemToDo(item)).toList(),
              ));
      }),
    );
  }

  Widget itemToDo(ToDoListModel toDoListModel) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
            color: toDoListModel.isComplete ? Colors.green : Colors.black,
            width: 2),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(
                toDoListModel.titleTask,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          Expanded(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Checkbox(
                    activeColor:
                        toDoListModel.isComplete ? Colors.green : Colors.white,
                    value: toDoListModel.isComplete,
                    onChanged: (isCheck) =>
                        _homeController.completeTask(toDoListModel.id),
                  ),
                  Flexible(
                      child: Text(
                          toDoListModel.isComplete ? 'Complete' : 'in process'))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.dialog(CustomDialog(
                        title: 'Remove "${toDoListModel.titleTask}" item ?',
                        confirm: () {
                          _homeController.deleteToDo(toDoListModel.id);
                          Get.back();
                        },
                      ));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.red),
                      child: const Text(
                        'Remove',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  addToDo() {
    TextEditingController titleController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    Get.dialog(Dialog(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        padding: const EdgeInsets.all(8),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add to do item',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                width: Get.width * 0.3,
                margin: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter to do title';
                    }
                    return null;
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    _homeController.addToDo(titleController.text);
                    Get.back();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.green),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

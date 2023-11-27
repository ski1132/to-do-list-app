import 'package:get/get.dart';
import 'package:to_do_app/home/model/to_do_list_model.dart';
import 'package:to_do_app/widget/custom_dialog.dart';

class HomeController extends GetxController {
  RxList<ToDoListModel> toDoList = <ToDoListModel>[].obs;

  addToDo(String title) {
    toDoList.add(ToDoListModel(toDoList.length, title, false));
    toDoList.refresh();
  }

  completeTask(int id) {
    final todoFiltter = toDoList.firstWhereOrNull((todo) => todo.id == id);
    if (todoFiltter != null) {
      todoFiltter.isComplete = !todoFiltter.isComplete;
      toDoList.refresh();
    } else {
      Get.dialog(const CustomDialog(
          title: 'Something went wrong',
          message: 'this item unavalible for now'));
    }
  }

  deleteToDo(int id) {
    final todoFiltter = toDoList.firstWhereOrNull((todo) => todo.id == id);
    if (todoFiltter != null) {
      toDoList.removeWhere((todo) => todo.id == id);
      toDoList.refresh();
    } else {
      Get.dialog(const CustomDialog(
          title: 'Something went wrong', message: 'this item can\'t remove'));
    }
  }
}

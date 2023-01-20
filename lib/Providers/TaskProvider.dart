import 'package:flutter/material.dart';
import '../Models/TasksModel.dart';

class TaskProvider with ChangeNotifier{

  final List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  addItem(String title){
    if(title.isNotEmpty && title != " "){
      _tasks.add(TaskModel(isDone: false, title: title));
    }
    notifyListeners();
  }

  checkBox(int index,String title,bool isDone){
    _tasks.removeAt(index);
    _tasks.insert(index ,TaskModel(title: title, isDone: !isDone));
    notifyListeners();
  }

  delete(int index){
    _tasks.removeAt(index);
    notifyListeners();
  }

}
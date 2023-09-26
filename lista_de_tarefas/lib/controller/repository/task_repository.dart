import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/task.dart';

class TaskRepository {
  late SharedPreferences preferences;

  instancePreferences() async{
    preferences = await SharedPreferences.getInstance();
  }

  void insert({required String key, required List<Task> value}) async{
    await instancePreferences();
    
    preferences.setString(key, json.encode(value));
  }

  Future<List<Task>> get({required String key}) async{
    await instancePreferences();

    final String? tasks = preferences.getString(key);
    
    final List listTasks = json.decode(tasks!) as List;

    return listTasks.map((e) => Task.fromJson(e)).toList();
  }

  void delete({required String key}) async{
    await instancePreferences();

    preferences.remove(key);
  }

  void allDelete() async{
    preferences.clear();
  }
}
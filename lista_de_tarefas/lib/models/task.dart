class Task {
  Task({required this.title, required this.datetime});

  Task.fromJson(Map<String, dynamic> mapTask)
    : title = mapTask["title"],
      datetime = DateTime.parse(mapTask["datetime"]);

  String title;
  DateTime datetime;

  Map<String, dynamic> toJson(){
    return {
      "title": title,
      "datetime": datetime.toIso8601String()
    };
  }
}

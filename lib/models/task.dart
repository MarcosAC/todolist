class Task {
  final int? id;
  final String title;
  final String time;
  //Weather? weather;

  Task({this.id, required this.title, required this.time /*, this.weather*/});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'time': time,
    };
  }
}

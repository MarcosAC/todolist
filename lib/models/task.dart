class Task {
  final int? id;
  final String title;
  final String date;
  final String time;

  Task({
    this.id,
    required this.title,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date,
      'time': time,
    };
  }
}

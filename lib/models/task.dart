class Task {
  final int? id;
  final String title;
  final String date;
  final String time;
  // final DateTime date;
  // final TimeOfDay time;
  //Weather? weather;

  Task({this.id, required this.title, required this.date, required this.time /*, this.weather*/});

  // Map<String, dynamic> toMap() {
  //   return {
  //     'title': title,
  //     'date': _formatDate(date),
  //     'time': '${time.hour}:${time.minute}',
  //   };
  // }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date,
      'time': time,
    };
  }

  // String _formatDate(DateTime dateTime) {
  //   return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  // }
}

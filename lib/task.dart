class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});

  // shared prefernce only supports primitve data types.
  // so convert it into list of string
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      isCompleted: map['isCompleted'],
    );
  }
}

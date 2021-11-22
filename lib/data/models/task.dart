class Task {
  final int? id;
  final String? title;
  final String? content;
  final String? date;
  final String? startTime;
  final String? endTime;
  final int? remind;
  final String? repeat;
  final int? color;
  final int? isCompleted;

  Task(
      {this.id,
      this.title,
      this.content,
      this.date,
      this.startTime,
      this.endTime,
      this.remind,
      this.repeat,
      this.color,
      this.isCompleted});

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map["id"],
      title: map["title"],
      content: map["content"],
      date: map["date"],
      startTime: map["startTime"],
      endTime: map["endTime"],
      remind: map["remind"],
      repeat: map["repeat"],
      color: map["color"],
      isCompleted: map["isCompleted"],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = Map<String, dynamic>();

    map["id"] = id;
    map["title"] = title;
    map["content"] = content;
    map["date"] = date;
    map["startTime"] = startTime;
    map["endTime"] = endTime;
    map["remind"] = remind;
    map["repeat"] = repeat;
    map["color"] = color;
    map["isCompleted"] = isCompleted;

    return map;
  }
}

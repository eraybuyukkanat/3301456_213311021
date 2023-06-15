class Lesson {
  int? id;
  String? lessonName;
  int? lessonDay;
  String? lessonTime;
  String? lessonClass;

  Lesson(
      {this.id,
      this.lessonName,
      this.lessonDay,
      this.lessonTime,
      this.lessonClass});

  Lesson.fromMap(Map<dynamic, dynamic> item) {
    id = item['id'];
    lessonName = item['lessonName'];
    lessonDay = item['lessonWeekDay'];
    lessonTime = item['lessonTime'];
    lessonClass = item['lessonClass'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lessonName'] = this.lessonName;
    data['lessonWeekDay'] = this.lessonDay;
    data['lessonTime'] = this.lessonTime;
    data['lessonClass'] = this.lessonClass;
    return data;
  }
}

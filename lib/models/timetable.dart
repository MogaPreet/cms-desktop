class TimeTable {
  String? subject;
  String? day;
  int? index;
  String? startTime;
  String? endTime;
  String? classroom;
  String? year;
  String? branch;

  TimeTable({
    this.subject,
    this.day,
    this.index,
    this.startTime,
    this.endTime,
    this.classroom,
    this.year,
    this.branch,
  });

  TimeTable.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    day = json['day'];
    index = json['index'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    classroom = json['classroom'];
    year = json['year'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject'] = subject;
    data['day'] = day;
    data['index'] = index;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['classroom'] = classroom;
    data['year'] = year;
    data['branch'] = branch;
    return data;
  }
}

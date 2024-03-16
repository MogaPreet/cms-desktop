class StudentModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? branch;
  String? currentYear;
  bool? isDse;
  String? rollNo;

  StudentModel({
    this.uid,
    this.email,
    this.firstName,
    this.lastName,
    this.branch,
    this.rollNo,
    this.currentYear,
    this.isDse,
  });

  factory StudentModel.fromMap(map) {
    return StudentModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      branch: map['branch'],
      rollNo: map['rollNo'],
      currentYear: map['currentYear'],
      isDse: map['isDse'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'branch': branch,
      'rollNo': rollNo,
      'currentYear': currentYear,
      'isDse': isDse,
    };
  }
}

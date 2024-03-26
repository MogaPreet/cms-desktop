import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/student.dart';

class StudentPro extends ChangeNotifier {
  bool loading = false;
  bool get isLoading => loading;

  String? selectedBranch;
  String? get getSelectedBranch => selectedBranch;

  String error = '';
  String get getError => error;

  List<StudentModel> students = [];
  List<StudentModel> get getStudents => students;

  setStudents(List<StudentModel> val) {
    students = val;
    notifyListeners();
  }

  seterror(String val) {
    error = val;
    notifyListeners();
  }

  setload(bool val) {
    loading = val;
    notifyListeners();
  }

  setBranch(String val) {
    selectedBranch = val;
    notifyListeners();
  }

  Future<void> fetchStudents(String year) async {
    setload(true);
    List<StudentModel> loadedStudents = [];
    try {
      await FirebaseFirestore.instance
          .collection('students')
          .where('currentYear', isEqualTo: year)
          .get()
          .then((val) {
        loadedStudents =
            val.docs.map((e) => StudentModel.fromMap(e.data())).toList();
        setStudents(loadedStudents);
      });

      setload(false);
    } catch (error) {
      setload(false);
      print(error);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/timetable.dart';

class AddLectureScreen extends StatefulWidget {
  const AddLectureScreen({super.key});

  @override
  _AddLectureScreenState createState() => _AddLectureScreenState();
}

class _AddLectureScreenState extends State<AddLectureScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController subjectController = TextEditingController();
  String selectedDay = 'Monday'; // Default day
  int slot = 1; // Default day
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  TextEditingController classroomController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //create a dropdown for slot
  String selectedYear = 'First Year';
  String selectedBranch = 'Computer Engineering';

  List<int> noOfSlots = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
  ];

  List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  void _addLecture() async {
    if (_formKey.currentState!.validate()) {
      String subject = subjectController.text;
      String classroom = classroomController.text;

      // Format times for storage/display
      final String formattedStartTime =
          startTime != null ? startTime!.format(context) : '';
      final String formattedEndTime =
          endTime != null ? endTime!.format(context) : '';

      TimeTable lecture = TimeTable(
        subject: subject,
        day: selectedDay,
        index: slot,
        startTime: formattedStartTime,
        endTime: formattedEndTime,
        classroom: classroom,
        year: selectedYear,
        branch: selectedBranch,
      );

      await firestore
          .collection('timetable')
          .doc(selectedYear)
          .collection(selectedBranch)
          .add(lecture.toJson());

      // Clear the inputs
      subjectController.clear();
      classroomController.clear();
      setState(() {
        // Reset to default or keep the last selected
        selectedDay = 'Monday';
        startTime = null;
        endTime = null;
      });
    }
  }

  Future<void> _pickTime(BuildContext context,
      {required bool isStartTime}) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  void _pickSlot(BuildContext context) async {
    final int? picked = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Slot'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: noOfSlots.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(noOfSlots[index].toString()),
                  onTap: () => Navigator.of(context).pop(noOfSlots[index]),
                );
              },
            ),
          ),
        );
      },
    );
    if (picked != null && picked != slot) {
      setState(() {
        slot = picked;
      });
    }
  }

  void _pickDay(BuildContext context) async {
    final String? picked = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Day'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: daysOfWeek.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(daysOfWeek[index]),
                  onTap: () => Navigator.of(context).pop(daysOfWeek[index]),
                );
              },
            ),
          ),
        );
      },
    );
    if (picked != null && picked != selectedDay) {
      setState(() {
        selectedDay = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Lecture'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: subjectController,
                  decoration: InputDecoration(labelText: 'Subject'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a subject';
                    }
                    return null;
                  },
                ),
                ListTile(
                  title: Text('Day of Week: $selectedDay'),
                  onTap: () {
                    _pickDay(context);
                  },
                ),
                ListTile(
                  title: Text('Select Slot(index): $slot'),
                  onTap: () {
                    _pickSlot(context);
                  },
                ),
                ListTile(
                  title: Text(
                      'Start Time: ${startTime?.format(context) ?? 'Tap to select'}'),
                  onTap: () => _pickTime(context, isStartTime: true),
                ),
                ListTile(
                  title: Text(
                      'End Time: ${endTime?.format(context) ?? 'Tap to select'}'),
                  onTap: () => _pickTime(context, isStartTime: false),
                ),
                TextFormField(
                  controller: classroomController,
                  decoration: InputDecoration(labelText: 'Classroom'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a classroom';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectedYear,
                  items: [
                    'First Year',
                    'Second Year',
                    'Third Year',
                    'Fourth Year'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedYear = value!;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Year'),
                ),
                DropdownButtonFormField<String>(
                  value: selectedBranch,
                  items: [
                    'Computer Engineering',
                    'Electronics Engineering',
                    'Mechanical Engineering',
                    'Civil Engineering',
                    'Electrical Engineering',
                    'Information Technology',
                    'Artificial Intelligence & Data Science'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedBranch = value!;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Branch'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addLecture,
                  child: Text('Add Lecture'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

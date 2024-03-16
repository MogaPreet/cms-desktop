import 'package:flutter/material.dart';
import 'package:myapp/models/student.dart';
import 'package:myapp/providers/studentPro.dart';
import 'package:provider/provider.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key}); // Add your actual branches

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Branch'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 2.9),
        padding: const EdgeInsets.all(16.0),
        itemCount: 11,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StudentsByBranchScreen(),
                ),
              );
            },
            child: const Card(
              elevation: 2.0,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.engineering, size: 50.0),
                    Text(
                      "",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class StudentsByBranchScreen extends StatefulWidget {
  const StudentsByBranchScreen({super.key});

  @override
  State<StudentsByBranchScreen> createState() => _StudentsByBranchScreenState();
}

class _StudentsByBranchScreenState extends State<StudentsByBranchScreen> {
  @override
  Widget build(BuildContext context) {
    // In a real application, you would fetch students for the selected branch from your data source
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchFilterSection(),
            const SizedBox(height: 16),
            Expanded(
              child: StudentListSection(),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchFilterSection extends StatelessWidget {
  const SearchFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                // Implement search logic here
              },
            ),
          ),
          const SizedBox(width: 16),
          Consumer<StudentPro>(
            builder: (BuildContext context, StudentPro value, Widget? child) {
              return DropdownButton<String>(
                // Replace with actual selected value

                borderRadius: BorderRadius.circular(8),
                hint: const Text('Filter by Branch'),
                icon: const Icon(Icons.filter_list),
                value: value.getSelectedBranch,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                underline: Container(
                  height: 0,
                  color: Colors.transparent,
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),

                items: [
                  'Artificial Intelligence & Data Science',
                  'Computer Engineering',
                  'Civil Engineering',
                  'Electrical Engineering',
                  'Electronics Engineering',
                  'Information Technology',
                  'Mechanical Engineering',
                ] // Replace with actual filter options
                    .map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  // Implement filter logic here
                  value.setBranch(newValue ?? "");
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class StudentListSection extends StatefulWidget {
  const StudentListSection({super.key});

  @override
  State<StudentListSection> createState() => _StudentListSectionState();
}

class _StudentListSectionState extends State<StudentListSection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StudentPro>(
      builder: (context, myDataProvider, child) {
        if (myDataProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return myDataProvider.getStudents.isEmpty
              ? Center(child: Text('No data available'))
              : ListView.builder(
                  itemCount: myDataProvider.getStudents.length,
                  itemBuilder: (context, index) {
                    StudentModel data = myDataProvider.getStudents[index];
                    String fistname = data.firstName ?? "";
                    String lastname = data.lastName ?? "";
                    return ListTile(
                      title: Text('$fistname $lastname'),
                      subtitle: Text('Department: ${data.branch}'),
                    );
                  },
                );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myapp/ui/add_lecture.dart';
import 'package:myapp/ui/notifications_screen.dart';
import 'package:myapp/ui/students_screen.dart';
import 'package:myapp/ui/teachers_screen.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Dashboard',
    ),
    Text(
      'Notifications',
    ),
    Text(
      'Settings',
    ),
    Text(
      'TimeTable',
    ),
  ];
  Widget route(int index) {
    switch (index) {
      case 0:
        return const DashboardScreen();
      case 1:
        return NotificationsScreen();
      case 2:
        return const Text('Settings');
      case 3:
        return AddLectureScreen();
      default:
        return const Text('Dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.north_east),
        title: Consumer<dashboardProvider>(
            builder: (context, dashboardProvdier, child) {
          return _widgetOptions[dashboardProvdier.getSelectedIndex];
        }),
      ),
      body: Consumer<dashboardProvider>(
        builder: (context, value, child) {
          return Center(child: route(value.getSelectedIndex));
        },
      ),
      bottomNavigationBar: Consumer<dashboardProvider>(
        builder: (context, value, child) {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'TimeTable',
              ),
            ],
            currentIndex: value.getSelectedIndex,
            selectedItemColor: Colors.blue,
            onTap: (n) {
              value.setselectedIndex(n);
            },
          );
        },
      ),
    );
  }
}

class dashboardProvider with ChangeNotifier {
  int _selectedIndex = 0;
  int get getSelectedIndex => _selectedIndex;

  setselectedIndex(int val) {
    _selectedIndex = val;
    notifyListeners();
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage'),
      ),
      body: GridView.count(
        childAspectRatio: 1.9,
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildGridItem(
            context,
            'Students',
            Icons.school,
            StudentsScreen(),
          ),
          _buildGridItem(
            context,
            'Teachers',
            Icons.person,
            const TeachersScreen(),
          ),
          // _buildGridItem(
          //   context,
          //   'Courses',
          //   Icons.book,
          //   CoursesScreen(),
          // ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'CMS Admin',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),

            ListTile(
              title: const Text('Students'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentsScreen()),
                );
              },
            ),
            ListTile(
              title: const Text('Teachers'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TeachersScreen()),
                );
              },
            ),
            // ListTile(
            //   title: Text('Courses'),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => CoursesScreen()),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(
      BuildContext context, String title, IconData icon, Widget destination) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Card(
        elevation: 2.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50.0,
              color: Colors.blue,
            ),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

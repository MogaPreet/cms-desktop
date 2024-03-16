import 'package:flutter/material.dart';
import 'package:myapp/counterPro.dart';
import 'package:myapp/providers/aut_pro.dart';
import 'package:myapp/providers/studentPro.dart';
import 'package:myapp/ui/homescreen.dart';
import 'package:myapp/ui/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCQ29fnMBpUBA9frcPey2oX-0kw6Wc6Gig",
          appId: "1:208599616375:android:52cd0da6616138db8baf72",
          messagingSenderId: "208599616375",
          projectId: "cmsrgit"));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => CounterProvider()),
    ChangeNotifierProvider(create: (context) => AuthProvider()),
    ChangeNotifierProvider(create: (context) => dashboardProvider()),
    ChangeNotifierProvider(create: (context) => StudentPro()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/dashboard': (context) => const Dashboard(),
        '/login': (context) => const Loginscreen(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'CMS ADMIN'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Loginscreen()));
            },
            child: const Text('Login')),
      ),
      // floatingActionButton: Consumer<CounterProvider>(
      //   builder: (BuildContext context, value, Widget? child) {
      //     return Column(
      //       mainAxisAlignment: MainAxisAlignment.end,
      //       children: [
      //         FloatingActionButton(
      //           onPressed: () => value.increment(),
      //           tooltip: 'Increment',
      //           child: const Icon(Icons.add),
      //         ),
      //         const SizedBox(
      //           height: 10,
      //         ),
      //         FloatingActionButton(
      //           onPressed: () => value.decrement(),
      //           tooltip: 'decrement',
      //           child: const Icon(Icons.remove),
      //         ),
      //       ],
      //     );
      //   },
      // ),
    );
  }
}

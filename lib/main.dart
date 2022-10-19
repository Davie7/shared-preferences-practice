import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/home_screen.dart';
import 'screens/welcome_screen.dart';


void main() {
  runApp(const MyApp());
}

// This simple app shows the welcome screen to the user if it is the first time the user is accessing it
// It goes directly to the home screen if the user has previously accessed the application.

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(title: 'Data persistence'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: ()async {
            bool visitingFlag = await getVisitingFlag();
            setVisitingFlag();

            if (visitingFlag == true){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(),));
              // case if user has visited tha app before
            }else{
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => WelcomeScreen(),));
              // case if user is visiting for the first time
            }
          },
          child: Text('Proceed'),
        ),
      ),
    );
  }
}

setVisitingFlag() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool('alreadyVisited', true);
}

getVisitingFlag() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool alreadyVisited = preferences.getBool('alreadyVisited') ?? false;
  return alreadyVisited;
}

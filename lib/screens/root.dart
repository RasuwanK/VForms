import 'package:flutter/material.dart';
import 'package:vforms/components/navbar.dart';
import 'package:vforms/screens/forms.dart';
import 'package:vforms/screens/home.dart';
import 'package:vforms/screens/profile.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentScreen = 0;

  var screens = [
    HomePage(),
    FormsPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    currentScreen = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('VForms'),
      ),
      body: screens[currentScreen],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Pressed');
        },
        tooltip: 'Increment',
        child: const Icon(Icons.camera_alt),
      ),
      bottomNavigationBar: Navbar(
        currentScreen: currentScreen,
        setScreen: (int index) {
          setState(() {
            currentScreen = index;
          });
        },
      ),
    );
  }
}

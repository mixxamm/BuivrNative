import 'package:facilitap/views/Taken.dart';
import 'package:facilitap/views/archief.dart';
import 'package:facilitap/views/instellingen.dart';
import 'package:facilitap/views/meldingen.dart';
import 'package:facilitap/views/noodgeval.dart';
import 'package:facilitap/views/notificaties.dart';
import 'package:facilitap/views/overzicht.dart';
import 'package:flutter/material.dart';
import 'material_color_generator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: generateMaterialColor(Color(0xFFc30009)),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _viewName = 'Overzicht';

  void changeView(BuildContext context, String viewName) {
    setState(() {
      _viewName = viewName;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(_viewName),
      ),
      body: views[_viewName],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/depooter.png'),
                  ),
                  Text(
                    'Marijn De Pooter',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
                  ),
                  Text(
                    'p******@ap.be',
                    style: TextStyle(color: Color(0x88000000)),
                  )
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.apps),
              title: Text('Overzicht'),
              onTap: () {
                changeView(context, 'Overzicht');
              },
            ),
            ListTile(
              leading: Icon(Icons.insert_chart),
              title: Text('Mijn meldingen'),
              onTap: () {
                changeView(context, 'Meldingen');
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Mijn taken'),
              onTap: () {
                changeView(context, 'Taken');
              },
            ),
            ListTile(
              leading: Icon(Icons.archive),
              title: Text('Archief'),
              onTap: () {
                changeView(context, 'Archief');
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notificaties'),
              onTap: () {
                changeView(context, 'Notificaties');
              },
            ),
            ListTile(
              leading: Icon(Icons.warning),
              title: Text('Noodgeval'),
              onTap: () {
                changeView(context, 'Noodgeval');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Instellingen'),
              onTap: () {
                changeView(context, 'Instellingen');
              },
            ),
          ],
        ),
      ),
    );
  }
}

Map<String, Widget> views = {
  'Overzicht': Overzicht(),
  'Meldingen': Meldingen(),
  'Taken': Taken(),
  'Archief': Archief(),
  'Notificaties': Notificaties(),
  'Noodgeval': Noodgeval(),
  'Instellingen': Instellingen()
};

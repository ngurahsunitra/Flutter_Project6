import 'package:flutter/material.dart';
import 'package:flutter_crud_api_sample_app/about.dart';
import 'package:flutter_crud_api_sample_app/src/ui/formadd/form_add_screen.dart';
import 'package:flutter_crud_api_sample_app/src/ui/home/home_screen.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.cyan[900],
        accentColor: Colors.cyan[900],
      ),
      home: Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          centerTitle: true,
          leading: new IconButton(
            padding: const EdgeInsets.only(left: 15.0),
            icon: new Icon(Icons.menu
            ),
            onPressed: () {},
          ),
          title: Text(
            "Flutter CRUD API",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.info_outline,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutRoute()),
                );
              },
            ),
            SizedBox(
              width: 15,
            )
          ],
        ),
        body: HomeScreen(),
        bottomNavigationBar: BottomAppBar(
          //color: Colors.transparent,
          child: Container(
            height: 25,
            color: Colors.cyan[900],
            alignment: Alignment.center,
            child: Text(
              'Developed with <3 by @ngurahsunitra.',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            ),
          ),
          //elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FormAddScreen()),
            );
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.cyan[900],
        ),
      ),
    );
  }
}

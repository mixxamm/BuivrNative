import 'package:flutter/material.dart';

import 'Bib.dart';
import 'nieuwe_bib.dart';

class Bibs extends StatefulWidget {
  @override
  _BibsState createState() => _BibsState();
}

class _BibsState extends State<Bibs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Bib(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: Hero(tag: 'plus', child: Icon(Icons.add)),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NieuweBib()));
        },
      ),
    );
  }
}

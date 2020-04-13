import 'package:facilitap/components/defect_tile.dart';
import 'package:flutter/material.dart';

class Overzicht extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            bottomSheet(context);
          }),
      body: ListView(
        children: <Widget>[DefectTile()],
      ),
    );
  }
}

void bottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Wrap(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Nieuwe opdracht'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.broken_image),
            title: Text('Nieuwe defectmelding'),
            onTap: () {},
          ),
        ],
      ),
    ),
  );
}

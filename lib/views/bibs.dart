import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'Bib.dart';
import 'nieuwe_bib.dart';

class Bibs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.amber,
            child: Hero(tag: 'plus', child: Icon(Icons.add)),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NieuweBib()));
            }),
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('bibs').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading...');
              default:
                return new ListView(
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    return new Bib(
                        naam: document['naam'],
                        adres: document['adres'],
                        afbeelding: FirebaseStorage()
                            .ref()
                            .child(
                                '/bibs/thumbnails/${document.documentID}_200x200')
                            .getDownloadURL(),
                        open: document['open'],
                        id: document.documentID);
                  }).toList(),
                );
            }
          },
        ));
  }
}

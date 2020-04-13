import 'dart:io' show File;

import 'package:app/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final Firestore _firestore = Firestore.instance;

class NieuweBib extends StatefulWidget {
  @override
  _NieuweBibState createState() => _NieuweBibState();
}

class _NieuweBibState extends State<NieuweBib> {
  final _formKey = GlobalKey<FormState>();

  String _naam, _beschrijving, _adres;
  int _aantal = 6;
  File _image;
  bool _opslaan = false;
  bool _open = true;

  Future kiesAfbeeldingVanafCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
    Navigator.of(context).pop();
  }

  Future kiesAfbeeldingVanafGallerij() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
    Navigator.of(context).pop();
  }

  Future uploadImage(String documentID) async {
    StorageUploadTask uploadTask =
        FirebaseStorage().ref().child('bibs/$documentID').putFile(_image);
    await uploadTask.onComplete;
    setState(() {
      _opslaan = false;
    });
    return;
  }

  void kiesAfbeelding() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.camera),
            title: Text('Neem foto'),
            onTap: kiesAfbeeldingVanafCamera,
          ),
          ListTile(
            leading: Icon(Icons.photo),
            title: Text('Kies uit gallerij'),
            onTap: kiesAfbeeldingVanafGallerij,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Hero(tag: 'plus', child: Icon(Icons.add)),
        backgroundColor: Colors.amber,
        title: Text('Nieuwe Bib'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _opslaan,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration:
                          kInputDecoration.copyWith(hintText: 'Naam bib'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Vul een naam in';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _naam = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: kInputDecoration.copyWith(
                          hintText: 'Beschrijving (optioneel)'),
                      onChanged: (value) {
                        _beschrijving = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: kInputDecoration.copyWith(hintText: 'Adres'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Vul een adres in';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _adres = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      children: <Widget>[
                        Text('Capaciteit'),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Slider(
                                  value: _aantal.toDouble(),
                                  min: 2,
                                  max: 30,
                                  onChanged: (value) {
                                    setState(() {
                                      _aantal = value.toInt();
                                    });
                                  }),
                            ),
                            Text('$_aantal/30')
                          ],
                        ),
                      ],
                    ),
                  ),
                  Center(
                      child: _image == null
                          ? MaterialButton(
                              child: Text(
                                'Kies afbeelding',
                                style: TextStyle(color: Colors.amber),
                              ),
                              onPressed: () {
                                kiesAfbeelding();
                              },
                            )
                          : GestureDetector(
                              onTap: kiesAfbeelding,
                              child: Image.file(
                                _image,
                                height: 200,
                              ),
                            )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Start open'),
                      Center(
                        child: Switch(
                          activeColor: Colors.amber,
                          onChanged: (value) {
                            setState(() {
                              _open = value;
                            });
                          },
                          value: _open,
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        onPressed: () {
                          // Validate will return true if the form is valid, or false if
                          // the form is invalid.
                          if (_formKey.currentState.validate()) {
                            if (_image != null) {
                              setState(() {
                                _opslaan = true;
                              });
                              _firestore.collection('bibs').add({
                                'naam': _naam,
                                'beschrijving': _beschrijving,
                                'adres': _adres,
                                'capaciteit': _aantal,
                                'open': _open,
                              }).then((value) => uploadImage(value.documentID)
                                  .then(
                                      (value) => Navigator.of(context).pop()));
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text('Afbeelding ontbreekt'),
                                        content: Text(
                                            "Je moet een afbeelding uploaden om een bib te kunnen aanmaken."),
                                        actions: <Widget>[
                                          MaterialButton(
                                            child: Text("Ok"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              kiesAfbeelding();
                                            },
                                          )
                                        ],
                                      ));
                            }
                          }
                        },
                        child: Text('Aanmaken'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

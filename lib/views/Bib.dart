import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Bib extends StatefulWidget {
  Bib({this.naam, this.adres, this.afbeelding, this.open, this.id});

  final String naam, adres, id;
  final bool open;

  final Future<dynamic> afbeelding;

  @override
  _BibState createState() => _BibState();
}

class _BibState extends State<Bib> {
  String url = '';

  @override
  void initState() {
    super.initState();

    getAfbeelding();
  }

  void getAfbeelding() async {
    String urlString = await widget.afbeelding;
    setState(() {
      url = urlString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 220,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  url,
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: ListTile(
                  title: Text(
                    widget.naam,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.open
                    ? Chip(backgroundColor: Colors.blue, label: Text("Open"))
                    : Chip(
                        backgroundColor: Colors.red,
                        label: Text("Gesloten"),
                      ),
              )
            ],
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text(widget.adres),
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text(
                  'Inchecken',
                  style: TextStyle(color: Colors.amber),
                ),
                onPressed: () {/* ... */},
              ),
              FlatButton(
                child: const Text(
                  'Meer informatie',
                  style: TextStyle(color: Colors.amber),
                ),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => Column(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(28.0),
                                  child: QrImage(
                                    backgroundColor: Colors.white,
                                    data: widget.id,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Aanwezigen: /',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              )
                            ],
                          ));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

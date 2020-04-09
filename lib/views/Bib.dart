import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Bib extends StatelessWidget {
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
                  'https://lh3.googleusercontent.com/xDp5M_jMilgWmZBRM6KvGkrH6hBXL7BTm4SFbNGMEKIaVEC0rhjQRX33T0jp6tg0XIGqCfFWqjVzsrI1OG5Rz_loxc2wBvEIC3YeyI3931m4Kat5Ghl3qQOxnIMotmaYIU7y27b_eXQ=w1204-h903-no',
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: ListTile(
                  title: Text(
                    'Floribib',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Chip(
                  backgroundColor: Colors.blue,
                  label: Text("Open"),
                ),
              )
            ],
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Floriwijk 3, 2860 Sint-Katelijne-Waver'),
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
                                    data: 'https://buivr.ml',
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

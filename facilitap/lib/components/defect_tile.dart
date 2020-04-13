import 'package:facilitap/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DefectTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        elevation: 8,
        child: Stack(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Image.network(
                    'https://s.s-bol.com/imgbase0/imagebase3/large/FC/2/0/0/5/9200000082645002.jpg',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Beamer kapot',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: false,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Ellermanstraat',
                          style: kHalfText,
                        ),
                        Text(
                          '02.05',
                          style: kHalfText,
                        ),
                        Text(
                          'Status: Open',
                          style: kHalfText,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              right: 8.0,
              top: 8.0,
              child: Container(
                width: 20,
                height: 20,
                decoration:
                    BoxDecoration(color: Colors.green, shape: BoxShape.circle),
              ),
            ),
            Positioned(
              right: 8,
              bottom: 10,
              child: Chip(
                backgroundColor: Colors.transparent,
                label: Text('Elektriciteit'),
                shape: StadiumBorder(
                  side: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

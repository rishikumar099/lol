import 'package:flutter/material.dart';
import 'package:ss_media/widgets/header.dart';

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, appBarTitle: 'SS MEDIA', isStyle: true),
      body: Text('timeline'),
      );
  }
}
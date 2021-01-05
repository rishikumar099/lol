import 'package:flutter/material.dart';

Widget header(context, {appBarTitle, isStyle, removeBackButton = false}) {
  return AppBar(
    automaticallyImplyLeading: removeBackButton ? false : true,
    title: Text(
      appBarTitle,
      style: TextStyle(
        color: Colors.white,
        fontFamily: isStyle ? 'Signatra' : null,
        fontSize: isStyle ? 50.0 : 22.0,
      ),
    ),

    backgroundColor: Theme.of(context).primaryColor,

    centerTitle: true,
  );
}

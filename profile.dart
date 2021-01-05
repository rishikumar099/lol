import 'package:flutter/material.dart';
import 'package:ss_media/widgets/header.dart';
import 'home.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, appBarTitle: 'Profile', isStyle: false),
      body: Column(
        children: [
          Text('profile'),  

          RaisedButton(
            child: Text('logg out'),
            onPressed:() {
              setState(() {
                googleSignIn.signOut();  
              });
            }     
          ),

        ],
      ),
    );
  }
}

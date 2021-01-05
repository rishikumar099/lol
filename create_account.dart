import 'package:flutter/material.dart';
import 'package:ss_media/widgets/header.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
  String username;

  submit() {
    final form = _formKey.currentState;
    form.save();
    Navigator.pop(context, username);
    // if(form.validate()) {
    //   form.save();
    //   // SnackBar snackbar = SnackBar(
    //   //   content: Text(
    //   //     'welcome $username'
    //   //   )
    //   // );
    //   // _scaffoldKey.currentState.showSnackBar(snackbar);
    //   // Timer(Duration(seconds: 2), () {
    //   //   Navigator.pop(context, username);
    //   // });

    //   Navigator.pop(context, username);
    // }
  }
  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      // key: _scaffoldKey,
      appBar: header(context, appBarTitle: 'Set up Your Profile', isStyle: false, removeBackButton: true),
      body: ListView(
        children: [

          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Center(
              child: Text(
                'Create a username',
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              child: Form(
                key: _formKey,
                autovalidate: true,
                child: TextFormField(
                  validator: (val) {
                    if(val.trim().length < 3 || val.isEmpty) {
                      return 'Username too short';
                    } else if(val.trim().length > 13) {
                      return 'Username too long';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (val) => username = val,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'username',
                    labelStyle: TextStyle(
                      fontSize: 15.0,
                    ),
                    hintText: 'Must be atleast 3 characters'
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: submit,
              child: Container(
                height: 50.0,
                width: 350.0,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

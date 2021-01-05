import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ss_media/models/user.dart';
import 'package:ss_media/pages/activity_feed.dart';
import 'package:ss_media/pages/create_account.dart';
import 'package:ss_media/pages/profile.dart';
import 'package:ss_media/pages/search.dart';
import 'package:ss_media/pages/timeline.dart';
import 'package:ss_media/pages/upload.dart';


final GoogleSignIn googleSignIn = GoogleSignIn();
final userRef = FirebaseFirestore.instance.collection('users');
final DateTime timestamp = DateTime.now();
User currentuser;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    // The users will be able to login using this functionality but once 
    // the app is restarted they will have to login again

    createUserInFirestore() async {
      // 1)check if user exist in the users collection in database (according to their id)
      final GoogleSignInAccount user = googleSignIn.currentUser;
      DocumentSnapshot document = await userRef.doc(user.id).get();
      // 2)if the users doesnt exist take them to the profile page.
      if(!document.exists) {
        final username = await Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => CreateAccount(),),
        );
        // 3)get username from create account, use it to make new user document in users collection
        FirebaseFirestore.instance.collection('user').doc(user.id).set({
          'id': user.id,
          'username': username,
          'photourl': user.photoUrl,
          'email': user.email,
          'displayname': user.displayName,
          'bio': null,
          'timestamp': timestamp,
        });
        document = await FirebaseFirestore.instance.collection('user').doc(user.id).get();   
      }
      User.fromDocument(document);
    }

    googleSignIn.onCurrentUserChanged.listen((account) { 
      print('lol');
      if(googleSignIn!= null) {
        createUserInFirestore();
        setState(() {
          isAuth = true;
        });
      } else {
        setState(() {
          isAuth = false;
        });
      }
    }, onError: (err){
      print('The error in logging found is $err');
    });
    
    // The users will be logged in though the the app is restated.
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      print('llll');
      if(googleSignIn!= null) {
        createUserInFirestore();
        setState(() {
          isAuth = true;
        });
      } else {
        setState(() {
          isAuth = false;
        });
      }
    }).catchError((err){
      print('The error in logging found is $err');
    });
  }

  @override
  void dispose() { 
    super.dispose();
    pageController.dispose();
  }


  void login() {
    print('ankit');
    googleSignIn.signIn();
  }


  // void logout() {
  //   setState(() {
  //     googleSignIn.signOut();  
  //   });
  // }
  
  // Widget buildAuthScreen() {
  //   return RaisedButton(
  //     child: Text('logg out'),
  //     onPressed: logout,
  //   );
  // }

  Widget buildAuthScreen() {
    return Scaffold(
      
      body: PageView(
        children: [
         Timeline(),
         ActivityFeed(),
         Upload(),
         Search(),
         Profile(),
        ],
        controller: pageController,
        onPageChanged: (int pageIndex) {
          setState(() {
            this.pageIndex = pageIndex;
          });
        },
      ),

      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.whatshot),),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active),),
          BottomNavigationBarItem(icon: Icon(Icons.photo_camera),),
          BottomNavigationBarItem(icon: Icon(Icons.search),),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle),),
        ],
        onTap: (int pageIndex) {
          pageController.animateToPage(
            pageIndex,
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 300),
          );
        },
        activeColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget buildUnAuthScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).accentColor,
              Theme.of(context).primaryColor,
            ]
          ),
        ),

        alignment: Alignment.center,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text(
              'SS Media',
              style: TextStyle(
                fontFamily: 'Signatra',
                fontSize: 90.0,
                color: Colors.white,
              ),
            ),

            GestureDetector(
              onTap: login,
              child: Container(
                height: 60,
                width: 260,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/google_signin_button.png'),
                    fit: BoxFit.fill 
                  ), 
                ),
              ) 
            ),
          ],
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}

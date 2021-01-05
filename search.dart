import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ss_media/pages/home.dart';
import 'package:ss_media/widgets/progress.dart';
import 'package:ss_media/models/user.dart';


class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  Future<QuerySnapshot> searchResultFuture; 

   handleSearch(String val) {
    // Future<QuerySnapshot> users = userRef.where('displayname', isGreaterThanOrEqualTo: val).get();
    setState(() {
      searchResultFuture =  FirebaseFirestore.instance.collection('user').where('displayname', isGreaterThanOrEqualTo: val).get(); 
    });
  }

  AppBar buildSearchField() {
    return AppBar(
      backgroundColor: Colors.white,
      title: TextFormField(
        controller: searchController,
         decoration: InputDecoration(
           hintText: 'Search for a User...',
           filled: true,
           prefixIcon: Icon(
             Icons.account_box,
             size: 28.0,
           ),
           suffixIcon: IconButton(
             icon: Icon(Icons.clear), 
             onPressed: () => searchController.clear(),
            ),
         ),
         onFieldSubmitted: handleSearch,
      ),
    );
  }

  Container buildNoContent() {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      height: double.infinity,
      child: Center(
        child: ListView(
           children: [

             SvgPicture.asset(
               'assets/images/search.svg',
               height: orientation == Orientation.portrait ? 300.0: 200.0,
             ),

             Text(
               'Find Users',
               textAlign: TextAlign.center,
               style: TextStyle(
                 color: Colors.white,
                 fontSize: 60.0,
                 fontWeight: FontWeight.w600,
                 fontStyle: FontStyle.italic,
               ),
             )

           ],
        ),
      ),
    );
  }

  buildSearchResult() {
    FutureBuilder(
      future: searchResultFuture,
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return circularProgress();
        } else {
          print('sush');
          List<Text> searchResult = [];
          snapshot.data.docs.forEach((doc) {
            User user = User.fromDocument(doc);
            print(user);
            print('lol');
            searchResult.add(Text(user.username));
          });
          return ListView(
            children: searchResult,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
      appBar: buildSearchField(),
      body: searchResultFuture == null ? buildNoContent() : buildSearchResult(),
    );
  }
}

class UserResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("User Result");
  }
}

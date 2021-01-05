import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String username;
  final String email;
  final String photoUrl;
  final String displayName;
  final String bio;

  User({
    this.id,
    this.username,
    this.email,
    this.photoUrl,
    this.displayName,
    this.bio
  });

  factory User.fromDocument(DocumentSnapshot document) {
    return User(
      id: document['id'],
      email: document['email'],
      username: document['username'],
      photoUrl: document['photoUrl'],
      bio: document['bio'],
      displayName: document['displayName'],
    );
  }
}
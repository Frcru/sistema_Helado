// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:system_delivery/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginController extends ChangeNotifier {
  String _email = '', _password = '';
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;
  String get email => _email;
  String get password => _password;
  // LoginController() {
  //   print("this.hasCode ${hashCode}");
  // }
  void onEmailChanged(String text) {
    _email = text;
    notifyListeners();
  }

  void onPasswordChanged(String text) {
    _password = text;
    notifyListeners();
  }

  void submit() {
    print('email $email');
    print('password $password');
  }
}

FirebaseFirestore db = FirebaseFirestore.instance;

// getLogeo() async {
// //Letura de datos
//   List pe = [];
//   CollectionReference collectionReference = db.collection('tipo_usuarios');
//   QuerySnapshot querySnapshot = await collectionReference.get();
//   querySnapshot.docs.forEach((element) {
//     Query query = db.where()
//     pe.(element.data());
//   });
//   Future.delayed(const Duration(seconds: 5));
//   return pe;
// }

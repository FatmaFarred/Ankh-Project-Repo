import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/user_model.dart';
@singleton
class FireBaseUtilies {






  static Future <MyUser?> readUserFromFireStore (String id)async{
    var querySnapshot=await createUserCollection().doc(id).get();
    return querySnapshot.data();

  }
  static CollectionReference <MyUser>createUserCollection()   {
    return FirebaseFirestore.instance.collection(MyUser.collectionName).withConverter<MyUser>(
        fromFirestore: (snapshot,options)=>MyUser.fromFireStore(snapshot.data()!),
        toFirestore: (myuser,options)=>myuser.toFireStore());

  }
  static Future<void>   addUser(MyUser myuser){
    return createUserCollection().doc(myuser.uid).set(myuser);

  }







}
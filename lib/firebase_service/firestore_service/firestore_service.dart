import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/user_model.dart';

@singleton
class FireBaseUtilies {
  static Future<MyUser?> readUserFromFireStore(String id) async {
    var querySnapshot = await createUserCollection().doc(id).get();
    return querySnapshot.data();
  }

  static CollectionReference<MyUser> createUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFireStore(snapshot.data()!),
          toFirestore: (myuser, options) => myuser.toFireStore(),
        );
  }

  static Future<void> addUser(MyUser myuser) {
    return createUserCollection().doc(myuser.uid).set(myuser);
  }

  static Future<void> addDeviceTokenToUser(String uid, String token) async {
    await createUserCollection().doc(uid).update({
      'deviceTokens': FieldValue.arrayUnion([token]),
    });
  }

  static Future<List<String>> getDeviceToken(String uid) async {
    try {
      final docSnapshot = await createUserCollection().doc(uid).get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        print(" Document ID: ${docSnapshot.id}");
        print(" Raw Firestore data: $data");

        final tokens = data?.deviceTokens ?? [];
       // final allTokens = tokens.map((e) => e.toString()).toList();

        print("📱 Device Tokens: $tokens");
        return tokens;
      } else {
        print("⚠️ User document not found for uid: $uid");
        return [];
      }
    } catch (e) {
      print("❌ Error getting device tokens: $e");
      return [];
    }
  }
  static Future<void> removeDeviceTokenFromUser(
    String uid,
    String token,
  ) async {
    await createUserCollection().doc(uid).update({
      'deviceTokens': FieldValue.arrayRemove([token]),
    });
  }
}

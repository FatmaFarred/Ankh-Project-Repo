import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/authentication_response_dm.dart';
import '../../data/models/user_model.dart';

@singleton
class FireBaseUtilies {
  static Future<UserDm?> readUserFromFireStore(String id) async {
    var querySnapshot = await createUserCollection().doc(id).get();
    return querySnapshot.data();
  }

  static CollectionReference<UserDm> createUserCollection() {
    return FirebaseFirestore.instance
        .collection("users") // Use a standard collection name
        .withConverter<UserDm>(
          fromFirestore: (snapshot, options) =>
              UserDm.fromJson(snapshot.data()!),
          toFirestore: (myuser, options) => myuser.toFirestore(),
        );
  }

  static Future<void> addUser(UserDm myuser) {
    return createUserCollection().doc(myuser.id).set(myuser);
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

class MyUser {
  static String collectionName = "MyUser";

  String? name;
  String? email;
  String? uid;
  List<String> deviceTokens;

  MyUser({
    required this.name,
    required this.email,
    required this.uid,
    required this.deviceTokens,
  });

  MyUser.fromFireStore(Map<String, dynamic> dataMap)
    : this(
        name: dataMap["name"] ?? 'Unknown',
        email: dataMap["email"] ?? '',
        uid: dataMap["uid"] ?? '',
        deviceTokens: List<String>.from(dataMap["deviceTokens"] ?? []),
      );

  Map<String, dynamic> toFireStore() {
    return {
      "name": name,
      "email": email,
      "uid": uid,
      "deviceTokens": deviceTokens,
    };
  }
}

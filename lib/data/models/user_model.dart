
  class MyUser {
  static String collectionName = "MyUser";

  String? name;
  String? email;
  String? uid;
  String? deviceToken;




  MyUser({
  required this.name,
  required this.email,
  required this.uid,
    required this.deviceToken,
  });

  MyUser.fromFireStore(Map<String, dynamic> dataMap)
      : this(
  name: dataMap["name"] ?? 'Unknown',
  email: dataMap["email"] ?? '',
      uid: dataMap["uid"] ?? '',
      deviceToken: dataMap["deviceToken"] ?? '',
  );

  Map<String, dynamic> toFireStore() {
  return {
  "name": name,
  "email": email,
  "uid": uid, "deviceToken":deviceToken,

  };
  }
  }

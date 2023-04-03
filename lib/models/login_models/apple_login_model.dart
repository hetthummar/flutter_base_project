class AppleLoginModel {
  String? displayName;
  String? email;
  String appleLoginId;
  String firebaseId;
  String? photoUrl;

  AppleLoginModel(
      {required this.displayName,
      required this.email,
      required this.appleLoginId,
      required this.firebaseId,
      required this.photoUrl});
}

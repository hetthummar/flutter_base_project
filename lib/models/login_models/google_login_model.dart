class GoogleLoginModel {
  String displayName;
  String email;
  String googleLoginId;
  String firebaseId;
  String photoUrl;

  GoogleLoginModel(
      {required this.displayName,
      required this.email,
      required this.googleLoginId,
      required this.firebaseId,
      required this.photoUrl});
}

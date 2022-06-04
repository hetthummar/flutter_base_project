class FacebookLoginModel {
  String displayName;
  String? email;
  String facebookLoginId;
  String firebaseId;
  String? photoUrl;

  FacebookLoginModel(
      {required this.displayName,
        required this.email,
        required this.facebookLoginId,
        required this.firebaseId,
        required this.photoUrl});
}

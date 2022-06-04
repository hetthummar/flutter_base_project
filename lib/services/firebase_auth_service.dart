import 'dart:convert';
import 'dart:math';

import 'package:baseproject/models/login_models/apple_login_model.dart';
import 'package:baseproject/models/login_models/facebook_login_model.dart';
import 'package:baseproject/models/login_models/google_login_model.dart';
import 'package:baseproject/utils/api_utils/boolean_result/boolean_result.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String> signInWithOTP(smsCode, verId) async {
    AuthCredential authCred =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    String signInResponse = await signIn(authCred);
    return signInResponse;
  }

  resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<String> signIn(AuthCredential authCred) async {
    String returnResult = "error";
    try {
      UserCredential authRes = await _auth.signInWithCredential(authCred);

      User? _user = authRes.user;
      if (_user != null) {
        returnResult = "noError";
      }

      return returnResult;
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<BooleanResult<GoogleLoginModel>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await _auth.signInWithCredential(credential);
        User _user = (_auth.currentUser)!;

        GoogleLoginModel _googleLoginModel = GoogleLoginModel(
            email: googleSignInAccount.email,
            firebaseId: _user.uid,
            photoUrl: _user.photoURL.toString(),
            googleLoginId: googleSignInAccount.id,
            displayName: googleSignInAccount.displayName.toString());

        return BooleanResult.success(data: _googleLoginModel);
      } else {
        return const BooleanResult.failure(error: "No Account Selected");
      }
    } catch (e) {
      return const BooleanResult.failure(error: "Some problem occurred");
    }
  }

  Future<BooleanResult<FacebookLoginModel>> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      // final userData = FacebookAuth.instance.getUserData();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      await _auth.signInWithCredential(facebookAuthCredential);

      User _user = (_auth.currentUser)!;

      FacebookLoginModel _facebookLoginModel = FacebookLoginModel(
          email: _user.email,
          firebaseId: _user.uid,
          photoUrl: _user.photoURL.toString(),
          facebookLoginId: loginResult.accessToken!.userId.toString(),
          displayName: _user.displayName.toString());

      return BooleanResult.success(data: _facebookLoginModel);
    } catch (e) {
      return const BooleanResult.failure(error: "Some problem occurred");
    }
  }

  Future<BooleanResult<AppleLoginModel>> signInWithApple(
      {List<Scope> scopes = const [Scope.email, Scope.fullName]}) async {
    try {
      AuthorizationResult result = await TheAppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)],
      );

      switch (result.status) {
        case AuthorizationStatus.authorized:
          final appleIdCredential = result.credential!;
          final oAuthProvider = OAuthProvider('apple.com');
          final credential = oAuthProvider.credential(
            idToken: String.fromCharCodes(appleIdCredential.identityToken!),
            accessToken:
                String.fromCharCodes(appleIdCredential.authorizationCode!),
          );
          final userCredential = await _auth.signInWithCredential(credential);

          String? displayName;
          if (scopes.contains(Scope.fullName)) {
            final fullName = appleIdCredential.fullName;
            if (fullName != null &&
                fullName.givenName != null &&
                fullName.familyName != null) {
              displayName = '${fullName.givenName} ${fullName.familyName}';
            }
          }

          AppleLoginModel _appleLoginModel = AppleLoginModel(
              email: appleIdCredential.email,
              appleLoginId:
                  String.fromCharCodes(appleIdCredential.identityToken!),
              displayName: displayName,
              firebaseId: userCredential.user!.uid,
              photoUrl: null);

          return BooleanResult.success(data: _appleLoginModel);
        case AuthorizationStatus.error:
          // result.error ??
          return const BooleanResult.failure(error: "Some problem occurred");
        case AuthorizationStatus.cancelled:
          return const BooleanResult.failure(error: "No Account Selected");
        default:
          return const BooleanResult.failure(error: "Some problem occurred");
      }
    } catch (e) {
      return const BooleanResult.failure(error: "Some problem occurred");
    }
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<bool> logOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    // await FacebookAuth.instance.logOut();
    return true;
  }

  Future<String?> getUserid() async {
    User? user = _auth.currentUser;
    if (user == null) return null;
    return user.uid;
  }

  Future<String?> getIdToken() async {
    User? user = _auth.currentUser;
    if (user == null) return null;
    return user.getIdToken();
    // return user.uid;
  }

  Future<String?> getUserName() async {
    User? user = _auth.currentUser;
    if (user == null) return null;
    return user.displayName;
  }

  Future<bool> isUserLoggedIn() async {
    String? userId = await getUserid();
    if (userId == null) return false;
    return true;
  }

  Future<User?> getCurrentUser() async {
    User? user = _auth.currentUser;
    return user;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential? result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User? user = result.user;
      if (user == null) {
        return "No User Found";
      } else {
        return "Success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return "Incorrect email or password. Please try again or create a free account.";
      }
      return e.message.toString();
    }
  }

  Future<String> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential? result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User? user = result.user;
      if (user == null) {
        return "Authentication problem please try again";
      } else {
        return "Success";
      }
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }
}

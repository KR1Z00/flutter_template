import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_template/app/model/app_error.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../app/model/user_model.dart';

/// The repository that handles the logic for user authentication
class AuthRepository {
  /// A [ValueListenable] that emits the [UserModel] containing the local
  /// user's information
  ValueNotifier<LocalUserModel?> localUser = ValueNotifier(null);

  /// The database collection containing the users
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');

  DocumentReference? get localUserDocumentReference => localUser.value != null
      ? _usersCollectionReference.doc(localUser.value!.uid)
      : null;

  AuthRepository._init();
  static AuthRepository instance = AuthRepository._init();

  /// Automatically signs the user in if their auth state has persisted between
  /// app sessions
  Future<void> autoSignInIfApplicable() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        await _loadDataForUid(currentUser.uid);
      } catch (_) {
        return;
      }
    }
  }

  /// Signs the user in with the given [email] and [password]
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    final userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
        .onError(
          (error, stackTrace) => throw error ?? AppError.signInError,
        );

    if (userCredential.user == null) {
      throw AppError.signInError;
    }

    await _loadDataForUid(userCredential.user!.uid);
    return userCredential;
  }

  /// Signs the user out
  Future<void> signOut() async {
    localUser.value = null;
    await FirebaseAuth.instance.signOut();
  }

  /// Loads the user's data from their uid
  Future<void> _loadDataForUid(String uid) async {
    // Load the user's data from the database
    final userDocumentSnapshot = await _usersCollectionReference.doc(uid).get();

    // Emit the local user model
    localUser.value = LocalUserModel.fromDatabaseDocument(userDocumentSnapshot);

    // Emit the local user's group model, if applicable
    if (localUser.value?.groupDocument != null) {}
  }

  /// Sends a password reset email to the given [email] address
  Future<void> sendPasswordResetEmail({required String email}) {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  /// Registers a new user with the given [email], [password], [name], and
  /// [phoneNumber]
  Future<UserCredential> registerNewUser({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
  }) async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user == null) {
      throw AppError.registrationError;
    }

    await _usersCollectionReference.doc(credential.user!.uid).set({
      "name": name,
      "email": email,
      "phone_number": phoneNumber,
    }).onError(
      (error, stackTrace) => debugPrint(
        "An error occurred writing user details: $error",
      ),
    );

    return credential;
  }

  Future<void> requestAndStoreUserNotificationToken() async {
    if (localUser.value == null) {
      return;
    }

    final userHasAllowedNotificationPermissions =
        await Permission.notification.status.isGranted;
    if (!userHasAllowedNotificationPermissions) {
      return;
    }

    final token = await FirebaseMessaging.instance.getToken();

    if (token != null) {
      localUserDocumentReference?.set({
        "fcm_token": token,
      }, SetOptions(merge: true));
    }
  }
}

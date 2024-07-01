import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

const _emulatorHost = 'localhost';
const _firestoreEmulatorPort = 8080;
const _functionsEmulatorPort = 5001;
const _authenticationEmulatorPort = 9099;

/// Sets up the Firebase Emulators for Firestore and Auth
///
/// This function requires the Firestore and Auth emulators to be running on
/// `localhost` at port `8080`.
///
/// This function should be called before any Firebase services are used
/// in the integration tests.
///
/// This function should be called in the `setUpAll` function of the test file.
void setupFirebaseEmulators({
  String host = _emulatorHost,
  int firestorePort = _firestoreEmulatorPort,
  int functionsPort = _functionsEmulatorPort,
  int authPort = _authenticationEmulatorPort,
}) {
  FirebaseFirestore.instance.useFirestoreEmulator(host, firestorePort);
  FirebaseFunctions.instance.useFunctionsEmulator(host, functionsPort);
  FirebaseAuth.instance.useAuthEmulator(host, authPort);
}

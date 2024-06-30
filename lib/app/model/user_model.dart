import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_template/app/extensions/functional_extensions.dart';

abstract class UserModel extends Equatable {
  final String uid;
  final String email;
  final String name;
  final String phoneNumber;

  const UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [
        uid,
        email,
        name,
        phoneNumber,
      ];
}

class LocalUserModel extends UserModel {
  /// The [DocumentReference] for the group the user belongs to
  final DocumentReference? groupDocument;

  const LocalUserModel({
    required super.uid,
    required super.email,
    required super.name,
    required super.phoneNumber,
    this.groupDocument,
  });

  LocalUserModel copyWith({
    String? email,
    String? name,
    String? phoneNumber,
    DocumentReference? groupDocument,
    bool clearDocumentReference = false,
  }) {
    return LocalUserModel(
      uid: uid,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      groupDocument:
          clearDocumentReference ? null : groupDocument ?? this.groupDocument,
    );
  }

  static LocalUserModel? fromDatabaseDocument(
    DocumentSnapshot document,
  ) {
    final email = (document.get('email') as Object).castOrNull<String>();
    final name = (document.get('name') as Object).castOrNull<String>();
    final phoneNumber =
        (document.get('phone_number') as Object).castOrNull<String>();

    // Try and load the group id for the user if it exists
    DocumentReference? groupDocument;
    try {
      groupDocument =
          (document.get('group') as Object).castOrNull<DocumentReference>();
    } catch (error) {
      groupDocument = null;
    }

    if (email == null || name == null || phoneNumber == null) {
      return null;
    }

    return LocalUserModel(
      uid: document.id,
      email: email,
      name: name,
      phoneNumber: phoneNumber,
      groupDocument: groupDocument,
    );
  }

  @override
  List<Object?> get props =>
      super.props +
      [
        phoneNumber,
        groupDocument,
      ];
}

class RemoteUserModel extends UserModel {
  const RemoteUserModel({
    required super.uid,
    required super.email,
    required super.name,
    required super.phoneNumber,
  });

  static RemoteUserModel? fromDatabaseDocument(
    DocumentSnapshot document,
  ) {
    final email = (document.get('email') as Object).castOrNull<String>();
    final name = (document.get('name') as Object).castOrNull<String>();
    final phoneNumber =
        (document.get('phone_number') as Object).castOrNull<String>();

    if (email == null || name == null || phoneNumber == null) {
      return null;
    }

    return RemoteUserModel(
      uid: document.id,
      email: email,
      name: name,
      phoneNumber: phoneNumber,
    );
  }
}

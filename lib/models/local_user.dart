// To parse this JSON data, do
//
//     final localUser = localUserFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LocalUser localUserFromJson(String str) => LocalUser.fromJson(json.decode(str));

// _TypeError (type '(dynamic) => LocalUser' is not a subtype of type '(String, dynamic) => MapEntry<dynamic, dynamic>' of 'transform') fixed by adding @required to LocalUser constructor
List<LocalUser> localUsersFromJson(String str) => List<LocalUser>.from(json.decode(str).map((x) => LocalUser.fromJson(x)));

String localUserToJson(LocalUser data) => json.encode(data.toJson());

class LocalUser {
    LocalUser({
        @required this.displayName,
        @required this.email,
        @required this.emailVerified,
        @required this.isAnonymous,
        @required this.phoneNumber,
        @required this.photoUrl,
        @required this.refreshToken,
        @required this.tenantId,
        @required this.uid,
    });

    final String? displayName;
    final String? email;
    final bool? emailVerified;
    final String? isAnonymous;
    final String? phoneNumber;
    final String? photoUrl;
    final String? refreshToken;
    final String? tenantId;
    final String? uid;

    factory LocalUser.fromJson(Map<String, dynamic> json) => LocalUser(
        displayName: json["displayName"] == null ? null : json["displayName"],
        email: json["email"] == null ? null : json["email"],
        // bool? emailVerified,
        emailVerified: json["emailVerified"] == null ? false : json["emailVerified"] as bool,
        isAnonymous: json["isAnonymous"] == null ? null : json["isAnonymous"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        photoUrl: json["photoURL"] == null ? null : json["photoURL"],
        refreshToken: json["refreshToken"] == null ? null : json["refreshToken"],
        tenantId: json["tenantId"] == null ? null : json["tenantId"],
        uid: json["localId"] == null ? null : json["localId"],
    );

    Map<String, dynamic> toJson() => {
        "displayName": displayName == null ? null : displayName,
        "email": email == null ? null : email,
        "emailVerified": emailVerified == null ? null : emailVerified,
        "isAnonymous": isAnonymous == null ? null : isAnonymous,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "photoURL": photoUrl == null ? null : photoUrl,
        "refreshToken": refreshToken == null ? null : refreshToken,
        "tenantId": tenantId == null ? null : tenantId,
        "uid": uid == null ? null : uid,
    };
}

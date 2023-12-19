import 'dart:convert';

import 'package:firebase_admin/firebase_admin.dart';
import 'package:motah/models/local_user.dart';
import 'package:http/http.dart' as http;

import '../const.dart';

class FirebaseAuthAdminService {
  static final FirebaseAuthAdminService _instance =
      FirebaseAuthAdminService._internal();

  factory FirebaseAuthAdminService() => _instance;

  FirebaseAuthAdminService._internal();

  String url = URL;

// http get request to http://localhost:3000
  Future<List<LocalUser>> getAllUsers() async {
    final getAllUsers =
        await http.get(Uri.parse(url));
    print(getAllUsers.statusCode);
    if (getAllUsers.statusCode == 200) {
      final List<LocalUser> users = localUsersFromJson(getAllUsers.body);
      // remove user if not has email attribute
      users.removeWhere((element) => element.email == null);
      return users;
    } else {
      return Future.error('Error: ${getAllUsers.statusCode}');
    }
  }

  // delete method firebase admin api
  Future<bool> deleteUser(String uid) async {
    final getAllUsers = await http
        .delete(Uri.parse(url), body: jsonEncode({'uid': uid}), headers: {'Content-Type': 'application/json; charset=UTF-8'});
    print(getAllUsers.statusCode);
    if (getAllUsers.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // create method firebase admin api
  Future<bool> createUser(
      String email, String password, String displayName) async {
    final createNewUser = await http.post(
        Uri.parse(url),
        headers:
            // content type
            {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          "displayName": displayName
        }));
    print(createNewUser.statusCode);
    if (createNewUser.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // update user method firebase admin api
  Future<bool> updateUser({String? uid, String? displayName, String? email}) async {
    final updateNewUser = await http.put(
        Uri.parse(url),
        headers:
            // content type
            {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'uid': uid,
          'displayName': displayName,
          'email': email,
        }));
    print(updateNewUser.statusCode);
    if (updateNewUser.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
// CRUD
// C -> Create -> POST
// R -> Read -> GET
// U -> Update -> PUT
// D -> Delete -> DELETE
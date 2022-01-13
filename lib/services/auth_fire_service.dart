import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthFirebaseService extends ChangeNotifier {
  //poner sus credenciales de firebase:
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyBfRJwvkSCykmXQUKYHcnROBmk-IT5wZzk';

  final secureStorage = const FlutterSecureStorage();

  Future<String?> createUser(String email, String password) async {
    final bodyData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {
      'key': _firebaseToken,
    });

    final resp = await http.post(url, body: json.encode(bodyData));
    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if (decodedData.containsKey('idToken')) {
      secureStorage.write(key: 'token', value: decodedData['idToken']);
      return null;
    } else {
      return decodedData['error']['message'];
    }
  }

  Future loginUser(String email, String password) async {
    final bodyData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {
      'key': _firebaseToken,
    });

    final resp = await http.post(url, body: json.encode(bodyData));
    final Map<String, dynamic> decodedData = json.decode(resp.body);

    if (decodedData.containsKey('idToken')) {
      secureStorage.write(key: 'token', value: decodedData['idToken']);
      return null;
    } else {
      return decodedData['error']['message'];
    }
  }

  Future logout() async {
    await secureStorage.delete(key: 'token');
    return null;
  }

  Future<String> readToken() async {
    return await secureStorage.read(key: 'token') ?? 'no-token';
  }
}
// documentation : https://firebase.google.com/docs/reference/rest/auth#section-create-email-password//
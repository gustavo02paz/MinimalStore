import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";

//criar uma classe para gerenciar o estado de autenticação
class UserProvider extends ChangeNotifier {
  User? _user;

  UserProvider() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  //metodo para verificar se o usuario esta autenticado
  bool get isAuthenticated => _user != null;

  //metodo para acessar os dados do usuario autenticado
  User? get user => _user;

  //função para deslogar o usuario
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
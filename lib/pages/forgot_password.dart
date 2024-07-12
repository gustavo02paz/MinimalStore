import 'dart:async';

import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/material.dart';
import '../components/login_button.dart';
import '../components/my_text_field.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emaicontroller = TextEditingController();

  @override
  void despose(){
    _emaicontroller.dispose();
    super.dispose;
  }

  Future passwordReset ()  async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emaicontroller.text.trim());
      showDialog(
        context: context,
         builder: (context) {
          return const AlertDialog(
            content: Text(" foi enviado um link para redefinicao de senha! De um olhada no seu e-mail"),
          );
          });
        } on FirebaseAuthException catch (e) {
          showDialog(
            context: context,
          builder: (context){
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
        }
      }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Redefinição de senha"),
      ),
      body: Column(
       mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Text("insira se e-mail para receber o link de redefinicao de senha",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).colorScheme.inversePrimary
        ))
      ),
      const SizedBox(height: 25),
      const SizedBox(height: 10),
      MyTextField(
        controller: _emaicontroller, 
        hintText: "e-mail", 
        obscureText:  false),
        const SizedBox(height: 25),
      LoginButton(onTap: () {}, text: "Redefinir Senha")
      ]
    )
  );
  }
}
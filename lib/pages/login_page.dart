import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:minimalstore/components/my_text_field.dart";
import "package:minimalstore/components/square_tile.dart";
import "package:minimalstore/pages/forgot_password.dart";
import "package:minimalstore/pages/shop_page.dart";

import '../components/login_button.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserIn() async {
    showDialog(
      context: context,
       builder: (context) {
        return const Center(child: CircularProgressIndicator());       });

       try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text);
          Navigator.pop(context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ShopPage()));
       }on FirebaseException catch (e) {
        Navigator.pop(context);
        showErroMessage(e.code);
       }
  }

  void showErroMessage(String message){
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: Text(message),
        );
      } );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Login"),
            backgroundColor: Colors.transparent,
            elevation: 0),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 50),

            //logo
            const Icon(Icons.lock, size: 100),

            const SizedBox(height: 50),

            //texto de boas vindas
            Text(
              "Que bom que você voltou!",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 16),
            ),
            const SizedBox(height: 25),

            MyTextField(
                controller: emailController,
                hintText: "e-mail",
                obscureText: false),

            const SizedBox(height: 10),

            MyTextField(
                controller: passwordController,
                hintText: "Senha", 
                obscureText: true),
            const SizedBox(height: 10),

            // esqueceu a senha
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                     return ForgotPasswordPage();
                    }));
                    },
                    child: Text("Esqueceu a senha?",
                        style: TextStyle(color: Colors.grey.shade600)),
                  )
                ])),
            const SizedBox(height: 25),

            LoginButton(onTap: signUserIn, text: "Entrar"),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness:  0.5,
                      color: Colors.grey[400]
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text("ou",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary
                      ))),
                    Expanded  (
                    child: Divider(
                      thickness:  0.5,
                      color: Colors.grey[400]
                    ))
    ],
    )),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(imagePath: "https://firebasestorage.googleapis.com/v0/b/erud-e0100.appspot.com/o/WhatsApp%20Image%202024-06-05%20at%2009.37.16%20(1).jpeg?alt=media&token=ba7eb268-5e03-4319-93ab-cedd2bef1841",
                     onTap: () {}),
                    const SizedBox(width: 25),
                    SquareTile(
                      imagePath:
                     "https://firebasestorage.googleapis.com/v0/b/erud-e0100.appspot.com/o/WhatsApp%20Image%202024-06-05%20at%2009.37.16.jpeg?alt=media&token=d2136f19-0c06-4ec8-b852-41a1daa9edf5",
                      onTap: () {})
                  ]),
                  const SizedBox(height: 50),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ainda nao possui conta?",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary
                          )
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {} ,
                          child: const Text(
                            "Registre-se",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold
                            ),
                          ) ,
                        )
                      ]
                    ) 

                  )
          ]),
        ))));
  }
}

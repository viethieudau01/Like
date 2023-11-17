import 'package:example/Sendmail.dart';
import 'package:example/random_words.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Form button',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ))),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Container(
                  width: 70,
                  height: 70,
                  padding: EdgeInsets.all(20),

                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: FlutterLogo(),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
              child: Text("Form Login",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
              child: TextField(
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: "Username",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: <Widget>[
                  TextField(
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      )),
                  Text(
                    'show',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: (){
                    onSignIn();
                    usernameController.clear();
                    passwordController.clear();
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RandomWords())
                 );},
                  child: Text(
                    "Sign in",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    primary: Colors.blue,
                  ),
                ),
              ),
            ),
            Container(
              height: 100,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "New user ?sign up",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey
                    ),
                  ),
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future onSignIn() async {
    try{
      final response = await http.post(Uri.parse('https://test-space.hirogo.net/api/auth/login'),
        body:{
          "email": usernameController.value.text,
          "password": passwordController.value.text,
        },
      );
      if(response.statusCode == 200){
        print(response.body);
      }else {
        print('failed');
      }
    }catch(e){
      print(e.toString());
    }

  }
}

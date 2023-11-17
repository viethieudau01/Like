import 'package:example/random_words.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController messageController = TextEditingController();

class Sendmail extends StatelessWidget {
  const Sendmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Email',
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
                    color: Colors.black,
                  ),
                  child: FlutterLogo(),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: Text("Send mail",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: <Widget>[
                  TextFormField(
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        labelText: "Your name",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: <Widget>[
                  TextFormField(
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        labelText: "Email address",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: <Widget>[
                  TextFormField(
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Message',
                        labelText: "Message",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    sendmail();
                    nameController.clear();
                    emailController.clear();
                    messageController.clear();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RandomWords()));
                  },
                  child: Text(
                    "Send Email",
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
          ],
        ),
      ),
    );
  }

  Future sendmail() async {
    try {
      final http.Response response = await http.post(
        Uri.parse('https://test-space.hirogo.net/api/auth/login'),
        body: {
          "email": "ngokaka90@gmail.com",
          "password": "ngokaka90@gmail.com",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data1 = jsonDecode(response.body);
        print(response.body);
        final token = data1['data']['access_token'];
        String url =
            'https://test-space.hirogo.net/api/mypage/contact/sendmail';
        Map<String, String> headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        };
        var body = json.encode({
          "email": emailController.value.text,
          "name": nameController.value.text,
          "content": messageController.value.text
        });
        var apiResult = await http.post(
          Uri.parse(url),
          headers: headers,
          body: body,
        );
        var jsonObject = json.decode(apiResult.body);
        if (apiResult.statusCode != 200) {
          print('fail');
          return jsonObject; // you can mapping json object also here
        } else {
          print('successfully');
          return jsonObject; // you can mapping json object also here
        }
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

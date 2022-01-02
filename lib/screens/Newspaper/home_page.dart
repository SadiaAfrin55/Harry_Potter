import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Newspaper_home extends StatefulWidget {
  _Newspaper_homeState createState() => _Newspaper_homeState();
}

class _Newspaper_homeState extends State<Newspaper_home> {
  List postData;
  Future getPost() async {
    String ServiceUrl = "https://jsonplaceholder.typicode.com/comments";
    var response = await http.get(Uri.parse(ServiceUrl));
    if (response.statusCode == 200) {
      setState(() {
        postData = json.decode(response.body.toString());
      });
    }
  }

  @override
  void initState() {
    this.getPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("newspaper"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: ListView.builder(
                  itemCount: postData.length == null ? 0 : postData.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: Image.asset("assets/person.png")),
                        SizedBox(width: 30),
                        Expanded(
                          flex: 10,
                          child: Column(
                            children: [
                              Text(postData[index]["name"]),
                              Text(postData[index]["email"]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

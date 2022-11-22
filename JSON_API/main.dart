import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<String>> data = [];
  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
        appBar: AppBar(
          title: Text("Reqres App"),
        ),
        body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, int index) {
              return Card(
                child: ListTile(
                  title: Text(data[index][0]),
                  subtitle: Text(data[index][1]),
                ),
              );
            })
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  void getData() async {
    var url = Uri.parse("https://reqres.in/api/users");
    var response = await http.get(url);
    var parsed = jsonDecode(response.body);
    var data1 = parsed["data"];
    setState(() {
      for (int i = 0; i < parsed.length; i++) {
        data.add([data1[i]["first_name"], data1[i]["email"]]);
      }
    });
  }
}

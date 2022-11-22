import 'package:flutter/material.dart';

void main() {
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
      home: MyHomePage(title: 'Colour Selection'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  TextEditingController colorController = TextEditingController();
  var containerColor = Colors.white;
  var backgroundColor = {
    "amber": Colors.amber,
    "black": Colors.black,
    "blue": Colors.blue,
    "brown": Colors.brown,
    "cyan": Colors.cyan,
    "green": Colors.green,
    "grey": Colors.grey,
    "indigo": Colors.indigo,
    "orange": Colors.orange,
    "pink": Colors.pink,
    "purple": Colors.purple,
    "red": Colors.red,
    "teal": Colors.teal,
    "white": Colors.white,
    "yellow": Colors.yellow
  };

  void setColor(String color, BuildContext context) {
    if (backgroundColor.containsKey(color)) {
      setState(() {
        containerColor = backgroundColor[color]!;
      });
    } else {
      showSnackBar("Color not found...!", context);
    }
  }

  void showSnackBar(String message, BuildContext context) {
    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          alignment: Alignment.topLeft,
          color: containerColor,
          height: 800,
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                controller: colorController,
              )),
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      setColor(colorController.text, context);
                    },
                    child: Text("Select")),
              )
            ],
          ),
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

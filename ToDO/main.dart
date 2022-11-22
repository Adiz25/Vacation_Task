import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  List<String> todo = [];
  var _todoController = TextEditingController();

  Widget build(BuildContext context) {
    getData();
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: Column(
          children: [
            Row(
              children: [
                SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _todoController,
                    )),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            todo.add(_todoController.text);
                            _todoController.text = "";
                            saveData(todo);
                          });
                        },
                        child: Text("Add")))
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: todo.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text(todo[index]),
                        trailing: GestureDetector(
                            onTap: () {
                              setState(() {
                                todo.removeAt(index);
                                saveData(todo);
                              });
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ),
                    );
                  }),
            )
          ],
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  void saveData(List<String> todos) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setStringList("todo", todos);
  }

  void getData() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("todo")) {
      setState(() {
        todo = prefs.getStringList("todo")!;
      });
    }
  }
}

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
  var _cityController = TextEditingController();
  String cityName = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Weather"),
        ),
        body: Column(
          children: [
            Row(
              children: [
                SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _cityController,
                    )),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            cityName = _cityController.text;
                            _cityController.text = "";
                          });
                        },
                        child: Text("Get")))
              ],
            ),
            Expanded(
                child: FutureBuilder(
                    future: getWeather(cityName),
                    builder: (context,
                        AsyncSnapshot<Map<String, String>> weatherData) {
                      var data = weatherData.requireData;
                      if (data.containsKey("message")) {
                        return Container(child: Text(data["message"]!));
                      }
                      return Container(
                        child: Column(
                          children: [
                            Text("City Name           :  " + data["cityName"]!),
                            Text("Main Weather        :  " +
                                data["weatherMain"]!),
                            Text("Weather Description :  " +
                                data["weatherDesc"]!),
                            Text("Temperature         :  " +
                                data["temperature"]!),
                            Text("Pressure            :  " + data["pressure"]!),
                            Text("Humidity            :  " + data["humidity"]!),
                            Text(
                                "Wind Speed          :  " + data["windSpeed"]!),
                            Text("Wind Degree         :  " +
                                data["windDegree"]!),
                          ],
                        ),
                      );
                    }))
          ],
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Future<Map<String, String>> getWeather(String cityName) async {
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=02a9025c5c1049bc06dfbfc631eab1f1");
    var response = await http.get(url);
    var parsed = jsonDecode(response.body);
    if (parsed["cod"] != 200) {
      return ({"message": parsed["message"]});
    } else {
      Map<String, String> weatherData = {
        "cityName": parsed["name"] + "\n",
        "weatherMain": parsed["weather"][0]["main"] + "\n",
        "weatherDesc": parsed["weather"][0]["description"] + "\n",
        "temperature": parsed["main"]["temp"].toString() + "\n",
        "pressure": parsed["main"]["pressure"].toString() + "\n",
        "humidity": parsed["main"]["humidity"].toString() + "\n",
        "windSpeed": parsed["wind"]["speed"].toString() + "\n",
        "windDegree": parsed["wind"]["deg"].toString() + "\n"
      };
      return (weatherData);
    }
  }
}

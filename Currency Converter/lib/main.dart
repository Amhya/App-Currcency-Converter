import 'package:currency_converter/services/api.dart';
import 'package:currency_converter/widgets/drop_down.dart';
import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [Color(0xffffb2dfdb), Color(0xff008080)],
          ),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/images/logo2.png',
                    height: 300.0,
                    width: 300.0,
                  ),
                  Text(
                    "QUIX!\n",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 32.0,
                    ),
                  ),
                  Text(
                    "your quick currency converter buddy\n",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 19.0,
                    ),
                  ),
                ],
              ),
              CircularProgressIndicator(
                color: Color(0xffffb2dfdb),
              )
            ]),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Api client = Api();

  Color mainColor = Color(0xFFFFFFFF);
  Color secondColor = Color.fromARGB(255, 12, 114, 104);

  List<String> currencies;
  String from;
  String to;

  double rate;
  String result = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    (() async {
      List<String> list = await client.getCurrencies();
      setState(() {
        currencies = list;
      });
    })();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainColor,
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150.0,
                  child: Text(
                    "QUIX",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 50.0),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 50.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Exchange Rate",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(result,
                                  style: TextStyle(
                                      color: secondColor,
                                      fontSize: 35.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        TextField(
                          onSubmitted: (value) async {
                            rate = await client.getRate(from, to);
                            setState(() {
                              result = (rate * double.parse(value))
                                  .toStringAsFixed(3);
                            });
                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "Input a value",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Color.fromARGB(255, 23, 113, 103)),
                              )),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 18.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "From:",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15.0,
                                  ),
                                ),
                                dropDown(currencies, from, (val) {
                                  setState(() {
                                    from = val;
                                  });
                                }),
                              ],
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                String temp = from;
                                setState(() {
                                  from = to;
                                  to = temp;
                                });
                              },
                              child: Icon(Icons.swap_horiz),
                              elevation: 0.0,
                              backgroundColor: secondColor,
                            ),
                            Column(
                              children: [
                                Text(
                                  "To:",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15.0,
                                  ),
                                ),
                                dropDown(currencies, to, (val) {
                                  setState(() {
                                    to = val;
                                  });
                                }),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

import 'dart:math';

import 'package:bmi_app/secondpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "BMI Calculator",
        // theme: ThemeData.dark(),
        initialRoute: '/',
        routes: {
          '/': (context) {
            return Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/back_01.jpg"),
                        fit: BoxFit.cover)),
                child: const Home());
          },
          SecondPage.route: (context) => const SecondPage()
        });
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double height = 100;
  double weight = 50;
  double bmi = 0;
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text("BMI Calculator"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 200,
              color: Colors.orangeAccent,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Height: ${height.toStringAsFixed(2)} cm"),
                    Slider(
                        value: height,
                        min: 50,
                        max: 300,
                        onChanged: (value) => {
                              setState(() => {height = value})
                            })
                  ]),
            ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator
            //   },
            // ),
            Container(
              height: 100,
              width: 200,
              color: Colors.orange,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Weight"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          // Remember to use gestured motion onTap() for same behaviourclear
                          onPressed: () => {
                            setState(() => {weight++})
                          },
                          tooltip: "Increament Weight",
                          child: const Icon(Icons.add),
                        ),
                        Text(weight.round().toString()),
                        FloatingActionButton(
                          onPressed: () => {
                            setState(() => {weight--})
                          },
                          tooltip: "Decreament Weight",
                          child: const Text("-"),
                        ),
                      ],
                    )
                  ]),
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      flag = !flag;
                      bmi = (weight) / (pow((height / 100), 2));
                    });
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => SecondPage(bmi:bmi)));
                    Navigator.pushNamed(context, SecondPage.route,
                        arguments: Arguments(bmi));
                  },
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(color: Colors.red)))),
                  child: const Text("Calculate"),
                ),
                // const SizedBox(
                //   height: 10,
                //   width: 2000,
                // ),
                Visibility(
                    visible: flag,
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Text(
                          bmi != 0 ? "     BMI: ${bmi.round().toString()}" : "",
                          style: const TextStyle(color: Colors.redAccent)),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

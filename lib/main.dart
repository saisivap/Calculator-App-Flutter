import 'package:calucator_flutter/neubutton.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:calucator_flutter/theme.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      darkTheme: Themes().darkTheme,
      theme: Themes().lightTheme,
      themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool modeIsDark = false;
  String equation = '0';
  String result = '0';
  String expression = "";

  _btnClicked(value) {
    setState(() {
      if (value == 'C') {
        result = '0';
        expression = "";
      } else if (value == "AC") {
        equation = "0";
        result = '0';
        expression = "";
      } else if (value == "=") {
        expression = equation;
        expression = expression.replaceAll('X', '*');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          equation = "${exp.evaluate(EvaluationType.REAL, cm)}";
          result = "";
        } catch (e) {
          result = "Error";
        }
      } else if (value == "<") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (value == "+/-") {
        if (result[0] == '-' && equation[0] == '-') {
          equation = equation.substring(1, equation.length);
          result = result.substring(1, result.length);
        } else {
          if (equation[0] == '-') {
            equation = equation.substring(1, equation.length);
            result = '-' + result;
          } else {
            equation = '-' + equation;
            result = '-' + result;
          }
        }
      } else {
        if (equation == '0') {
          if (value == '+' ||
              value == 'X' ||
              value == '/' ||
              value == '-' ||
              value == '%') {
            equation = '0';
          } else {
            equation = value;
          }
        } else {
          if (['X', '+', '-', '/', '%']
                  .contains(equation.substring(equation.length - 1)) &&
              ['X', '+', '-', '/', '%'].contains(value)) {
            equation = equation.substring(0, equation.length - 1) + value;
          } else {
            equation = equation + value;
            expression = equation;
            expression = expression.replaceAll('X', '*');
            try {
              Parser p = Parser();
              Expression exp = p.parse(expression);

              ContextModel cm = ContextModel();
              result = "${exp.evaluate(EvaluationType.REAL, cm)}";
              // result = "";
            } catch (e) {
              result = "";
            }
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8),
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: Get.isDarkMode
              ? LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0XFF1F2326), Color(0XFF4A4E4F)])
              : LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0XFFE8EEEE),
                    Color(0XFFFDFDFD),
                  ],
                ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                  // border: Border.all(color:Colors.grey,width: 5)
                  ),
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.2,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: size.width * 0.1,
                      ),
                      child: SingleChildScrollView(
                        child: Expanded(
                          child: Text(
                            equation,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 48,
                            ),
                          ),
                        ),
                      ),
                    ),
                    alignment: Alignment(1, 1),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.1,
                        vertical: 10,
                      ),
                      child: Expanded(
                        child: Text(
                          result,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 32,
                          ),
                        ),
                      ),
                    ),
                    alignment: Alignment(1, 1),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                width: size.width*0.8,
                child: Divider(
                  color: Colors.grey,
                  height: 10,
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Transform.scale(
                        scale: 1.5,
                        child: Switch(
                            value: modeIsDark,
                            onChanged: (value) {
                              setState(() {
                                Get.changeThemeMode(Get.isDarkMode
                                    ? ThemeMode.light
                                    : ThemeMode.dark);
                                modeIsDark = value;
                                print("Mode is Dark $value");
                              });
                            }),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NeuButton(
                      text: "C",
                      callback: _btnClicked,
                      // textColor: Colors.grey,
                      buttonColor: Colors.red.shade500,
                    ),
                    NeuButton(
                      text: "AC",
                      callback: _btnClicked,
                      // textColor: Colors.black,
                      buttonColor: Theme.of(context).colorScheme.primary,
                    ),
                    NeuButton(
                        text: "%",
                        callback: _btnClicked,
                        // textColor: Colors.black,
                        buttonColor: Theme.of(context).colorScheme.primary),
                    NeuButton(
                      text: "/",
                      // textColor: Colors.black,
                      buttonColor: Theme.of(context).colorScheme.secondary,
                      callback: _btnClicked,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NeuButton(
                      buttonColor: Theme.of(context).primaryColor,
                      text: "7",
                      callback: _btnClicked,
                    ),
                    NeuButton(
                      buttonColor: Theme.of(context).primaryColor,
                      text: "8",
                      callback: _btnClicked,
                    ),
                    NeuButton(
                      buttonColor: Theme.of(context).primaryColor,
                      text: "9",
                      callback: _btnClicked,
                    ),
                    NeuButton(
                      text: "X",
                      // textColor: Colors.black,
                      buttonColor: Theme.of(context).colorScheme.secondary,
                      callback: _btnClicked,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NeuButton(
                      buttonColor: Theme.of(context).primaryColor,
                      text: "4",
                      callback: _btnClicked,
                    ),
                    NeuButton(
                      buttonColor: Theme.of(context).primaryColor,
                      text: "5",
                      callback: _btnClicked,
                    ),
                    NeuButton(
                      text: "6",
                      buttonColor: Theme.of(context).primaryColor,
                      callback: _btnClicked,
                    ),
                    NeuButton(
                      text: "-",
                      // textColor: Colors.black,
                      buttonColor: Theme.of(context).colorScheme.secondary,
                      callback: _btnClicked,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NeuButton(
                      text: "1",
                      buttonColor: Theme.of(context).primaryColor,
                      callback: _btnClicked,
                    ),
                    NeuButton(
                      text: "2",
                      buttonColor: Theme.of(context).primaryColor,
                      callback: _btnClicked,
                    ),
                    NeuButton(
                      text: "3",
                      buttonColor: Theme.of(context).primaryColor,
                      callback: _btnClicked,
                    ),
                    NeuButton(
                      text: "+",
                      // textColor: Colors.black,
                      buttonColor: Theme.of(context).colorScheme.secondary,
                      callback: _btnClicked,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NeuButton(
                      text: "+/-",
                      callback: _btnClicked,
                      buttonColor: Theme.of(context).primaryColor,
                    ),
                    NeuButton(
                      text: "0",
                      callback: _btnClicked,
                      buttonColor: Theme.of(context).primaryColor,
                    ),
                    NeuButton(
                      text: "<",
                      callback: _btnClicked,
                      buttonColor: Theme.of(context).primaryColor,
                    ),
                    NeuButton(
                      text: "=",
                      buttonColor: Color(0XFFA67FF2),
                      callback: _btnClicked,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

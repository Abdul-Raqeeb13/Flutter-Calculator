// ignore_for_file: prefer_const_constructors

import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String inp = "0"; // ✅ Moved here to persist input
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
          
            Container(
              width: screenWidth,
              height: screenHeight * 0.350,
              color: Colors.black, // Set background color
              alignment: Alignment.bottomRight, // Align text to the right
              padding:
                  EdgeInsets.only(right: screenWidth * 0.02), // Add padding
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  inp,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.09, // Dynamic font size
                    color: Colors.white, // Better contrast
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            // Third Container (For Buttons)
            Container(
              height: screenHeight * 0.612,
              padding: EdgeInsets.only(
                  top: screenHeight * 0.01, bottom: screenHeight * 0.01),
              color: Colors.black,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: screenHeight * 0.02, bottom: screenHeight * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        specilaBtn(screenWidth, screenHeight, "AC"),
                        specilaBtn(screenWidth, screenHeight, "C"),
                        specilaBtn(screenWidth, screenHeight, "x²"),
                        operators(screenWidth, screenHeight, "/"),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        btn(screenWidth, screenHeight, "7"),
                        btn(screenWidth, screenHeight, "8"),
                        btn(screenWidth, screenHeight, "9"),
                        operators(screenWidth, screenHeight, "*"),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        btn(screenWidth, screenHeight, "4"),
                        btn(screenWidth, screenHeight, "5"),
                        btn(screenWidth, screenHeight, "6"),
                        operators(screenWidth, screenHeight, "-"),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        btn(screenWidth, screenHeight, "1"),
                        btn(screenWidth, screenHeight, "2"),
                        btn(screenWidth, screenHeight, "3"),
                        operators(screenWidth, screenHeight, "+"),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        btn(screenWidth, screenHeight, "0"),
                        btn(screenWidth, screenHeight, "00"),
                        btn(screenWidth, screenHeight, "."),
                        operators(screenWidth, screenHeight, "="),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container specilaBtn(
      double screenWidth, double screenHeight, specialOperation) {
    return Container(
      child: SizedBox(
        width: screenWidth * 0.21,
        height: screenHeight * 0.0944,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  screenWidth * 0.12), // Dynamic rounded corners
            ),
          ),
          onPressed: () {
            setState(() {
              if (specialOperation == "AC") {
                inp = "0";
              } else if (specialOperation == "C") {
                if (inp.isNotEmpty) {
                  if (inp.length > 1) {
                    setState(() {
                      inp = inp.substring(0, inp.length - 1);
                    });
                  } else {
                    inp = inp.substring(0, 0);
                    inp = "0";
                  }
                } else {
                  inp = '0';
                }
              }
              else if(specialOperation == 'x²'){
                evaluateExpression(false);

              }
               else {
                if (inp == "0") {
                } else {
                  inp += "%";
                }
              }
            });
          },
          child: Text(specialOperation,
              style: TextStyle(fontSize: screenWidth * 0.08)),
        ),
      ),
    );
  }

  Container operators(double screenWidth, double screenHeight, operator) {
    return Container(
      child: SizedBox(
        width: screenWidth * 0.21,
        height: screenHeight * 0.0944,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  screenWidth * 0.12), // Dynamic rounded corners
            ),
          ),
          onPressed: () {
            setState(() {
              if (inp == "0") {
                // Handle case where inp is just "0" or empty
              } else {
                if (operator == "=") {
                  evaluateExpression(true); // Just call the method without passing inp
                } else {
                  if (inp.isNotEmpty &&
                      (inp[inp.length - 1] == "/" ||
                          inp[inp.length - 1] == "+" ||
                          inp[inp.length - 1] == "-" ||
                          inp[inp.length - 1] == "*")) {
                    // Do nothing if the last character is an operator
                  } else {
                    setState(() {
                      
                    inp += operator; // Append operator
                    });
                  }


                }
              }
            });
          },
          child: Text(operator, style: TextStyle(fontSize: screenWidth * 0.08)),
        ),
      ),
    );
  }

  Container btn(double screenWidth, double screenHeight, value) {
    return Container(
      child: SizedBox(
        width: screenWidth * 0.21,
        height: screenHeight * 0.0944,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(149, 69, 68, 68),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  screenWidth * 0.12), // Dynamic rounded corners
            ),
          ),
          onPressed: () {
            setState(() {
              if (inp == "0") {
                inp = value; // Replace if it's the first input
              } else {
                inp += value; // Append if input already has numbers
              }
            });
          },
          child: Text(value, style: TextStyle(fontSize: screenWidth * 0.08)),
        ),
      ),
    );
  }

  void evaluateExpression(bool status) {
  try {
    // Regular expression to match numbers and operators
    RegExp regExp = RegExp(r'(\d+(\.\d+)?)|[\+\-\*/]');
    List<String> tokens = regExp.allMatches(inp).map((m) => m.group(0)!).toList();
  print(tokens);
    if (tokens.isEmpty) {
      print("Error: Invalid expression");
      return;
    }

    double result = double.parse(tokens[0]);

    for (int i = 1; i < tokens.length; i += 2) {
      if (i + 1 >= tokens.length) break; // Prevent out-of-bounds error

      String operator = tokens[i];
      double nextValue = double.parse(tokens[i + 1]);

      // Perform operations in strict left-to-right order
      if (operator == "+") {
        result += nextValue;
      } else if (operator == "-") {
        result -= nextValue;
      } else if (operator == "*") {
        result *= nextValue;
      } else if (operator == "/") {
        if (nextValue == 0) {
          print("Error: Division by zero");
          return;
        }
        result /= nextValue;
      }
    }

    if (!status) {
      // Square the result
      result *= result;
    }

    setState(() {
      inp = result.toString().endsWith('.0')
          ? result.toInt().toString()
          : result.toStringAsFixed(2);
    });
  } catch (e) {
    print("Error: Invalid expression - $e");
  }
}


}

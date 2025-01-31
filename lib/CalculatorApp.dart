// ignore_for_file: prefer_const_constructors

import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String inp = "0"; // ✅ Moved here to persist input
  var value = "";
  @override
  Widget build(BuildContext context) {
    // String inp = "0";  // ✅ Define it in the class, so it persists
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
                width: screenWidth,
                height: screenHeight * 0.25,
                color: Colors.black, // Set background color
                // color: Colors.blue, // Set background color
                alignment: Alignment.bottomRight, // Align text to the right
                padding:
                    EdgeInsets.only(right: screenWidth * 0.02), // Add padding
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    inp,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.11, // Dynamic font size
                      color: Colors.white, // Better contrast
                    ),
                    textAlign: TextAlign.right,
                  ),
                )),
            // Second Container (Result Display)
            Container(
              width: screenWidth,
              height: screenHeight * 0.1,
              color: Colors.black, // Set background color
              // color: Colors.red, // Set background color
              alignment: Alignment.topRight, // Align text to the right
              padding:
                  EdgeInsets.only(right: screenWidth * 0.02), // Add padding
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  value,
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
                value = "";
              } else if (specialOperation == "C") {
                if (inp.isNotEmpty) {
                  if (inp.length > 1) {
                    setState(() {
                      inp = inp.substring(0, inp.length - 1);
                    });
                    evaluateExpression(false);
                  } else {
                    inp = inp.substring(0, 0);
                    inp = "0";
                    value = "";
                  }
                } else {
                  inp = '0';
                }
              }
              else if(specialOperation == 'x²'){
                evaluateExpression('power');

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
                  evaluateExpression(
                      true); // Just call the method without passing inp
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
                  evaluateExpression(false);


                  // evaluateExpression();
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
                evaluateExpression(false);
              }
            });
          },
          child: Text(value, style: TextStyle(fontSize: screenWidth * 0.08)),
        ),
      ),
    );
  }

  void evaluateExpression(status) {
  String expression = inp;

  // Parse the expression manually from left to right
  RegExp regExp = RegExp(r'(\d+(\.\d+)?)|[\+\-\*/]');
  List<String> tokens = regExp.allMatches(expression).map((m) => m.group(0)!).toList();
  
  double result = double.parse(tokens[0]);  // Start with the first number
  int i = 1;

  while (i < tokens.length) {
    String operator = tokens[i];
    double nextNumber = double.parse(tokens[i + 1]);

    // Perform the operation based on the operator, ignoring BODMAS
    if (operator == '+') {
      result += nextNumber;
    } else if (operator == '-') {
      result -= nextNumber;
    } else if (operator == '*') {
      result *= nextNumber;
    } else if (operator == '/') {
      result /= nextNumber;
    }

    i += 2; // Move to the next operator and number
  }

  if (status == "power") {
    // Square the result if status is 'power'
    var resultString = result.toString();
    try {
      double valueNumber = double.parse(resultString); // Convert to number
      double valueSquare = valueNumber * valueNumber; // Square the number
      // value = valueSquare.toString(); // Convert back to string
      inp = valueSquare.toString();
    } catch (e) {
      print("Error: Invalid number format - $e");
    }
  } else if (status) {
    // For other status types, update the UI with the result
    setState(() {
      var resultString = result.toString();
      inp = resultString.endsWith('.0')
          ? resultString.split('.')[0] // Remove the decimal point for whole numbers
          : double.parse(resultString).toStringAsFixed(2);
      value = '';
      inp = inp;
    });
  } else {
    // Default case when no other status
    setState(() {
      var resultString = result.toString();
      inp = resultString.endsWith('.0')
          ? resultString.split('.')[0]
          : double.parse(resultString).toStringAsFixed(2);
      value = inp;
      inp = expression;
    });
  }
}

}

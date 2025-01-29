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
  var result = false;
  @override
  Widget build(BuildContext context) {
    // String inp = "0";  // ✅ Define it in the class, so it persists
    // var result = 36;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // Container(
            //   width: screenWidth,
            //   height: screenHeight * 0.350,
            //   color: Colors.black, // Set background color
            //   alignment: Alignment.bottomRight, // Align text to the right
            //   padding:
            //       EdgeInsets.only(right: screenWidth * 0.02), // Add padding
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment
            //         .end, // This will space out the texts
            //     children: [
            //       Text(
            //         'Bottommmmmmmmmmmmmmmmmm Texting',
            //         style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //           fontSize: screenWidth * 0.08,
            //           color: Colors.white,
            //         ),
            //         textAlign: TextAlign.right,
            //       ),
            //       Text(
            //         'Bottom Text',
            //         style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //           fontSize: screenWidth * 0.09, // Dynamic font size
            //           color: Colors.white, // Better contrast
            //         ),
            //         textAlign: TextAlign.right,
            //       ),
            //     ],
            //   ),
            // ),
        
        
            // First Container (Expression Display)
            Container(
              width: screenWidth,
              height: screenHeight * 0.25,
              color: Colors.black, // Set background color
              alignment: Alignment.bottomRight, // Align text to the right
              padding:
                  EdgeInsets.only(right: screenWidth * 0.02), // Add padding
              child: Text(
                result ? inp : "",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.09, // Dynamic font size
                  color: Colors.white, // Better contrast
                ),
                textAlign: TextAlign.right,
              ),
            ),
            // Second Container (Result Display)
            Container(
              width: screenWidth,
              height: screenHeight * 0.1,
              color: Colors.black, // Set background color
              alignment: Alignment.topRight, // Align text to the right
              padding:
                  EdgeInsets.only(right: screenWidth * 0.02), // Add padding
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  result ? value : inp, 
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.12, // Dynamic font size
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
                        specilaBtn(screenWidth, screenHeight, "%"),
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
                result = false;
              } else if (specialOperation == "C") {
                if (inp.isNotEmpty) {
                  inp = inp.substring(0, inp.length - 1);
                }
              } else {
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
        print('Evaluating expression');
        evaluateExpression(); // Just call the method without passing inp
      } else {
        inp += operator; // Append operator
      }
    }
  });
}
,
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


void evaluateExpression() {
  try {
    Parser p = Parser();
    Expression exp = p.parse(inp); // Use the class variable inp directly
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    
    setState(() {
      result = true;
      value = eval.toString();
    });
  } catch (e) {
    print('Error evaluating expression: $e');
  }

  }
  }

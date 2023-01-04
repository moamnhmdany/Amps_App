import 'dart:core';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:url_launcher/url_launcher.dart';

class connverter_page extends StatefulWidget {
  const connverter_page({super.key});

  @override
  State<connverter_page> createState() => _connverter_pageState();
}

// ignore: camel_case_types
class _connverter_pageState extends State<connverter_page> {
  TextEditingController firstController = TextEditingController();
  TextEditingController secondController = TextEditingController();

  final List<String> items = [
    "Volts",
    'Watt',
    'Amps',
  ];
  String selectedValue = "Volts";
  String textField_1 = "Watt";
  String textField_2 = "Amps";
  double? textField_number1;
  double? textField_number2;
  double? result = 0.0;
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri(scheme: "https", host: url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not launch url";
    }
  }

  bool validationTextBox() {
    bool first = firstController.value.text.isEmpty;
    bool second = secondController.value.text.isEmpty;
    if ((first && second) || (first || second)) {
      return false;
    } else {
      return true;
    }
  }

  void clearText() {
    firstController.clear();
    secondController.clear();
    result = 0.0;
  }

  void textFieldNamesChange() {
    clearText();
    if (selectedValue == 'Volts') {
      setState(() {
        textField_1 = items.elementAt(1).toString();
        textField_2 = items.elementAt(2).toString();
      });
    } else if (selectedValue == 'Watt') {
      setState(() {
        textField_1 = items.elementAt(0).toString();
        textField_2 = items.elementAt(2).toString();
      });
    } else if (selectedValue == 'Amps') {
      setState(() {
        textField_1 = items.elementAt(0).toString();
        textField_2 = items.elementAt(1).toString();
      });
    }
  }

  void calculateResults() {
   if(validationTextBox()){
 textField_number1 = double.parse(firstController.text);
    textField_number2 = double.parse(secondController.text);
    if (textField_1 == "Watt" && textField_2 == "Amps") {
      setState(() {
        result = textField_number1! / textField_number2!;
      });
    } else if (textField_1 == "Volts" && textField_2 == "Amps") {
      setState(() {
        result = textField_number1! * textField_number2!;
      });
    } else if (textField_1 == "Volts" && textField_2 == "Watt") {
      setState(() {
        result = textField_number2! / textField_number1!;
      });
    }
   }
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor:const Color(0xffA6170A),
        title: const Text("Volts/Watts/Amps calculator"),
        actions: [
          IconButton(
            icon: const Icon(Icons.offline_bolt,
            size: 35,
            ),
            onPressed: () => {},
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(11),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              height: 244,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Please select a category to calculate Volts, Watts or Amps",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  DropdownButton2(
                    buttonWidth: 300,
                    dropdownFullScreen: true,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownWidth: 250,
                    isExpanded: true,
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.black12,
                        width: 3,
                      ),
                      color: const Color(0xffEFEFEF),
                    ),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    hint: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        items.first.toString(),
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) => {
                      setState(
                        () => selectedValue = value.toString(),
                      ),
                      textFieldNamesChange()
                    },
                    value: selectedValue,
                    buttonHeight: 60,
                    itemHeight: 40,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: firstController,
                      cursorColor: Colors.red,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: textField_1,
                        hintTextDirection: TextDirection.rtl,
                        hintStyle: const TextStyle(fontWeight: FontWeight.w700),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(50)),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: secondController,
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: textField_2,
                        hintTextDirection: TextDirection.rtl,
                        hintStyle: const TextStyle(fontWeight: FontWeight.w700),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: const BorderSide(color: Colors.red)),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    selectedValue.toString() + " :",
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                  Text(result.toString()),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        calculateResults();
                      },
                      style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                      child: const Text(
                        'Calculate',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 90,
              margin: const EdgeInsets.only(top: 70),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlutterSocialButton(
                    onTap: () {
                      _launchURL("www.facebook.com");
                    },
                    mini: true,
                    buttonType: ButtonType.facebook,
                  ),
                  FlutterSocialButton(
                    onTap: () {
                      _launchURL("www.twitter.com");
                    },
                    mini: true,
                    buttonType: ButtonType.twitter,
                  ),
                  FlutterSocialButton(
                    onTap: () {
                      _launchURL("www.whatsapp.com");
                    },
                    mini: true,
                    buttonType: ButtonType.whatsapp,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

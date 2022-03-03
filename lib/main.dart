import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
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

  TextEditingController phnController = TextEditingController();
  String initialCountry = "IN";
  PhoneNumber number =  PhoneNumber(isoCode: 'IN');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text('WhatsHelper'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8, bottom: 8, left: 16, top: 8),
                      child: InternationalPhoneNumberInput(
                        searchBoxDecoration: InputDecoration(
                          icon: Icon(Icons.map)
                        ),
                        spaceBetweenSelectorAndTextField: 0,
                        onInputChanged: (val){
                            number = val;
                        },
                        selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.DIALOG,
                          useEmoji: true,
                        ),
                        initialValue: number,
                        textFieldController: phnController,
                        inputBorder: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(onPressed: ()=>whatsAppOpen(number), child: Text('Go to WhatsApp'))
              ],
            ),
          ),
        ],
      ),
    );
  }
  void whatsAppOpen(PhoneNumber number) async {

      await launch("whatsapp://send?phone=${number.phoneNumber}");

  }
}

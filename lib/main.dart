import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController phnController = TextEditingController();
  String initialCountry = "IN";
  PhoneNumber number = PhoneNumber(isoCode: 'IN');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('WhatsHelper'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 8,
                        bottom: 8,
                        left: 16,
                        top: 8,
                      ),
                      child: InternationalPhoneNumberInput(
                        searchBoxDecoration:
                            const InputDecoration(icon: Icon(Icons.map)),
                        spaceBetweenSelectorAndTextField: 0,
                        onInputChanged: (val) {
                          number = val;
                        },
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.DIALOG,
                          useEmoji: true,
                        ),
                        initialValue: number,
                        textFieldController: phnController,
                        inputBorder: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => whatsAppOpen(number),
                  child: const Text('Go to WhatsApp'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> whatsAppOpen(PhoneNumber number) async {
    final sendUri = Uri(
      scheme: 'whatsapp',
      host: 'send',
      queryParameters: {'phone': number.phoneNumber},
    );
    // "whatsapp://send?phone=${number.phoneNumber}"
    await launchUrl(sendUri);
  }
}

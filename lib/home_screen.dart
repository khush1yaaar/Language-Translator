import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var languages = {"Hindi", "English", "Marathi"};
  Map map = {
    "key": "value",
    "Hindi": "hi",
    "English": "en",
    "Marathi": "mr",
  };
  String OriginLanguage = "from";
  String DestinyLanguage = "to";
  TextEditingController languageController = TextEditingController();

  String output = "";

  void translate(String src, String des, String input) async {
    GoogleTranslator translator = GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: des);

    setState(() {
      output = translation.text.toString();
    });

    if (src == "--" || des == "--") {
      setState(() {
        output = "Failed to translate";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Language Translator',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 3, 52, 108),
      ),
      body: Container(
        color: const Color.fromARGB(255, 3, 52, 108),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 50,
                ),
                DropdownButton<String>(
                  iconDisabledColor: Colors.white,
                  iconEnabledColor: Colors.white,
                  items: languages.map((String s) {
                    return DropdownMenuItem<String>(
                      value: s,
                      child: Text(s),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      OriginLanguage = newValue!;
                    });
                  },
                  hint: Text(OriginLanguage,
                      style: const TextStyle(
                        color: Colors.white,
                      )),
                ),
                const SizedBox(
                  width: 50,
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 50,
                ),
                DropdownButton<String>(
                  iconDisabledColor: Colors.white,
                  iconEnabledColor: Colors.white,
                  items: languages.map((String s) {
                    return DropdownMenuItem<String>(
                      value: s,
                      child: Text(s),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      DestinyLanguage = newValue!;
                    });
                  },
                  hint: Text(DestinyLanguage,
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                autofocus: false,
                controller: languageController,
                cursorColor: Colors.white,
                style: const TextStyle(
                  color: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter valid text';
                  }

                  return null;
                },
                decoration: InputDecoration(
                  fillColor: Colors.blue.shade50,
                  labelText: 'please entre your text...',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                translate(
                    map[OriginLanguage], map[DestinyLanguage], languageController.text);
              },
              child: Text('Translate'),
            ),
            Text(
              output,
              style: const TextStyle(color: Colors.white, fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}

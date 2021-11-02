import 'package:flutter/material.dart';
import 'package:test12/models/language_model.dart';
import 'package:test12/utils/response.dart';
import 'package:test12/utils/connection_manager.dart';

class GoogleTranslatePage extends StatelessWidget {
  const GoogleTranslatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google translate"),
      ),
      body: BodyGoogleTranslatePage(),
    );
  }
}

class BodyGoogleTranslatePage extends StatefulWidget {
  const BodyGoogleTranslatePage({Key? key}) : super(key: key);

  @override
  _BodyGoogleTranslatePageState createState() =>
      _BodyGoogleTranslatePageState();
}

class _BodyGoogleTranslatePageState extends State<BodyGoogleTranslatePage> {
  var _value;
  var _result = '';
  var _word = '';
  bool isLoading = false;
  List<LanguageModel> languages = [];

  void getData() async {
    try {
      setState(() {
        isLoading = true;
      });
      Response result = await getLanguagesList();

      if (result.statusCode == 200) {
        languages = result.body;
        print(languages.length);
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void translate() async {
    try {
      setState(() {
        isLoading = true;
      });
      Response result = await translateWord(_word);

      if (result.statusCode == 200) {
        setState(() {
          _result = result.body;
        });
        print(_result);
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 16, right: 16, top: 62, bottom: 42),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Welcome",
            style: TextStyle(
              fontSize: 36,
              color: Color(0xFF0865A8),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 42,
          ),
          Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "enter text",
                    labelStyle: TextStyle(color: Colors.blueGrey),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.greenAccent, width: 5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5.0),
                    ),
                  ),
                ),
                DropdownButton(
                  value: _value,
                  items: languages.map((LanguageModel item) {
                    return DropdownMenuItem<String>(
                      child: Text(item.language),
                      value: item.language,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                  hint: Text("Select item"),
                  disabledHint: Text("Disabled"),
                  elevation: 8,
                  style: TextStyle(color: Colors.green, fontSize: 16),
                  icon: Icon(Icons.arrow_drop_down_circle),
                  iconDisabledColor: Colors.purpleAccent,
                  iconEnabledColor: Colors.purple,
                  isExpanded: true,
                ),
                SizedBox(
                  height: 42,
                ),
                MaterialButton(
                  onPressed: () {
                    translate();
                  },
                  child: Text(
                    "Translate",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  minWidth: 200,
                  height: 48,
                  color: Color(0xFF0865A8),
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                SizedBox(
                  height: 42,
                ),
                Text(_result)
              ],
            ),
          ),
        ],
      )),
    );
  }
}

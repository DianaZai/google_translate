import 'dart:convert';

import 'package:test12/models/translation_model.dart';
import 'package:test12/models/language_model.dart';
import 'package:http/http.dart' as http;
import 'response.dart';

final String baseUrl =
    "https://google-translate1.p.rapidapi.com/language/translate/v2";

Future<Response> getLanguagesList() async {
  String url = "$baseUrl/languages";
  http.Response response = await http.get(
    url,
    headers: {
      'content-type': 'application/json',
      'accept': 'application/json',
      'accept-encoding': 'application/gzip',
      'x-rapidapi-host': 'google-translate1.p.rapidapi.com',
      'x-rapidapi-key': 'f933a24ef2msh9b7c560a28f9fdfp1ee58bjsn9bebc072c44a',
    },
  );
  var data = json.decode(response.body);
  print(response.statusCode);

  if (response.statusCode == 200) {
    List list = data['data']['languages'];
    List<LanguageModel> languages =
        list.map((tr) => LanguageModel.fromJson(tr)).toList();
    return Response(200, languages);
  } else {
    return Response(-1, "Failed");
  }
}

Future<Response> translateWord(word) async {
  String url = "$baseUrl";
  http.Response response = await http.post(
    url,
    headers: {
      'content-type': 'application/json',
      'accept': 'application/json',
      'accept-encoding': 'application/gzip',
      'x-rapidapi-host': 'google-translate1.p.rapidapi.com',
      'x-rapidapi-key': 'f933a24ef2msh9b7c560a28f9fdfp1ee58bjsn9bebc072c44a'
    },
    body: {'source': 'fr', 'target': 'en', 'q': 'test'},
  );

  var data = json.decode(response.body);
  print(data);

  if (response.statusCode == 200) {
    List list = data['data']['translations'];
    List<TranslationModel> translations =
        list.map((tr) => TranslationModel.fromJson(tr)).toList();
    return Response(200, translations);
  } else {
    return Response(-1, "Failed");
  }
}

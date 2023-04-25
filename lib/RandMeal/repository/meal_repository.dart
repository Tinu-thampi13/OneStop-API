import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/meal_model.dart';

class MealRepo {
  Future<MealModel> getMeal() async {
    String url = "https://www.themealdb.com/api/json/v1/1/random.php";
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    return MealModel.fromJson(jsonDecode(response.body));
  }
}

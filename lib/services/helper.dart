// import 'package:flutter/services.dart' as the_bundle;
import 'package:shoes/models/sneaker_model.dart';
import 'package:http/http.dart' as http;
import 'package:shoes/services/config.dart';

// this class fetches data from the json file and return it to the app
class Helper {
  static var client = http.Client();
  // Male~
  Future<List<Sneakers>> getMaleSneakers() async {
    var url = Uri.http(Config.apiUrl, Config.sneakers);

    var response = await client.get(url);

    if (response.statusCode == 200) {
      final maleList = sneakersFromJson(response.body);
      var kids =
          maleList.where((element) => element.category == "Men's Running");
      return kids.toList();
    } else {
      throw Exception("Failed to get sneakers list");
    }
  }

  // Female
  Future<List<Sneakers>> getFemaleSneakers() async {
    var url = Uri.http(Config.apiUrl, Config.sneakers);

    var response = await client.get(url);

    if (response.statusCode == 200) {
      final femaleList = sneakersFromJson(response.body);
      var female =
          femaleList.where((element) => element.category == "Women's Running");
      return female.toList();
    } else {
      throw Exception("Failed to get sneakers list");
    }
  }

  // kids
  Future<List<Sneakers>> getKidsSneakers() async {
    var url = Uri.http(Config.apiUrl, Config.sneakers);

    var response = await client.get(url);

    if (response.statusCode == 200) {
      final kidsList = sneakersFromJson(response.body);
      var kids =
          kidsList.where((element) => element.category == "Kids' Running");
      return kids.toList();
    } else {
      throw Exception("Failed to get sneakers list");
    }
  }

  Future<List<Sneakers>> search(String searchQuery) async {
    var url = Uri.http(Config.apiUrl, "${Config.search}$searchQuery");

    var response = await client.get(url);

    if (response.statusCode == 200) {
      final results = sneakersFromJson(response.body);
      return results;
    } else {
      throw Exception("Failed to get sneakers list");
    }
  }
}

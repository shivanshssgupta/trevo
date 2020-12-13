import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:trevo/Models/restaurants.dart';
import 'package:http/http.dart' as http;

class RestaurantsProvider with ChangeNotifier {
  bool loading = true;
  String error;
  int cityId;
  RestaurantAPI restaurantAPI = new RestaurantAPI();

  RestaurantsProvider(String cityName) {
    fetchRestaurants(cityName);
  }

  Future<bool> fetchRestaurantID(String cityName) async {
    await RestaurantsAPICall()
        .fetchRestaurantIDFromAPI(cityName)
        .then((data) async {
      if (data.statusCode == 200) {
        var json = jsonDecode(data.body);
        final tempList = json["location_suggestions"];
        cityId = tempList[0]["id"];
        return true;
      } else {
        setError('Can\'t reach our servers right now!\nTry again later.');
        setLoading(false);
        return false;
      }
    });
  }

  Future<bool> fetchRestaurants(String cityName) async {
    setLoading(true);
    await fetchRestaurantID(cityName);
    print(cityId);
    await RestaurantsAPICall()
        .fetchRestaurantsFromAPI(cityId)
        .then((data) async {
      if (data.statusCode == 200) {
        restaurantAPI = RestaurantAPI.fromJson(jsonDecode(data.body));
        setLoading(false);
        return true;
      } else {
        setError('Can\'t reach our servers right now!\nTry again later.');
        setLoading(false);
        return false;
      }
    });
  }

  void setError(value) {
    error = value;
    notifyListeners();
  }

  String getError() {
    return error;
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }
}

class RestaurantsAPICall {
  Future<http.Response> fetchRestaurantIDFromAPI(String cityName) async {
    return await http.get(
        "https://developers.zomato.com/api/v2.1/cities?q=$cityName&apikey=e29223875940edb7f8c991066d3392bb");
  }

  Future<http.Response> fetchRestaurantsFromAPI(int cityID) async {
    return await http.get(
        "https://developers.zomato.com/api/v2.1/search?entity_id=$cityID&entity_type=city&sort=rating&order=desc&apikey=e29223875940edb7f8c991066d3392bb");
  }
}

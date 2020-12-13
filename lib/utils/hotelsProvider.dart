import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:trevo/Models/hotels.dart';
import 'package:http/http.dart' as http;

class HotelsProvider with ChangeNotifier {
  bool loading = true;
  String error;
  HotelAPI hotelAPI = new HotelAPI();

  HotelsProvider(String cityName) {
    fetchHotels(cityName);
  }

  Future<bool> fetchHotels(String cityName) async {
    setLoading(true);
    await HotelsAPICall().fetchHotelsFromAPI(cityName).then((data) {
      if (data.statusCode == 200) {
        hotelAPI = HotelAPI.fromJson(jsonDecode(data.body));
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

class HotelsAPICall {
  String apiEndpoint = "https://trevo-server.herokuapp.com/hotels/";

  Future<http.Response> fetchHotelsFromAPI(String cityName) async {
    return await http.get(apiEndpoint + cityName);
  }
}

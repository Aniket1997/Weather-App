import 'dart:convert';

import 'package:weatherapp_starter_project/model/weather_data.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp_starter_project/model/weather_data_current.dart';
import 'package:weatherapp_starter_project/model/weather_data_daily.dart';
import 'package:weatherapp_starter_project/model/weather_data_hourly.dart';
import 'package:weatherapp_starter_project/utils/api_url.dart';

class FetchWeatherAPI {
  WeatherData? weatherData;

  // procecssing the data from response -> to json
  Future<WeatherData> processData(lat, lon) async {
    print(lat);
    print(lon);
    var response = await http.get(Uri.parse(apiURL(lat, lon)));
    var jsonString = jsonDecode(response.body);
    print(jsonString);
    weatherData = WeatherData(
        WeatherDataCurrent.fromJson(jsonString),
        WeatherDataHourly.fromJson(jsonString),
        WeatherDataDaily.fromJson(jsonString));
    print(weatherData);
    return weatherData!;
  }

  Future<WeatherData> processDataFromCityURL(String url) async {
    var response = await http.get(Uri.parse(url));
    var jsonString = jsonDecode(response.body);
    print(jsonString);
    weatherData = WeatherData(
        WeatherDataCurrent.fromJson(jsonString),
        WeatherDataHourly.fromJson(jsonString),
        WeatherDataDaily.fromJson(jsonString));
    print(weatherData);
    return weatherData!;
  }
}
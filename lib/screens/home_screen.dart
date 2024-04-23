import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp_starter_project/api/fetch_weather.dart';
import 'package:weatherapp_starter_project/controller/global_controller.dart';
import 'package:weatherapp_starter_project/utils/api_url.dart';
import 'package:weatherapp_starter_project/utils/custom_colors.dart';
import 'package:weatherapp_starter_project/widgets/comfort_level.dart';
import 'package:weatherapp_starter_project/widgets/current_weather_widget.dart';
import 'package:weatherapp_starter_project/widgets/daily_data_forecast.dart';
import 'package:weatherapp_starter_project/widgets/header_widget.dart';
import 'package:weatherapp_starter_project/widgets/hourly_data_widget.dart';
import 'package:geocoding/geocoding.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: null);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Call
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(20.0).copyWith(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                  height: 200,
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (value) {
                          searchTerm = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Search',
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          String url = apiCityURL(searchTerm);
                          // Call the FetchWeatherAPI class to fetch weather data
                          FetchWeatherAPI().processDataFromCityURL(url).then((value) {
                            // Update the weather data in the GlobalController
                            globalController.weatherData.value = value;
                          });
                        },
                        child: Text('Search'),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Obx(() {
          final isLoading = globalController.checkLoading().value;
          final backgroundColor = globalController.getBackgroundColor().value;

          return isLoading
            ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/clouds.png",
                        height: 200,
                        width: 200,
                      ),
                      const CircularProgressIndicator()
                    ],
                  ),
                )
              : Container(
                  color: backgroundColor,
                  child: Center(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        const SizedBox(height: 20),
                        const HeaderWidget(),
                        // For current temperature ('current')
                        CurrentWeatherWidget(
                          weatherDataCurrent:
                              globalController.getData().getCurrentWeather(),
                          globalController:
                              Get.put(GlobalController(), permanent: true),
                        ),
                        const SizedBox(height: 20),
                        HourlyDataWidget(
                          weatherDataHourly:
                              globalController.getData().getHourlyWeather(),
                          globalController: globalController,
                        ),
                        DailyDataForecast(
                          weatherDataDaily:
                              globalController.getData().getDailyWeather(),
                        ),
                        Container(
                          height: 1,
                          color: CustomColors.dividerLine,
                        ),
                        const SizedBox(height: 10),
                        ComfortLevel(
                          weatherDataCurrent:
                              globalController.getData().getCurrentWeather(),
                          globalController: globalController,
                        )
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }
}
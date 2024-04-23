import 'package:flutter/material.dart';
import 'package:weatherapp_starter_project/model/weather_data_current.dart';
import 'package:weatherapp_starter_project/utils/custom_colors.dart';
import 'package:weatherapp_starter_project/controller/global_controller.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;
  final GlobalController globalController;

  const CurrentWeatherWidget({
    Key? key,
    required this.weatherDataCurrent,
    required this.globalController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //tempeture area
        tempeatureAreaWidget(),

        const SizedBox(
          height: 20,
        ),
        // more details - windspeed, humidity, clouds
        currentWeatherMoreDetailsWidget(),
      ],
    );
  }

  Widget currentWeatherMoreDetailsWidget() {
    Color backgroundColor = globalController.getBackgroundColor().value;
    bool isDarkMode = backgroundColor.red == 0 &&
        backgroundColor.green == 0 &&
        backgroundColor.blue == 0;
    //print("In current Weather $isDarkMode");
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Image.asset("assets/icons/windspeed.png"),
            ),
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Image.asset("assets/icons/clouds.png"),
            ),
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Image.asset("assets/icons/humidity.png"),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "${weatherDataCurrent.current.windSpeed}km/h",
                style: TextStyle(
                  fontSize: 12,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "${weatherDataCurrent.current.clouds}%",
                style: TextStyle(
                  fontSize: 12,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "${weatherDataCurrent.current.humidity}%",
                style: TextStyle(
                  fontSize: 12,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget tempeatureAreaWidget() {
    Color backgroundColor = globalController.getBackgroundColor().value;
    bool isDarkMode = backgroundColor.red == 0 &&
        backgroundColor.green == 0 &&
        backgroundColor.blue == 0;
    //print(globalController.getBackgroundColor().value.toString());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          "assets/weather/${weatherDataCurrent.current.weather![0].icon}.png",
          height: 80,
          width: 80,
        ),
        Container(
          height: 50,
          width: 1,
          color: CustomColors.dividerLine,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: "${weatherDataCurrent.current.temp!.toInt()}°",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 68,
                    color: isDarkMode ? Colors.white : Colors.black,
                  )),
              TextSpan(
                  text: "${weatherDataCurrent.current.weather![0].description}",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: isDarkMode ? Colors.white : Colors.black,
                  )),
          ]),
        )
      ],
    );
  }
}

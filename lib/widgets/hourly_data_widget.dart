import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp_starter_project/controller/global_controller.dart';
import 'package:weatherapp_starter_project/model/weather_data_hourly.dart';
import 'package:weatherapp_starter_project/utils/custom_colors.dart';

class HourlyDataWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
  final GlobalController globalController;
  HourlyDataWidget({Key? key, required this.weatherDataHourly,required this.globalController,})
      : super(key: key);

  // card index
  RxInt cardIndex = GlobalController().getIndex();

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = globalController.getBackgroundColor().value;
    bool isDarkMode = backgroundColor.red == 0 &&
        backgroundColor.green == 0 &&
        backgroundColor.blue == 0;
    print("In current Weather $isDarkMode");
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          alignment: Alignment.topCenter,
          child: Text(
            "Today",
            style: TextStyle(
              fontSize: 18,
              color: isDarkMode? Colors.white : Colors.black,
            ),
          ),
        ),
        hourlyList(),
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 160,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherDataHourly.hourly.length > 12
           ? 14
            : weatherDataHourly.hourly.length,
        itemBuilder: (context, index) {
          return Obx((() => GestureDetector(
              onTap: () {
                cardIndex.value = index;
              },
              child: Container(
                width: 90,
                margin: const EdgeInsets.only(left: 20, right: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white,
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0.5, 0),
                          blurRadius: 1,
                          spreadRadius: 1,
                          color: CustomColors.dividerLine.withAlpha(90)),
                    ],
                    gradient: cardIndex.value == index
                       ? const LinearGradient(colors: [
                            CustomColors.firstGradientColor,
                            CustomColors.secondGradientColor
                          ])
                        : null),
                child: HourlyDetails(
                  index: index,
                  cardIndex: cardIndex.toInt(),
                  temp: weatherDataHourly.hourly[index].temp!,
                  timeStamp: weatherDataHourly.hourly[index].dt!,
                  weatherIcon:
                      weatherDataHourly.hourly[index].weather![0].icon!,
                ),
              ))));
        },
      ),
    );
  }
}

// hourly details class
class HourlyDetails extends StatelessWidget {
  int temp;
  int index;
  int cardIndex;
  int timeStamp;
  String weatherIcon;

  HourlyDetails(
      {Key? key,
      required this.cardIndex,
      required this.index,
      required this.timeStamp,
      required this.temp,
      required this.weatherIcon})
      : super(key: key);
  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat('jm').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(getTime(timeStamp),
              style: TextStyle(
                color: cardIndex == index
                   ? Colors.white
                    : Color.fromARGB(255, 0, 0, 0),
              )),
        ),
        Container(
            margin: const EdgeInsets.all(5),
            child: Image.asset(
              "assets/weather/$weatherIcon.png",
              height: 40,
              width: 40,
            )),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text("$temp°",
              style: TextStyle(
                color: cardIndex == index
                   ? Colors.white
                    : CustomColors.textColorBlack,
              )),
        )
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:weatherapp_starter_project/model/weather_data_current.dart';
import 'package:weatherapp_starter_project/utils/custom_colors.dart';
import 'package:weatherapp_starter_project/controller/global_controller.dart';

class ComfortLevel extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;
  final GlobalController globalController;
  const ComfortLevel({
    Key? key,
    required this.weatherDataCurrent,
    required this.globalController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = globalController.getBackgroundColor().value;
    bool isDarkMode = backgroundColor.red == 0 &&
        backgroundColor.green == 0 &&
        backgroundColor.blue == 0;
    //weatherDataCurrent.current.humidity!.toDouble();
    print("In Comfort Weather $isDarkMode");
    //print("In comfort level hum $hum");
    return Column(
      children: [
        Container(
          margin:
              const EdgeInsets.only(top: 1, left: 20, right: 20, bottom: 20),
          child: Text(
            "Comfort Level",
            style: TextStyle(
              fontSize: 18,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 180,
          child: Column(
            children: [
              Center(
                child: SleekCircularSlider(
                  min: 0,
                  max: 100,
                  initialValue: weatherDataCurrent.current.humidity!.toDouble(),
                  appearance: CircularSliderAppearance(
                      customWidths: CustomSliderWidths(
                          handlerSize: 0, trackWidth: 12, progressBarWidth: 12),
                      infoProperties: InfoProperties(
                          bottomLabelText: "Humidity",
                          bottomLabelStyle: TextStyle(
                            letterSpacing: 0.1,
                            fontSize: 14,
                            height: 1.5,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                          mainLabelStyle: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black, // Replace with your desired color
                            fontSize: 24,
                          ),
                          
                          ),
                          
                      animationEnabled: true,
                      size: 140,
                      customColors: CustomSliderColors(
                          hideShadow: true,
                          trackColor:
                              CustomColors.firstGradientColor.withAlpha(100),
                          progressBarColors: [
                            CustomColors.firstGradientColor,
                            CustomColors.secondGradientColor
                          ])),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Feels Like ",
                          style: TextStyle(
                              fontSize: 14,
                              height: 0.8,
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w400)),
                      TextSpan(
                          text: "${weatherDataCurrent.current.feelsLike}",
                          style: TextStyle(
                              fontSize: 14,
                              height: 0.8,
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w400))
                    ]),
                  ),
                  Container(
                    height: 25,
                    margin: const EdgeInsets.only(left: 40, right: 40),
                    width: 1,
                    color: CustomColors.dividerLine,
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "UV Index ",
                          style: TextStyle(
                              fontSize: 14,
                              height: 0.8,
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w400)),
                      TextSpan(
                          text: "${weatherDataCurrent.current.uvIndex}",
                          style: TextStyle(
                              fontSize: 14,
                              height: 0.8,
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w400))
                    ]),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

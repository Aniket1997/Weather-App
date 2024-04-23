import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:weatherapp_starter_project/controller/global_controller.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = "";
  String date = DateFormat("yMMMMd").format(DateTime.now());
  bool isLightMode = true;

  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    super.initState();
    getAddress(globalController.getLattitude().value,
        globalController.getLongitude().value);
  }

  getAddress(double lat, double lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    print("Lat $lat & lon $lon");
    Placemark place = placemark[0];
    setState(() {
      city = place.locality!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                city,
                style: TextStyle(
                  fontSize: 35,
                  height: 2,
                  color: isLightMode ? Colors.black : Colors.white,
                ),
              ),
              // Toggle button for light/dark mode
              GestureDetector(
                onTap: () {
                  setState(() {
                    isLightMode = !isLightMode;
                    Get.changeThemeMode(
                        isLightMode ? ThemeMode.light : ThemeMode.dark);
                    // Call toggleBackgroundColor method to update background color
                    globalController.toggleBackgroundColor();
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    isLightMode
                        ? CupertinoIcons.sun_dust_fill
                        : CupertinoIcons.moon_fill,
                    color: isLightMode
                        ? const Color.fromARGB(255, 251, 141, 45)
                        : const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            alignment: Alignment.topLeft,
            child: Text(date,
                style: TextStyle(
                    fontSize: 14,
                    color: isLightMode ? Colors.black : Colors.white))),
      ],
    );
  }
}

void main() {
  runApp(GetMaterialApp(
    home: HeaderWidget(),
  ));
}

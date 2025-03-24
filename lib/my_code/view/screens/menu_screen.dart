import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:stake_fair_app/my_code/models/menu_model.dart';
import 'package:stake_fair_app/my_code/services/api_service.dart';
import 'package:stake_fair_app/my_code/view/screens/competitions_screen.dart';


class MenuController extends GetxController {
  var isLoading = true.obs;
  var menuList = <EventTypes>[].obs;

  @override
  void onInit() {
    fetchMenuData();
    super.onInit();
  }

  void fetchMenuData() async {
    try {
      isLoading.value = true;
      MenuModel? menuModel = await ApiService.getMenuData();

      if (menuModel != null && menuModel.data != null) {
        menuList.value = menuModel.data!.eventTypes ?? [];
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}


class MenuScreen extends StatelessWidget {
  final MenuController controller = Get.put(MenuController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sports Events")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.menuList.isEmpty) {
          return Center(child: Text("No Event Types available"));
        }

        return SizedBox(
          height: 80,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.menuList.map((item) {
                String eventName = item.eventType?.name ?? "Unknown";
                IconData eventIcon = getEventIcon(eventName); // Get correct icon

                return GestureDetector(
                  onTap: () {
                    Get.to(() => CompetitionScreen(
                          eventName: eventName,
                          eventIcon: eventIcon, // ✅ Pass icon to the next screen
                        ));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(eventIcon, size: 30, color: Colors.white), // ✅ Correct Icon
                        SizedBox(height: 5),
                        Text(eventName),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      }),
    );
  }

  // 🔥 Function to map event names to icons
  IconData getEventIcon(String eventName) {
    switch (eventName.toLowerCase()) {
      case "soccer":
        return Icons.sports_soccer;
      case "tennis":
        return Icons.sports_tennis;
      case "golf":
        return Icons.sports_golf;
      case "cricket":
        return Icons.sports_cricket;
      case "rugby union":
      case "rugby league":
        return Icons.sports_rugby;
      case "boxing":
        return Icons.sports_mma;
      case "horse racing":
        return Icons.sports_baseball_sharp;
      case "motor sport":
        return Icons.directions_car;
      case "esports":
        return Icons.videogame_asset;
      case "volleyball":
        return Icons.sports_volleyball;
      case "cycling":
        return Icons.directions_bike;
      case "baseball":
        return Icons.sports_baseball;
      case "snooker":
        return Icons.sports_handball;
      default:
        return Icons.sports; // Default sports icon
    }
  }
}

































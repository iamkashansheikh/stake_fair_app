



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/my_code/controllers/competitions_controller.dart';


class CompetitionScreen extends StatelessWidget {
  final String eventName;
  final IconData eventIcon;
  final CompetitionController controller = Get.put(CompetitionController());

  CompetitionScreen({required this.eventName, required this.eventIcon});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchCompetitions(eventName);
    });

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(eventIcon, size: 24),
            SizedBox(width: 10),
            Text(eventName),
          ],
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.competitionList.isEmpty && controller.eventList.isEmpty) {
          return Center(child: Text("No Data Available"));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.competitionList.isNotEmpty) ...[
                  Text(
                    "Competitions",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Column(
                    children: controller.competitionList.map((item) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              item.competition?.name ?? "Unknown Competition",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                          ),
                          Divider(),
                        ],
                      );
                    }).toList(),
                  ),
                ],

                SizedBox(height: 15),

                // Events Section
                if (controller.eventList.isNotEmpty) ...[
                  Text(
                    "Events",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Column(
                    children: controller.eventList.map((item) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              item.eventType?.name ?? "Unknown Event",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            trailing: Icon(Icons.sports, size: 14, color: Colors.grey),
                          ),
                          Divider(),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }
}





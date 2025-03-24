import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/controllers/Home/events_controller.dart';
import 'package:stake_fair_app/my_code/controllers/events_controller.dart';



class EventsScreen extends StatelessWidget {
  final EventsController eventsController =Get.put(EventsController());
 // final EventsController eventsController = Get.put(EventsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Events")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              String sampleJsonResponse = '''{
                "data": {
                  "events": [
                    {
                      "event": { "id": "1", "name": "Football Match", "countryCode": "US", "timezone": "UTC", "openDate": "2025-03-25" },
                      "competition": { "id": "101", "name": "Premier League" },
                      "eventType": { "id": "5", "name": "Sports" },
                      "marketCount": 10
                    }
                  ]
                },
                "meta": { "message": "Success", "status_code": 200, "status": true }
              }''';

              eventsController.fetchEvents(sampleJsonResponse);
            },
            child: Text("Load Events"),
          ),
          Expanded(
            child: Obx(() {
              if (eventsController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (eventsController.errorMessage.isNotEmpty) {
                return Center(child: Text(eventsController.errorMessage.value));
              }

              return ListView.builder(
                itemCount: eventsController.eventsList.length,
                itemBuilder: (context, index) {
                  final event = eventsController.eventsList[index].event;
                  return ListTile(
                    title: Text(event?.name ?? "No Name"),
                    subtitle: Text("Open Date: ${event?.openDate ?? "N/A"}"),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

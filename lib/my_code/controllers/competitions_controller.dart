

import 'package:get/get.dart';

import 'package:stake_fair_app/my_code/models/menu_model.dart';
import 'package:stake_fair_app/my_code/services/api_service.dart';

class CompetitionController extends GetxController {
  var isLoading = true.obs;
  var competitionList = <Competitions>[].obs;
  var eventList = <EventTypes>[].obs; // ✅ Store all event data
  var eventId = "".obs; // ✅ Use String for consistency with API

  void fetchCompetitions(String eventName) async {
    try {
      isLoading.value = true;
      MenuModel? menuModel = await ApiService.getMenuData();

      if (menuModel != null && menuModel.data != null) {
        // ✅ Store all events
        eventList.value = menuModel.data!.eventTypes ?? [];

        // 🔥 Find the event ID based on name
        var matchingEvent = eventList.firstWhere(
          (event) => event.eventType?.name == eventName,
          orElse: () => EventTypes(eventType: EventType(id: "-1", name: "Unknown")),
        );

        eventId.value = matchingEvent.eventType?.id ?? "-1";

        print("Fetching competitions for eventId: ${eventId.value}");

        // ✅ Filter competitions based on event ID
        competitionList.value = menuModel.data!.competitions
                ?.where((comp) => comp.eventType?.id == eventId.value)
                .toList() ??
            [];

        print("Fetched ${competitionList.length} competitions.");
      }
    } catch (e) {
      print("❌ Error fetching competitions: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
















//   import 'package:get/get.dart';
// import 'package:post_api_project/models/menu_model.dart';
// import 'package:post_api_project/services/api_service.dart';

// class CompetitionController extends GetxController {
//   var isLoading = true.obs;
//   var competitionList = <Competitions>[].obs;
//   var eventList = <EventTypes>[].obs; // ✅ Store all event data
//   var eventId = "".obs; // ✅ Use String for consistency with API

//   // ✅ Fetch competitions & store event list
//   void fetchCompetitions(String eventName) async {
//     try {
//       isLoading.value = true;
//       MenuModel? menuModel = await ApiService.getMenuData();

//       if (menuModel != null && menuModel.data != null) {
//         // ✅ Store all events
//         eventList.value = menuModel.data!.eventTypes ?? [];

//         // 🔥 Find the event ID based on name
//         var matchingEvent = eventList.firstWhere(
//           (event) => event.eventType?.name == eventName,
//           orElse: () => EventTypes(eventType: EventType(id: "-1", name: "Unknown")),
//         );

//         eventId.value = matchingEvent.eventType?.id ?? "-1";

//         print("Fetching competitions for eventId: ${eventId.value}");

//         // ✅ Filter competitions based on event ID
//         competitionList.value = menuModel.data!.competitions
//                 ?.where((comp) => comp.eventType?.id == eventId.value)
//                 .toList() ??
//             [];

//         print("Fetched ${competitionList.length} competitions.");
//       }
//     } catch (e) {
//       print("❌ Error fetching competitions: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }

//     // RxList to hold events data from API
//   var events = <Map<String, dynamic>>[].obs;
//   void fetchEvents() async {
//   try {
//     isLoading(true);
//     var data = {}; // Agar API ko koi parameters chahiye to yahan set karein.
//     var response = await _homeRepository.categoryApi(data);
//     if (response != null) {
//       // Parse response using your model
//       CategoryListModel model = CategoryListModel.fromJson(response);
//       if (model.data != null && model.data!.events != null) {
//         // Map each event item to a map for UI usage
//         events.assignAll(model.data!.events!.map((eventItem) {
//           return {
//             'id': eventItem.event?.id,
//             'name': eventItem.event?.name,
//             'countryCode': eventItem.event?.countryCode,
//             'timezone': eventItem.event?.timezone,
//             'openDate': eventItem.event?.openDate,
//             'marketCount': eventItem.marketCount,
//             // Agar competition ya eventType ki details chahiye to woh bhi add kar sakte hain:
//             'competition': eventItem.competition?.name,
//             'eventType': eventItem.eventType?.name,
//           };
//         }).toList());
//         print("Events updated: ${events.length}");
//       }
//     }
//   } catch (e) {
//     print("Error fetching events: $e");
//   } finally {
//     isLoading(false);
//   }
// }

// }














// import 'package:get/get.dart';
// import 'package:post_api_project/models/menu_model.dart';
// import 'package:post_api_project/services/api_service.dart';

// class CompetitionController extends GetxController {
//   var isLoading = true.obs;
//   var competitionList = <Competitions>[].obs;  // ✅ Stores competitions
//   var eventList = <Events>[].obs;              // ✅ Stores events
//   var eventId = "".obs;                        // ✅ Stores event ID

//   // ✅ Fetch competitions for a given eventName
//   void fetchCompetitionsByEvent(String eventName) async {
//     try {
//       isLoading.value = true;

//       // 🔥 Fetch data from API
//       MenuModel? menuModel = await ApiService.getMenuData();
//       if (menuModel == null || menuModel.data == null) {
//         print("❌ Error: API response is null.");
//         return;
//       }

//       // ✅ Store all events
//       eventList.value = menuModel.data!.events ?? [];

//       // ✅ Find event matching eventName
//       Events? matchingEvent = eventList.firstWhereOrNull(
//         (event) => event.name.toLowerCase() == eventName.toLowerCase(),
//       );

//       // ✅ Handle case where event is not found
//       if (matchingEvent == null) {
//         print("❌ No matching event found for '$eventName'");
//         eventId.value = "-1";
//         competitionList.clear();
//         isLoading.value = false;
//         return;
//       }

//       // ✅ Assign eventId correctly
//       eventId.value = matchingEvent.id;

//       print("✅ Fetching competitions for eventId: ${eventId.value}");

//       // ✅ Ensure competitions exist in API
//       if (menuModel.data!.competitions == null) {
//         print("❌ Error: Competitions data is null.");
//         competitionList.clear();
//         isLoading.value = false;
//         return;
//       }

//       // ✅ Filter competitions based on eventId
//       competitionList.value = menuModel.data!.competitions!
//           .where((comp) => comp.eventId == eventId.value)
//           .toList();

//       print("✅ Fetched ${competitionList.length} competitions.");
//     } catch (e) {
//       print("❌ Error fetching competitions: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }



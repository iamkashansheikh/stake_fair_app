import 'package:get/get.dart';
import 'package:stake_fair_app/repositroy/home_repository/home_repository.dart';

class InplayController extends GetxController {
  var liveMatchesCount = 0.obs; // Initially 0
  var events = <Map<String, dynamic>>[].obs;
  var selectedIndex = 0.obs;
  final HomeRepository _homeRepository = HomeRepository();

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }
  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  // Helper function to count live matches based on openDate.
  int countLiveMatches(List<Map<String, dynamic>> eventsList) {
    int count = 0;
    DateTime now = DateTime.now();
    for (var e in eventsList) {
      if (e["event"] != null && e["event"]["openDate"] != null) {
        try {
          // Parse openDate and convert to local time.
          DateTime openDate = DateTime.parse(e["event"]["openDate"]).toLocal();
          // Consider event live if it started before now and within 3 hours (adjust threshold as needed)
          if (openDate.isBefore(now) && now.difference(openDate).inHours < 3) {
            count++;
          }
        } catch (ex) {
          // If parsing fails, skip this event.
          continue;
        }
      }
    }
    return count;
  }

  void fetchEvents() async {
    var response = await _homeRepository.categoryApi({});
    if (response != null &&
        response["data"] != null &&
        response["data"]["events"] != null) {
      // Cast the events list to List<Map<String, dynamic>>
      events.value = (response["data"]["events"] as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();

      // Update liveMatchesCount using time-based filtering.
      liveMatchesCount.value = countLiveMatches(events.value);
      print("Live Matches Count: ${liveMatchesCount.value}");
    }
  }

  var oddsList = <Map<String, dynamic>>[].obs;
    void fetchOdds() {
    oddsList.value = [
      {"odds": 6.12, "price": 30.123},
      {"odds": 8.23, "price": 16.334},
      {"odds": 4.32, "price": 27.024},
      {"odds": 5.45, "price": 24.389},
      {"odds": 1.78, "price": 25.38},
      {"odds": 1.35, "price": 19.838},
    ];
  }
}

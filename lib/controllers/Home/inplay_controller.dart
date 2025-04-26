import 'package:get/get.dart';

class InplayController extends GetxController {
  var selectedIndex = 0.obs;
  var oddsList = <Map<String, dynamic>>[].obs;
  var matchLabels = <String>["Soccer", "TenniIIIIIIIIIIIs", "Cricket", "BasketbalCCCCCCCCCCCl", "BaseballCCCCCCCC","Baseball","BaseballBBBBBBBBBB",].obs; // Dynamic list of matches

  @override
  void onInit() {
    super.onInit();

    // Jab bhi selectedIndex change hoga, fetchOdds chalega
    ever(selectedIndex, (_) {
      fetchOdds();
    });

    // Pehle se ek default fetch karwa lete hain
    fetchOdds();
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  void fetchOdds() {
    // Yahan tum real API ya switch-case bhi laga sakte ho future me
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

import 'package:get/get.dart';

class InplayController extends GetxController {
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOdds();
  }
  void changeIndex(int index) {
    selectedIndex.value = index;
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

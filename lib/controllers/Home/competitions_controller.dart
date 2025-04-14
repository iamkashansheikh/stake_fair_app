// controllers/competiton_controller.dart

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/models/home_models/category_model.dart';
import 'package:stake_fair_app/repositroy/home_repository/home_repository.dart';

class CompetitonController extends GetxController {
  // CategoryListModel ka reactive variable
  var categoryListModel = Rxn<CategoryListModel>();

  // Observable list of competitions (total list jo API se aayi hai)
  var competitionList = <Competitions>[].obs;

  // Loading flag
  var isLoading = false.obs;

  // Repository instance for API calls.
  final HomeRepository _homeRepository = HomeRepository();

  // POST request data payload.
  final Map<String, dynamic> postData = {
    "key1": "value1",
    "key2": "value2",
  };

  @override
  void onInit() {
    fetchCategoryData();
    super.onInit();
  }

  Future<void> fetchCategoryData() async {
    try {
      isLoading.value = true; // Loading true set karo
      final response = await _homeRepository.categoryApi(postData);
      var model = CategoryListModel.fromJson(response);
      categoryListModel.value = model;

      // Agar competitions available hain, to unko competitionList observable mein assign karo.
      if (model.data?.competitions != null) {
        competitionList.assignAll(model.data!.competitions!);
      }
      if (kDebugMode) {
        print("Category API data: $response");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception occurred: $e");
      }
    } finally {
      isLoading.value = false; // Loading false set karo
    }
  }

  /// Yeh method tapped event type ke hisaab se competitions ko filter karta hai.
  List<Competitions> getCompetitionsByEvent(String eventName) {
    if (categoryListModel.value?.data?.competitions != null) {
      return categoryListModel.value!.data!.competitions!
          .where((comp) =>
              comp.eventType?.name == eventName.toLowerCase())
          .toList();
    }
    return [];
  }
}

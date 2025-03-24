import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/models/home_models/category_model.dart';
import 'package:stake_fair_app/repositroy/home_repository/home_repository.dart';

class CompetitionsController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();
  final RxList<Competitions> competitionsList = <Competitions>[].obs;
  final RxBool isLoading = false.obs;

  // Fetch competitions based on selected EventType ID
  void fetchCompetitions(String eventTypeId) async {
    try {
      isLoading.value = true;
      var response = await _homeRepository.categoryApi({}); // API call
      if (response != null) {
        CategoryListModel model = CategoryListModel.fromJson(response);
        if (model.data != null && model.data!.competitions != null) {
          // Filter competitions matching selected eventType ID
          competitionsList.assignAll(
            model.data!.competitions!
                .where((comp) => comp.eventType?.id == eventTypeId)
                .toList(),
          );
        }
      }
    } catch (e) {
      print("Error fetching competitions: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Navigate to Competitions Screen after fetching data
  void navigateToCompetitions(String eventTypeId) {
    fetchCompetitions(eventTypeId);
    //Get.to(() => CompetitionsScreen(eventTypeId: eventTypeId));
  }
}

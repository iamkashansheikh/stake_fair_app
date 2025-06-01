// controllers/competiton_controller.dart

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/models/home_models/category_model.dart';
import 'package:stake_fair_app/repositroy/home_repository/home_repository.dart';

class CompetitonController extends GetxController {
  var categoryListModel = Rxn<CategoryListModel>();

  var competitionList = <CompetitionElement>[].obs;

  var isLoading = false.obs;

  final HomeRepository _homeRepository = HomeRepository();

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
      isLoading.value = true;
      final response = await _homeRepository.categoryApi(postData);
      var model = CategoryListModel.fromJson(response);
      categoryListModel.value = model;
      if (model.data?.competitions != null) {
        competitionList.assignAll(model.data!.competitions);
      }
      if (kDebugMode) {
        print("Category API data: $response");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception occurred: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }

  List<CompetitionElement> getCompetitionsByEvent(String eventName) {
    if (categoryListModel.value?.data?.competitions != null) {
      return categoryListModel.value!.data!.competitions
          .where((comp) => comp.eventType?.name == eventName.toLowerCase())
          .toList();
    }
    return [];
  }
}

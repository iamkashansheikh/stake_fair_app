import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/models/home_models/sport_Model.dart';
import 'package:stake_fair_app/repositroy/home_repository/home_repository.dart';
import 'package:stake_fair_app/data/response/status.dart';
import 'package:stake_fair_app/data/response/api_response.dart';

class SportsController extends GetxController {
  final _categoryList = ApiResponse<SportsListModel>(Status.lOADING, null, null).obs;

  ApiResponse<SportsListModel> get categoryList => _categoryList.value;

  final HomeRepository _homeRepo = HomeRepository();

  final Map<String, IconData> sportIcons = {
    "Soccer": Icons.sports_soccer,
    "Tennis": Icons.sports_tennis,
    "Cricket": Icons.sports_cricket,
    "Basketball": Icons.sports_basketball,
    "Horse Racing": Icons.sports,
    "Greyhound Racing": Icons.pets, 
    "Baseball": Icons.sports_baseball,
  };

  @override
  void onInit() {
    fetchCategoryList();
    super.onInit();
  }

  void fetchCategoryList() async {
    _categoryList.value = ApiResponse.loading();

    try {
      var response = await _homeRepo.sportListApi({});
      var result = SportsListModel.fromJson(response);
      _categoryList.value = ApiResponse.completed(result);
    } catch (e) {
      _categoryList.value = ApiResponse.error(e.toString());
    }
  }

  /// 🔹 Get the right Flutter icon for sport
  IconData getIconForSport(String? sportName) {
    return sportIcons[sportName] ?? Icons.sports; // default icon if not found
  }
}

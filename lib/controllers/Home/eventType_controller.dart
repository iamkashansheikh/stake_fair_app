import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/models/home_models/category_model.dart';
import 'package:stake_fair_app/repositroy/home_repository/home_repository.dart';

class EventsTypeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();
  
  var isLoading = true.obs;
  final RxList<Map<String, dynamic>> categories = <Map<String, dynamic>>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void fetchCategories() async {
    try {
      isLoading.value = true;
      var data = {};
      var response = await _homeRepository.categoryApi(data);

      if (response != null) {
        try {
          CategoryListModel model = CategoryListModel.fromJson(response);

          categories.assignAll(model.data?.eventTypes?.map((e) {
            String label = e.eventType?.name ?? 'Unknown';
            return {
              'id': e.eventType?.id,
              'icon': mapIconFromCategoryName(label),
              'label': label,
              'isHighlighted': false,
              'marketCount': e.marketCount ?? 0,
            };
          }).toList() ?? []);
        } catch (e) {
          print("Error parsing category data: $e");
        }
      } else {
        print("Error: Response is null from API");
      }
    } catch (e) {
      print("Error fetching categories: $e");
    } finally {
      isLoading.value = false;
    }
  
  
}


  }

  IconData mapIconFromCategoryName(String name) {
    switch (name.toLowerCase()) {
      case 'cricket': return Icons.sports_cricket;
      case 'soccer': return Icons.sports_soccer;
      case 'tennis': return Icons.sports_tennis;
      case 'golf': return Icons.sports_golf;
      case 'rugby union':
      case 'rugby league': return Icons.sports_rugby;
      case 'boxing': return Icons.sports_mma;
      case 'horse racing': return Icons.sports;
      case 'motor sport': return Icons.motorcycle;
      case 'esports': return Icons.games;
      case 'special bets': return Icons.star;
      case 'volleyball': return Icons.sports_volleyball;
      case 'cycling': return Icons.pedal_bike;
      case 'gaelic games': return Icons.sports;
      case 'snooker': return Icons.sports;
      case 'baseball': return Icons.sports_baseball;
      case 'american football': return Icons.sports_football;
      case 'winter sports': return Icons.ac_unit;
      case 'international rules': return Icons.public;
      case 'basketball': return Icons.sports_basketball;
      case 'ice hockey': return Icons.sports_hockey;
      case 'australian rules': return Icons.sports;
      case 'handball': return Icons.sports_handball;
      case 'darts': return Icons.sports_bar;
      case 'mixed martial arts': return Icons.sports_mma;
      case 'greyhound racing': return Icons.pets;
      case 'politics': return Icons.how_to_vote;
      default: return Icons.help_outline;
    }
  }


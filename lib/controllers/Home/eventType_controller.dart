import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/models/home_models/category_model.dart';
import 'package:stake_fair_app/repositroy/home_repository/home_repository.dart';

class EventsTypeController extends GetxController {
  // HomeRepository instance through which API call perform hogi
  final HomeRepository _homeRepository = HomeRepository();

  // Observable flag to track loading state
  var isLoading = true.obs;

  // Observable list jo sirf eventTypes data store karega.
  final RxList<Map<String, dynamic>> categories = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  // API call karke, sirf eventTypes extract karna.
  void fetchCategories() async {
    try {
      isLoading.value = true;
      // Agar POST ke liye kuch data chahiye ho, to yahan define kar sakte hain.
      var postData = <String, dynamic>{
        "key1": "value1",
        "key2": "value2",
      };
      // Repository ke through API call karo
      var response = await _homeRepository.categoryApi(postData);

      // Agar response null nahi hai, to model banane ki koshish karo.
      if (response != null) {
        try {
          // JSON response ko CategoryListModel me convert karo.
          CategoryListModel model = CategoryListModel.fromJson(response);

          // Ab sirf eventTypes list ko map karke ek List<Map<String, dynamic>> bana lo.
          categories.assignAll(model.data?.eventTypes?.map((e) {
            // EventType ka naam se label set karo. Agar naam null ho to 'Unknown' use karo.
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
          if (kDebugMode) {
            print("Error parsing eventTypes data: $e");
          }
        }
      } else {
        if (kDebugMode) {
          print("Error: Response is null from API");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching eventTypes: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Yeh method eventType ke naam ke basis pe icon map karta hai.
  IconData mapIconFromCategoryName(String name) {
    switch (name.toLowerCase()) {
      case 'cricket':
        return Icons.sports_cricket;
      case 'tennis':
        return Icons.sports_tennis;
      case 'soccer':
        return Icons.sports_soccer;
      case 'golf':
        return Icons.sports_golf;
      case 'rugby union':
      case 'rugby league':
        return Icons.sports_rugby;
      case 'boxing':
        return Icons.sports_mma;
      case 'horse racing':
        return Icons.sports;
      case 'motor sport':
        return Icons.motorcycle;
      case 'esports':
        return Icons.games;
      case 'special bets':
        return Icons.star;
      case 'volleyball':
        return Icons.sports_volleyball;
      case 'cycling':
        return Icons.pedal_bike;
      case 'gaelic games':
        return Icons.sports;
      case 'snooker':
        return Icons.sports;
      case 'baseball':
        return Icons.sports_baseball;
      case 'american football':
        return Icons.sports_football;
      case 'winter sports':
        return Icons.ac_unit;
      case 'international rules':
        return Icons.public;
      case 'basketball':
        return Icons.sports_basketball;
      case 'ice hockey':
        return Icons.sports_hockey;
      case 'australian rules':
        return Icons.sports;
      case 'handball':
        return Icons.sports_handball;
      case 'darts':
        return Icons.sports_bar;
      case 'mixed martial arts':
        return Icons.sports_mma;
      case 'greyhound racing':
        return Icons.pets;
      case 'politics':
        return Icons.how_to_vote;
      default:
        return Icons.help_outline;
    }
  }
}

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:stake_fair_app/models/home_models/category_model.dart';

class PopularBetController extends GetxController {
  var categoryListModel = Rxn<CategoryListModel>();

  // For search functionality (if needed)
  var searchQuery = ''.obs;

  // These lists hold different parts of the fetched data.
  List<dynamic> eventTypes = [];
  List<dynamic> competitions = [];
  List<dynamic> events = [];
  

  final String apiUrl = "https://eka247.com/api/navigation/menuList";
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
      final response = await http
          .post(Uri.parse(apiUrl), body: jsonEncode(postData))
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        categoryListModel.value = CategoryListModel.fromJson(json);

        // Save raw sections for filtering if needed.
        eventTypes = json['data']['eventTypes'];
        competitions = json['data']['competitions'];
        events = json['data']['events'] ?? [];

        if (kDebugMode) {
          print("Fetched data: ${response.body}");
        }
      } else {
        if (kDebugMode) print("Error: ${response.statusCode}");
      }
    } catch (e) {
      if (kDebugMode) print("Exception: $e");
    }
  }

  /// A computed getter that returns a list of matches.
  /// Each match is represented as a Map with keys: 
  /// 'eventName' (e.g., "Delhi Capitals vs Rajasthan Royals"),
  /// 'competitionName' (e.g., "IPL"), and 
  /// 'eventTypeName' (e.g., "Cricket").
  List<Map<String, String>> get matchList {
    List<Map<String, String>> result = [];
    // Check that events have been fetched.
    final eventsList = categoryListModel.value?.data?.events ?? [];
    
    for (var ev in eventsList) {
      String eventName = ev.event?.name ?? "Unknown Match";
      String competitionName = ev.competition?.name ?? "Unknown Competition";
      String eventTypeName = ev.eventType?.name ?? "Unknown Sport";

      // For example, the match display string can be composed using event name.
      // Alternatively, you could combine competitionName and eventName if needed.
      result.add({
        'eventName': eventName,
        'competitionName': competitionName,
        'eventTypeName': eventTypeName,
      });
    }
    return result;
  }
}

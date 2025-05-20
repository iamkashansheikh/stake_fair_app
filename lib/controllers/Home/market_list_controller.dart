// competition_market_controller.dart
import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:stake_fair_app/models/home_models/market_list_model.dart';
import '../../repositroy/home_repository/home_repository.dart';

class MarketListController extends GetxController {
  // ── dependency ──────────────────────────────────────────────
  final HomeRepository _repo = HomeRepository();

  // ── observable state ────────────────────────────────────────
  final isLoading = false.obs;
  final errorMessage = RxnString();

  /// Parsed API response
  final Rx<MarketListModel?> model = Rx<MarketListModel?>(null);
  final Map<String, dynamic> postData = {
    "eventId": "34327913",
    "sportId": "4",
    "key": "7"
  };

  @override
  void onInit() {
    super.onInit();
  }

  // ── fetch data  ─────────────────────────────────────────────
  // competition_market_controller.dart  (only the fetch method changed)

  Future<void> fetchAllMarketList() async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      final response = await _repo.marketList(postData);

      if (response == null) {
        errorMessage.value = 'Empty response from server';
      } else {
        // Parse the Map<String, dynamic> into your model
        model.value = MarketListModel.fromJson(response);
        log('All market  list loaded $response');
      }
    } catch (e, s) {
      if (kDebugMode) print('fetchCompetitionMarket error: $e');
      log('All market  list error', error: e, stackTrace: s);
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}

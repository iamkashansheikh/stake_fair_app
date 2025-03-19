import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:stake_fair_app/models/home_models/category_model.dart';
import 'package:stake_fair_app/repositroy/home_repository/home_repository.dart';

class HomeController extends GetxController {
  // Other properties remain the same
  RxBool isBannerVisible = true.obs;
  var selectedIndex = 0.obs;
  var selectedItem = 'Safer Gambling'.obs;

  var isSaferGamblingExpanded = false.obs;
  var isAboutStakefairExpanded = false.obs;
  var isSearchFieldVisible = false.obs;

  final List<String> saferGambling = [
    'Safer Gambling',
    'Safer Gambling Information',
    'Gamcare',
    'Gardon Moody',
    'Safer Gambling Tool'
  ];

  final List<String> aboutStakefair = [
    'About StakeFair',
    'Careers',
    'StakeFair Corporate',
    'Resolve a Dispute'
  ];

  final List<Widget> screens = [
    Center(child: Text("Home Screen")),
    Center(child: Text("Menu Screen")),
    Center(child: Text("Cash Out Screen")),
    Center(child: Text("My Bets Screen")),
    Center(child: Text("Casino Screen")),
  ];

  // Updated: categories list now will be loaded from API using the model.
  final RxList<Map<String, dynamic>> categories = <Map<String, dynamic>>[].obs;

  // Existing static lists remain unchanged
  final RxList<Map<String, dynamic>> cricket = [
    {
      'icon': Icons.sports_cricket,
      'label': 'Bangladesh',
      'sub': 'ICC Championship Trophy'
    },
    {
      'icon': Icons.pets,
      'label': 'Pakistan',
      'sub': 'Eva Lys vs I Begu'
    },
    {
      'icon': Icons.sports_tennis,
      'label': 'Ilia Simakin',
      'sub': 'Simakin vs Vasely'
    },
    {
      'icon': Icons.sports_tennis,
      'label': 'Peter Park Biryukow',
      'sub': 'Bar Biryukov vs Kris Wyk'
    },
    {
      'icon': Icons.sports_cricket,
      'label': 'Delhi Capital Women',
      'sub': 'Di Shnadir vs Frech'
    },
  ].obs;

  final RxList<dynamic> horseRacing = [
    '13:15 HYDERABAD R2',
    'Today Card',
    'See all Horse Racing'
  ].obs;

  final RxList<Map<String, dynamic>> quickLinks = [
    {'icon': Icons.sports_tennis, 'name': 'Warwick Farm'},
    {'icon': Icons.sports_tennis, 'name': 'Sandown'},
    {'icon': Icons.sports_tennis, 'name': 'Belmont'},
    {'icon': Icons.sports_tennis, 'name': 'Womens Premier League'},
    {'icon': Icons.sports_cricket, 'name': 'Geet vs Galarneau'},
    {'icon': Icons.sports, 'name': 'Jam MCCab vs Simakin'},
    {'icon': Icons.sports_soccer, 'name': 'Altas vs Necaxa'},
    {'icon': Icons.sports_soccer, 'name': 'Ulsan Hyundai Horang-i vs Shangdong Taishan'},
    {'icon': Icons.sports_soccer, 'name': 'Shangai Port FC v Yokohama FM'},
    {'icon': Icons.sports_soccer, 'name': 'Dortmund vs Sporting Lisbon'},
  ].obs;

  final HomeRepository _homeRepository = HomeRepository();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

void fetchCategories() async {
  try {
    var data = {}; // Agar koi parameter required hai, use set karein.
    var response = await _homeRepository.categoryApi(data);
    print("Response from API: $response");
    if (response != null) {
      // Parse response using your model
      CategoryListModel model = CategoryListModel.fromJson(response);
      print("Parsed model.data: ${model.data}");
      if (model.data != null && model.data!.eventTypes != null) {
        print("Parsed eventTypes: ${model.data?.eventTypes}");
        categories.assignAll(model.data!.eventTypes!.map((e) {
          print("Parsed eventTypes: ${model.data?.eventTypes}");
          String label = e.eventType?.name ?? 'Unknown';
          
          return {
            'id': e.eventType?.id,
            'icon': mapIconFromCategoryName(label),
            'label': label,
            'isHighlighted': false, // Logic as needed.
          };
        }).toList());
        print("Categories updated: $categories");
      }
    }
  } catch (e) {
    print("Error fetching categories: $e");
  }
}


  // Map category name to corresponding IconData.
  IconData mapIconFromCategoryName(String name) {
    switch (name.toLowerCase()) {
      case 'soccer':
        return Icons.sports_soccer;
      case 'tennis':
        return Icons.sports_tennis;
      case 'golf':
        return Icons.sports_golf;
      case 'cricket':
        return Icons.sports_cricket;
      case 'rugby union':
      case 'rugby league':
        return Icons.sports_rugby; // Ensure proper icon is available.
      case 'boxing':
        return Icons.sports_mma;
      case 'horse racing':
        return Icons.sports; // Or a more specific racing icon.
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

  // Other methods remain unchanged.
  void changeIndex(int index) {
    selectedIndex.value = index;
  }

 
}



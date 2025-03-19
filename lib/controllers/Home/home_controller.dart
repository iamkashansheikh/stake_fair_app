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

 

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

 
}



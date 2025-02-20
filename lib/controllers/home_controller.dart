import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // Bottom navigation selected index
  var selectedIndex = 0.obs;

  // Selected item for dropdowns (if needed)
  var selectedItem = 'Safer Gambling'.obs;

  // Dropdown expansion toggles
  var isSaferGamblingExpanded = false.obs;
  var isAboutStakefairExpanded = false.obs;

  // Toggle for search field visibility
  var isSearchFieldVisible = false.obs;

  // Data for "Safer Gambling" dropdown
  final List<String> saferGambling = [
    'Safer Gambling',
    'Safer Gambling Information',
    'Gamcare',
    'Gardon Moody',
    'Safer Gambling Tool'
  ];

  // Data for "About StakeFair" dropdown
  final List<String> aboutStakefair = [
    'About StakeFair',
    'Carrer',
    'StakeFair Corporate',
    'Resolve Dispute'
  ];

  // Screens for BottomNavigationBar (if needed)
  final List<Widget> screens = [
    Center(child: Text("Home Screen")),
    Center(child: Text("Menu Screen")),
    Center(child: Text("Cash Out Screen")),
    Center(child: Text("My Bets Screen")),
    Center(child: Text("Casino Screen")),
  ];

  // Categories for the category bar
  final RxList<Map<String, dynamic>> categories = [
    {'icon': Icons.play_arrow, 'label': 'Play', 'isHighlighted': true},
    {'icon': Icons.sports_cricket, 'label': 'Cricket'},
    {'icon': Icons.sports_tennis, 'label': 'Tennis'},
    {'icon': Icons.sports_soccer, 'label': 'Soccer'},
    {'icon': Icons.sports, 'label': 'Horse Racing'},
    {'icon': Icons.pets, 'label': 'Greyhound Raching'},
    {'icon': Icons.sports_volleyball, 'label': 'Basketball'},
  ].obs;

  // Example data for "Most Popular Bets" section
  final RxList<Map<String, dynamic>> cricket = [
    {
      'icon': Icons.sports_cricket,
      'label': 'Bangladesh',
      'sub': 'ICC Cahmpionship Tropy'
    },
    {
      'icon': Icons.pets,
      'label': '9. Desttructive Diva',
      'sub': 'Eva Lys vs I Begu'
    },
    {
      'icon': Icons.sports_tennis,
      'label': 'llia Simakin',
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

  // Horse racing data
  final RxList<dynamic> horseRacing = [
    '13:15 HYDERABAD R2',
    'Today Card',
    'See all Horse Racing'
  ].obs;

  // Quick links data
  final RxList<Map<String, dynamic>> quickLinks = [
    {'icon': Icons.sports_tennis, 'name': 'Warwick Farm'},
    {'icon': Icons.sports_tennis, 'name': 'Sandown'},
    {'icon': Icons.sports_tennis, 'name': 'Belmont'},
    {'icon': Icons.sports_tennis, 'name': 'Womens Premier League'},
    {'icon': Icons.sports_cricket, 'name': 'Geet vs Galarneau'},
    {'icon': Icons.sports, 'name': 'Jam MCCab vs Simakin'},
    {'icon': Icons.sports_soccer, 'name': 'Altas vs Necaxa'},
    {
      'icon': Icons.sports_soccer,
      'name': 'Ulsan Hyundai Horang-i vs Shangdong Taishan'
    },
    {'icon': Icons.sports_soccer, 'name': 'Shangai Port FC v Yokohama FM'},
    {'icon': Icons.sports_soccer, 'name': 'Dortmund vs Sporting Lisbon'},
  ].obs;

  // Method to change the bottom navigation index
  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}

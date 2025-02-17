import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs; 

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> screens = [
    Center(child: Text("Home Screen")),
    Center(child: Text("Menu Screen")),
    Center(child: Text("Cash Out Screen")),
    Center(child: Text("My Bets Screen")),
    Center(child: Text("Casino Screen")),
  ];

    final RxList<Map<String, dynamic>> categories = [
    {'icon': Icons.play_arrow, 'label': 'Play', 'isHighlighted': true},
    {'icon': Icons.sports_cricket, 'label': 'Cricket'},
    {'icon': Icons.sports_tennis, 'label': 'Tennis'},
    {'icon': Icons.sports_soccer, 'label': 'Soccer'},
    {'icon': Icons.sports, 'label': 'Horse Racing'},
    {'icon': Icons.pets, 'label': 'Greyhound Raching'},
    {'icon': Icons.sports_volleyball, 'label': 'Basketball'},
  ].obs;

  final RxList<Map<String, dynamic>> cricket = [
    {'icon': Icons.sports_cricket, 'label': 'Bangladesh', 'sub' : 'ICC Cahmpionship Tropy '},
    {'icon': Icons.pets, 'label': '9. Desttructive Diva','sub' : 'Eva Lys vs I Begu '},
    {'icon': Icons.sports_tennis, 'label': 'llia Simakin', 'sub' : 'Simakin vs Vasely'},
    {'icon': Icons.sports_tennis, 'label': 'Peter Park Biryukow', 'sub' : 'Bar Biryukov vs Kris Wyk'},
    {'icon': Icons.sports_cricket, 'label': 'Delhi Capital Women','sub' : 'Di Shnadir vs  Frech'},
    ].obs;

  final RxList<dynamic> horseRacing = ['13:15 HYDERABAD R2','Today Card','See all Horse Racing'].obs;

}

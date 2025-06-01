import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stake_fair_app/controllers/Home/competition_market_controller.dart';
import 'package:stake_fair_app/controllers/Home/home_controller.dart';
import 'package:stake_fair_app/controllers/Home/inplay_controller.dart';
import 'package:stake_fair_app/res/app_colors/app_colors.dart';
import 'package:stake_fair_app/res/responsive.dart';
import 'package:stake_fair_app/scrollable.dart';
import '../../../controllers/Home/competitions_controller.dart';

class CompitationMarketList extends StatefulWidget {
  final String eventName;
  final String? compitationId;
  const CompitationMarketList({
    super.key,
    required this.eventName,
    required this.compitationId,
  });

  @override
  State<CompitationMarketList> createState() => _CompitationMarketListState();
}

class _CompitationMarketListState extends State<CompitationMarketList> {
  final HomeController homeController = Get.put(HomeController());
  final InplayController inplayController = Get.put(InplayController());
  bool showPlaceBet = false;
  bool texrt = false;
  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.of(context).size;
    return BaseResponsiveScreen(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: _buildAppBar(context),
          body: Stack(
            children: [
              NoBounceScrollWrapper(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildTodayMatehes('Sat , 24 May', widget.compitationId),
                      _buildHorseRacingSection(
                          'Competitions', widget.eventName),
                    ],
                  ),
                ),
              ),
              Obx(() => AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    top: homeController.isSearchFieldVisible.value ? 0 : -80,
                    left: 0,
                    right: 0,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity:
                          homeController.isSearchFieldVisible.value ? 1.0 : 0.0,
                      child: _buildSearchField(mediaQuery),
                    ),
                  )),
            ],
          ),
          bottomNavigationBar: Obx(() {
            return Container(
              color: AppColors.greyColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavItem(
                      index: 0,
                      label: 'Home',
                      icon: Icons.home,
                      onTap: () => homeController.changeIndex(0)),
                  _buildNavItem(
                      index: 1,
                      label: 'Menu',
                      icon: Icons.menu,
                      onTap: () => homeController.changeIndex(1)),
                  _buildNavItem(
                      index: 2,
                      label: 'CashOut',
                      icon: Icons.account_balance_wallet,
                      onTap: () => homeController.changeIndex(2)),
                  _buildNavItemWithAsset(
                      index: 3,
                      label: 'MyBets',
                      assetPath: 'assets/images/money.png',
                      onTap: () => homeController.changeIndex(3)),
                  _buildNavItemWithAsset(
                      index: 4,
                      label: 'Casino',
                      assetPath: 'assets/images/casino-chip (1).png',
                      onTap: () => homeController.changeIndex(4)),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTodayMatehes(String title, String? compitationId) {
    final CompetitionMarketController competitionMarketController =
        Get.put(CompetitionMarketController());
    competitionMarketController.fetchCompetitionMarket(compitationId!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          if (competitionMarketController.model.value == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final competitions = competitionMarketController.model.value!.data;

            if (competitions == '') {
              return Center(child: Text("No Competitions Found"));
            }

            // Group by date
            Map<String, List<dynamic>> groupedByDate = {};
            for (var comp in competitions!) {
              String dateKey = formatDateLabel(comp.event!.openDate.toString());

              if (!groupedByDate.containsKey(dateKey)) {
                groupedByDate[dateKey] = [];
              }
              groupedByDate[dateKey]!.add(comp);
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: groupedByDate.length,
              itemBuilder: (context, index) {
                String date = groupedByDate.keys.elementAt(index);
                List<dynamic> items = groupedByDate[date]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildContainer(date),
                    ...items.map((competition) {
                      return Column(
                        children: [
                          Container(
                            height: 50.h,
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.r),
                                  color: competition.status == 'CLOSED'
                                      ? Colors.grey
                                      : Colors.grey[100],
                                  child: Center(
                                    child: competition.status == 'CLOSED'
                                        ? Text(
                                            'END',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 9.sp,
                                            ),
                                          )
                                        : Text(
                                            formatDateTime(competition
                                                .marketStartTime
                                                .toString()),
                                            style: TextStyle(
                                                fontSize: 9.sp,
                                                color: Colors.black),
                                        
                                    child: Text(
                                      formatDateTime(competition.marketStartTime
                                          .toString()),
                                      style: TextStyle(
                                          fontSize: 9.sp, color: Colors.black),
                                   
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      '${competition.event!.name}',
                                      style: TextStyle(fontSize: 11.sp),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Stack(
                                    children: [
                                      competition.status == 'CLOSED'
                                          ? Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    height: 38.h,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white
                                                            .withOpacity(.8),
                                                        border: Border.all(
                                                            color: Colors.red,
                                                            width: 2)),
                                                    child: Center(
                                                      child: Text(
                                                        'CLOSED',
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  // Blue Boxes - Always 3 boxes
                                                  ..._buildBlueBoxes(
                                                      competition.runners!),

                                                  // Pink Boxes - Always 3 boxes
                                                  ..._buildPinkBoxes(
                                                      competition.runners!),
                                                ],
                                              ),
                                            ),
                                      competition.status == 'SUSPENDED'
                                          ? Positioned(
                                              child: Container(
                                                  height: 38.h,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(.8),
                                                      border: Border.all(
                                                          color: Colors.red,
                                                          width: 2)),
                                                  child: Center(
                                                    child: Text(
                                                      'SUSPENDED',
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )),
                                            )
                                          : Text(''),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(height: 0.3, thickness: 0.3),
                        ],
                      );
                    }).toList(),
                  ],
                );
              },
            );
          }
        })
      ],
    );
  }

// Helper to build blue boxes with your logic
  List<Widget> _buildBlueBoxes(List<dynamic> runners) {
    List<double?> backPrices = [];
    List<double?> backSizes = [];

    for (var runner in runners) {
      final back = (runner.ex?.availableToBack != null &&
              runner.ex!.availableToBack!.isNotEmpty)
          ? runner.ex!.availableToBack!.first
          : null;
      backPrices.add(back?.price ?? 0);
      backSizes.add(back?.size ?? 0);
    }

    // Make sure length is at least 3
    while (backPrices.length < 3) backPrices.add(0);
    while (backSizes.length < 3) backSizes.add(0);

    List<Widget> boxes = [];
    int len = backPrices.length;

    bool lastTwoZero = backPrices[len - 1] == 0 &&
        backSizes[len - 1] == 0 &&
        backPrices[len - 2] == 0 &&
        backSizes[len - 2] == 0;

    for (int i = 0; i < 3; i++) {
      if (lastTwoZero && i == 2) {
        boxes.add(_buildBox('-', '-', Colors.blue[100]));
      } else {
        boxes.add(_buildBox(backPrices[i], backSizes[i], Colors.blue[100]));
      }
    }

    return boxes;
  }

// Helper to build pink boxes with your logic
  List<Widget> _buildPinkBoxes(List<dynamic> runners) {
    List<double?> layPrices = [];
    List<double?> laySizes = [];

    for (var runner in runners) {
      final lay = (runner.ex?.availableToLay != null &&
              runner.ex!.availableToLay!.isNotEmpty)
          ? runner.ex!.availableToLay!.first
          : null;
      layPrices.add(lay?.price ?? 0);
      laySizes.add(lay?.size ?? 0);
    }

    // Make sure length is at least 3
    while (layPrices.length < 3) layPrices.add(0);
    while (laySizes.length < 3) laySizes.add(0);

    List<Widget> boxes = [];
    int len = layPrices.length;

    bool lastTwoZero = layPrices[len - 1] == 0 &&
        laySizes[len - 1] == 0 &&
        layPrices[len - 2] == 0 &&
        laySizes[len - 2] == 0;

    for (int i = 0; i < 3; i++) {
      if (lastTwoZero && i == 1) {
        boxes.add(_buildBox('-', '-', Colors.pink[100]));
      } else {
        boxes.add(_buildBox(layPrices[i], laySizes[i], Colors.pink[100]));
      }
    }

    return boxes;
  }

// Your existing _buildBox method with '-' support
  Widget _buildBox(dynamic price, dynamic size, Color? color) {
    return Container(
      width: 53.w,
      height: 38.h,

      //padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),

      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(

            (price == null || price == 0)
                ? "0"
                : (price == '-')
                    ? '-'
                    : (price % 1 == 0
                        ? price.toInt().toString()
                        : price.toString()),
            style: TextStyle(
                fontSize: 14.sp,
                height: 1.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          Text(
            (size == '-') ? '-' : "${formatNumber(size ?? 0)}",

              (price == null || price == 0)
                  ? "0"
                  : (price % 1 == 0)
                      ? price.toInt().toString()
                      : price.toString(),
              style: TextStyle(
                  fontSize: 14.sp,
                  height: 1.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          Text(
            "${formatNumber(size ?? 0)}",

            style: TextStyle(fontSize: 10.sp, height: 1.0, color: Colors.black),
          ),
        ],
      ),
    );
  }

  String formatNumber(double? number) {
    if (number == null || number == 0) return '0';

    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(2)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(2)}K';
    } else {
      return NumberFormat("#,##0.##").format(number); // normal with commas
    }
  }

  String formatDateLabel(String isoDate) {
    DateTime date = DateTime.parse(isoDate).toLocal();
    DateTime now = DateTime.now();

    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime tomorrow = today.add(Duration(days: 1));
    DateTime eventDate = DateTime(date.year, date.month, date.day);

    if (eventDate == today) {
      return "Today";
    } else if (eventDate == tomorrow) {
      return "Tomorrow";
    } else {
      return DateFormat('E, dd MMM').format(eventDate);
    }
  }

  String formatDateTime(String isoDateTime) {
    DateTime utcTime = DateTime.parse(isoDateTime).toUtc();
    // Add 5 hours to match website time (UTC+5)
    DateTime adjustedTime = utcTime.add(Duration(hours: 5));

    // Format as Sat 15:00
    return DateFormat('E\nHH:mm').format(adjustedTime);
  }

  Widget _buildContainer(String title) {
    return Container(
      width: double.infinity,
      height: 28.h,
      color: AppColors.blackthemeColor,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: AutoSizeText(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                  color: AppColors.whiteColor),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(40.h),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.baryelowColor, AppColors.barorngColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: AppBar(
          toolbarHeight: 40.h,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 112.w,
                    height: 13.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/stakefair.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.w),
                    child: Text(
                      'EXCHANGE',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () => homeController.isSearchFieldVisible.toggle(),
                    child: _buildIconButton(
                      Icons.search_rounded,
                      'Search',
                      width: 45.w,
                    ),
                  ),
                  SizedBox(width: 3.w), // Thoda zyada spacing
                  InkWell(
                    onTap: () {
                      Get.toNamed('/login');
                    },
                    child: _buildIconButton(
                      Icons.person,
                      'Login / Join',
                      width: 63.w,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String text, {required double width}) {
    return Container(
      width: width.w,
      height: 30.h,
      decoration: BoxDecoration(
        color: AppColors.apbarbutonColor,
        borderRadius: BorderRadius.circular(2.r), // Responsive radius
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: AppColors.whiteColor,
            size: 15.sp, // Responsive icon size
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 10.sp, // Responsive font
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(Size mediaQuery, {Key? key}) {
    return Container(
      key: key,
      width: mediaQuery.width.w,
      height: 45.h,
      color: AppColors.blackthemeColor,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 32.h,
              child: TextFormField(
                cursorColor: Colors.grey,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder()),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => homeController.isSearchFieldVisible.value = false,
            child: AutoSizeText(
              "Cancel",
              style: TextStyle(color: AppColors.whiteColor, fontSize: 10.sp),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorseRacingSection(String title, String eventName) {
    final CompetitonController competitionController =
        Get.find<CompetitonController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContainer(title),
        // Sample code snippet in CompetitonScreen widget
        Obx(() {
          if (competitionController.categoryListModel.value == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final competitions = competitionController
                .categoryListModel.value?.data?.competitions;

            // Yahan hum optional chaining use kar rahe hain for lowerCase
            final filteredCompetitions = (competitions ?? [])
                .where((comp) =>
                    comp.eventType?.name?.toLowerCase() ==
                    eventName.toLowerCase())
                .toList();

            if (filteredCompetitions.isEmpty) {
              return Center(
                  child: Text("No Competitions Found for ${eventName}"));
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredCompetitions.length,
              itemBuilder: (context, index) {
                var competition = filteredCompetitions[index];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: ListTile(
                        onTap: () {
                          //Get.to(() => CompitationMarketList());
                          log('${competition.competition?.id}');
                        },
                        visualDensity:
                            const VisualDensity(horizontal: -4, vertical: -4),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 0),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            competition.competition?.name ??
                                "Unknown Competition",
                            style: TextStyle(fontSize: 11.sp),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 12.r,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const Divider(height: 0.3, thickness: 0.3),
                  ],
                );
              },
            );
          }
        })
      ],
    );
  }

  Widget _buildNavItem({
    required int index,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    bool isSelected = (index == homeController.selectedIndex.value);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40.h, // Fixed height; adjust if needed.
          decoration: BoxDecoration(
            color: isSelected ? AppColors.blackthemeColor : AppColors.greyColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.orange : Colors.white,
                size: 20.r,
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10.sp,
                  height: 1.0,
                  color: Colors.white,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItemWithAsset({
    required int index,
    required String label,
    required String assetPath,
    required VoidCallback onTap,
  }) {
    bool isSelected = (index == homeController.selectedIndex.value);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40.h,
          decoration: BoxDecoration(
              color:
                  isSelected ? AppColors.blackthemeColor : AppColors.greyColor),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  assetPath,
                  width: 22.r,
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10.sp,
                    height: 1.0,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

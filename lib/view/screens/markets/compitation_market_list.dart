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

            // 🔄 Group by date
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
                  mainAxisSize: MainAxisSize.min,
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
                                  width: 35.w,
                                  height: 50.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    border: Border(
                                      bottom: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  child: Text(
                                    formatDateTime(competition.marketStartTime.toString()),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 9.sp,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    '${competition.event!.name}',
                                    style: TextStyle(fontSize: 11.sp),
                                  ),
                                ),
                                // SizedBox(width: 30.w),
                                Container(
                                  width: 174.w,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        // Blue Boxes
                                        ...competition.runners!.map((runner) {
                                          final back =
                                              (runner.ex?.availableToBack !=
                                                          null &&
                                                      runner
                                                          .ex!
                                                          .availableToBack!
                                                          .isNotEmpty)
                                                  ? runner.ex!.availableToBack!
                                                      .first
                                                  : null;

                                          return _buildBox(back?.price,
                                              back?.size, Colors.blue[100]);
                                        }),

                                        // Pink Boxes
                                        ...competition.runners!.map((runner) {
                                          final lay = (runner
                                                          .ex?.availableToLay !=
                                                      null &&
                                                  runner.ex!.availableToLay!
                                                      .isNotEmpty)
                                              ? runner.ex!.availableToLay!.first
                                              : null;

                                          return _buildBox(lay?.price,
                                              lay?.size, Colors.pink[100]);
                                        }),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(height: 0.3, thickness: 0.3)
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

  Widget _buildBox(double? price, double? size, Color? color) {
    return Container(
      width: 46.w,
      height: 34.h,
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
                  : (price % 1 == 0)
                      ? price.toInt().toString()
                      : price.toString(),
              style: TextStyle(
                  fontSize: 10.sp,
                  height: 1.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          Text(
            "${formatNumber(size ?? 0)}",
            style: TextStyle(fontSize: 8.sp, color: Colors.black),
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

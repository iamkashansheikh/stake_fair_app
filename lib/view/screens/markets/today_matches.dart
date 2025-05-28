import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stake_fair_app/res/app_colors/app_colors.dart';
import 'package:stake_fair_app/res/responsive.dart';
import 'package:stake_fair_app/scrollable.dart';
import '../../../controllers/Home/all_event_list_controller.dart';
import '../../../controllers/Home/home_controller.dart';

class TodayMatches extends StatefulWidget {
  final bool
      showTomorrow; // agar true hua to kal ke matches show karo, warna aaj ke

  const TodayMatches({super.key, this.showTomorrow = false});

  @override
  State<TodayMatches> createState() => _TodayMatchesState();
}

class _TodayMatchesState extends State<TodayMatches> {
  final HomeController homeController = Get.find<HomeController>();
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
                      _buildTodayMatchesSection(),
                      Obx(() => AnimatedPositioned(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            top: homeController.isSearchFieldVisible.value
                                ? 0
                                : -80,
                            left: 0,
                            right: 0,
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: homeController.isSearchFieldVisible.value
                                  ? 1.0
                                  : 0.0,
                              child: _buildSearchField(mediaQuery),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildTodayMatchesSection() {
    final AllEventListController controller = Get.put(AllEventListController());

    // Fetch data on widget build
    controller.fetchAllEvent();

    return Obx(() {
      if (controller.model.value == null) {
        return Container(
            margin: EdgeInsets.only(top: 250),
            child: const Center(child: CircularProgressIndicator()));
      }

      if (controller.errorMessage.value != null) {
        return Center(
          child: Text(
            controller.errorMessage.value!,
            style: const TextStyle(color: Colors.red),
          ),
        );
      }

      final competitions = controller.model.value!.data!.the4;

      if (competitions == null || competitions.isEmpty) {
        return const Center(child: Text("No Events Found"));
      }

      // 🔽 Filter only today's matches
      DateTime now = DateTime.now();

      DateTime filterDate;
      if (widget.showTomorrow) {
        filterDate =
            DateTime(now.year, now.month, now.day).add(Duration(days: 1));
      } else {
        filterDate = DateTime(now.year, now.month, now.day);
      }
      List<dynamic> filteredMatches = competitions.where((comp) {
        DateTime openDate = DateTime.parse(comp.event!.openDate.toString());
        return openDate.year == filterDate.year &&
            openDate.month == filterDate.month &&
            openDate.day == filterDate.day;
      }).toList();

      if (filteredMatches.isEmpty) {
        return Center(
            child: Text(widget.showTomorrow
                ? "No Matches Tomorrow"
                : "No Matches Today"));
      }

      if (filteredMatches.isEmpty) {
        return const Center(child: Text("No Matches Today"));
      }

      // 🔽 Group by date (Though only today's data is shown)
      Map<String, List<dynamic>> groupedByDate = {};
      for (var comp in filteredMatches) {
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
                            color: Colors.grey[100],
                            child: Center(
                              child: Text(
                                formatDateTime(
                                    competition.marketStartTime.toString()),
                                style: TextStyle(
                                    fontSize: 9.sp, color: Colors.black),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                '${competition.event!.name}',
                                style: TextStyle(fontSize: 11.sp),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...List.generate(
                                    (competition.runners!.length / 3).ceil(),
                                    (groupIndex) {
                                      final start = groupIndex * 3;
                                      final end = (start + 3 >
                                              competition.runners!.length)
                                          ? competition.runners!.length
                                          : start + 3;

                                      final group = competition.runners!
                                          .sublist(start, end);

                                      return Row(
                                        children: [
                                          // 🔵 3 blue (back) boxes with middle empty (grey)
                                          ...List.generate(3, (i) {
                                            int mappedIndex =
                                                i == 1 ? -1 : (i == 0 ? 0 : 1);
                                            if (i == 1) {
                                              // Always middle box: grey empty
                                              return _buildBox(
                                                  null, null, Colors.grey[100]);
                                            } else if (mappedIndex <
                                                group.length) {
                                              final runner = group[mappedIndex];
                                              final back =
                                                  (runner.ex?.availableToBack !=
                                                              null &&
                                                          runner
                                                              .ex!
                                                              .availableToBack!
                                                              .isNotEmpty)
                                                      ? runner
                                                          .ex!
                                                          .availableToBack!
                                                          .first
                                                      : null;
                                              return _buildBox(back?.price,
                                                  back?.size, Colors.blue[100]);
                                            } else {
                                              return _buildBox(
                                                  null, null, Colors.blue[100]);
                                            }
                                          }),

                                          // 🔴 3 pink (lay) boxes with middle empty (red)
                                          ...List.generate(3, (i) {
                                            int mappedIndex =
                                                i == 1 ? -1 : (i == 0 ? 0 : 1);
                                            if (i == 1) {
                                              // Always middle box: red empty
                                              return _buildBox(
                                                  null,
                                                  null,
                                                  const Color.fromARGB(
                                                      255, 248, 219, 229));
                                            } else if (mappedIndex <
                                                group.length) {
                                              final runner = group[mappedIndex];
                                              final lay =
                                                  (runner.ex?.availableToLay !=
                                                              null &&
                                                          runner
                                                              .ex!
                                                              .availableToLay!
                                                              .isNotEmpty)
                                                      ? runner.ex!
                                                          .availableToLay!.first
                                                      : null;
                                              return _buildBox(lay?.price,
                                                  lay?.size, Colors.pink[100]);
                                            } else {
                                              return _buildBox(
                                                  null, null, Colors.pink[100]);
                                            }
                                          }),

                                          const SizedBox(width: 12),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
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
    });
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
    final HomeController homeController = Get.find<HomeController>();
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
    final HomeController homeController = Get.find<HomeController>();
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

  Widget _buildBox(double? price, double? size, Color? color) {
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
}

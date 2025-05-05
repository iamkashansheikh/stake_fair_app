import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/controllers/Home/home_controller.dart';
import 'package:stake_fair_app/controllers/Home/sport_controler.dart';
import 'package:stake_fair_app/res/app_colors/app_colors.dart';
import 'package:stake_fair_app/res/responsive.dart';
import 'package:stake_fair_app/scrollable.dart';
import 'package:stake_fair_app/view/screens/competiton_screen.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final double textScale = MediaQuery.of(context).textScaleFactor;
    final Size mediaQuery = MediaQuery.of(context).size;
    return BaseResponsiveScreen(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xff000000),
          appBar: _buildAppBar(context),
          body: Stack(
            children: [
              NoBounceScrollWrapper(
                  child: Column(
                children: [
                  Center(
                      child: Text(
                    'QUICK LINKS',
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold),
                  )),
                  Row(
                    children: [
                      _buildLinks(
                          'In-Play', () {}, AssetImage('assets/images/2.png')),
                      _buildLinks(
                          'In-Play', () {}, AssetImage('assets/images/2.png')),
                      _buildLinks(
                          'In-Play', () {}, AssetImage('assets/images/2.png')),
                      _buildLinks(
                          'In-Play', () {}, AssetImage('assets/images/2.png'))
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Center(
                      child: Text(
                    'POPULAR SPORTS',
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold),
                  )),
                  _buildSports(),
                   SizedBox(height: 2.h),
                  Center(
                      child: Text(
                    'MORE FORM STAKEFAIR',
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold),
                  )),
                ],
              )),
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
                      onTap: (){
                        homeController.changeIndex(0);
                        Get.toNamed('/homeScreen');
                      }),
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
      height: 31.h,
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

  Widget _buildLinks(String title, VoidCallback onTap, ImageProvider img) {
    return Expanded(
      child: Container(
        width: 90.sw,
        height: 80.h,
        decoration: BoxDecoration(
            color: Color(0xff1E1E1E),
            border: Border.all(color: Colors.grey, width: 0.03)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: img),
            Text(
              title,
              style: TextStyle(color: AppColors.whiteColor, fontSize: 10.sp),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSports() {
    final controller = Get.put(SportsController());

    return Obx(() {
      final sport = controller.categoryList.data?.data ?? [];

      final filteredSports = sport.where((item) {
        final name = item.sportName?.toLowerCase();
        return name == 'cricket' ||
            name == 'tennis' ||
            name == 'soccer' ||
            name == 'horse racing';
      }).toList();

      return Row(
        children: filteredSports.map((item) {
          return GestureDetector(
            onTap: () {
              Get.to(() => CompetitonScreen(
                    categoryId: item.sportId ?? '',
                    eventName: item.sportName ?? '',
                    eventIcon: controller.getIconForSport(item.sportName),
                  ));
            },
            child: Container(
              width: 90.w, // Fixed width
              height: 80.h, // Fixed height
              decoration: BoxDecoration(
                color: const Color(0xff1E1E1E),
                border: Border.all(color: Colors.grey, width: 0.03),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    controller.getIconForSport(item.sportName),
                    color: AppColors.whiteColor,
                    size: 20.r,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    item.sportName ?? '',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      );
    });
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

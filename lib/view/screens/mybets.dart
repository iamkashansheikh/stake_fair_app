import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/controllers/Home/home_controller.dart';
import 'package:stake_fair_app/res/app_colors/app_colors.dart';
import 'package:stake_fair_app/res/responsive.dart';
import 'package:stake_fair_app/scrollable.dart';
import 'package:stake_fair_app/view/screens/cash_out/sportdropdown.dart';
import 'package:stake_fair_app/view/screens/cash_out/widget.dart';

class MyBetsScreen extends StatelessWidget {
  MyBetsScreen({super.key});
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final double textScale = MediaQuery.of(context).textScaleFactor;
    final Size mediaQuery = MediaQuery.of(context).size;
    return BaseResponsiveScreen(
        child: SafeArea(
            child: Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          NoBounceScrollWrapper(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Color(0xffE2E6EA),
                    child: Column(
                      children: [
                        CustomContainer(
                          title: 'My Bets',
                          iconColor: Colors.white,
                          leftIcon: Icons.attach_money,
                          rightIcon: Icons.refresh,
                          color: AppColors.blackthemeColor,
                          height: 30.h,
                          width: double.infinity,
                          textStyle: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          width: 10.sw,
                          height: 100.h,
                          color: Colors.white,
                          child: Center(
                              child: Text('Please Login,to see your Bets',
                                 style: TextStyle(fontSize: 11.sp),
                          )),
                        ),
                       
                        SizedBox(height: 5.h),
                        CustomContainer(
                          title: 'Popular Competitions',
                          color: Colors.white,
                          height: 35.h,
                          width: double.infinity,
                          textStyle: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Divider(
                          thickness: 0.5,
                          height: 0.1,
                        ),
                        CompetitionDropdown(
                          color: Colors.white,
                          title: "Popular Football Competitions",
                          competitions: [
                            "Australian A-League Men betting",
                            "English Premier League betting",
                            "English Championship betting",
                            "English League 1 betting",
                            "English League 2 betting",
                          ],
                          id: 'FootBall',
                        ),
                        Divider(
                          thickness: 0.5,
                          height: 0.1,
                        ),
                        CompetitionDropdown(
                          color: Colors.white,
                          title: "Upconming Horse Races",
                          competitions: [
                            "Matheson Hurdle betting",
                            "Perth Cup 2024 betting",
                            "Magic Millions 2yo C;assic 2024 betting",
                            "Magic Millions 3yo Guineas 2024 betting",
                            "Newmarket Handicap 2024 betting",
                          ],
                          id: 'Horse Racing',
                        ),
                        Divider(
                          thickness: 0.5,
                          height: 0.1,
                        ),
                        CompetitionDropdown(
                          color: Colors.white,
                          title: "Popular Cricket Competitions",
                          competitions: [
                            "Women One Day Internationals betting",
                            "Test Matches betting",
                            "Twenty20 Big Bash betting",
                            "Super Smash T20 betting",
                            "International Twenty20 Matches betting",
                          ],
                          id: 'Cricket',
                        ),
                        Divider(
                          thickness: 0.5,
                          height: 0.1,
                        ),
                        CompetitionDropdown(
                          color: Colors.white,
                          title: "Popular Outrights from all Sports",
                          competitions: [
                            "Twenty20 Big Bash Winer 2023/24 betting",
                            "Twenty20 Big Bash Top Tounament Runscorer betting",
                            "Twenty20 Big Bash Top Tounament Wicket Taker betting",
                            "Twenty20 Big Bash Quinella betting",
                            "Twenty20 Big Bash Reach The Final betting",
                          ],
                          id: 'Popular',
                        ),
                        SizedBox(height: 3.h),
                      ],
                    ),
                  ),
                  _buildFooter(mediaQuery, textScale),
                  _buildWarningText(),
                  SizedBox(height: 5.h),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: _buildSaferGamblingDropdown()),
                      SizedBox(height: 5.h),
                      Center(child: _buildAboutStakefairDropdown()),
                      SizedBox(height: 5.h),
                      _buildText('Help',),
                      _buildText('Affiliates'),
                      _buildText('18+',),
                      _buildText('Developers',),
                      _buildText('StakeFair Exchange Sitemap',),
                      _buildText( 'B2B Partnerships',),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(thickness: 0.6),
                      ),
                      SizedBox(height: 10.h),
                      _buildText('Privacy Policy',),
                      _buildText( 'Cookie Policy',),
                      _buildText('Privacy Preference Centre',),
                      _buildText('Rules & Regulations',),
                      _buildText( 'Terms & Conditions', ),
                      SizedBox(height: 20.h),
                    ],
                  ),
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
                  onTap: () {
                    homeController.changeIndex(0);
                    Get.toNamed('/homeScreen');
                  }),
              _buildNavItem(
                  index: 1,
                  label: 'Menu',
                  icon: Icons.menu,
                  onTap: () {
                    homeController.changeIndex(1);
                    Get.toNamed('/menuScreen');
                  }),
              _buildNavItem(
                  index: 2,
                  label: 'CashOut',
                  icon: Icons.account_balance_wallet,
                  onTap: () {
                    homeController.changeIndex(2);
                    Get.toNamed('/CashoutScreen');
                  }),
              _buildNavItemWithAsset(
                  index: 3,
                  label: 'MyBets',
                  assetPath: 'assets/images/money.png',
                  onTap: () {
                    homeController.changeIndex(3);
                    Get.toNamed('/MyBetsScreen');
                  }),
              _buildNavItemWithAsset(
                  index: 4,
                  label: 'Casino',
                  assetPath: 'assets/images/casino-chip (1).png',
                  onTap: () => homeController.changeIndex(4)),
            ],
          ),
        );
      }),
    )));
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

  Widget _buildFooter(Size mediaQuery, double textScale) {
    return Container(
      height: mediaQuery.height * 0.052.h,
      width: mediaQuery.width.w,
      color: const Color(0xff1E1E1E),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0.r),
            child: Container(
              width: mediaQuery.width * 0.08.w,
              height: mediaQuery.height * 0.08.h,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: const Color(0xffFF0000), width: 1.8)),
              child: Center(
                  child: AutoSizeText(
                '18+',
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
                maxLines: 1,
              )),
            ),
          ),
          SizedBox(width: 7.w),
          Text('Please Gamble Responsibly',
              style: TextStyle(
                  color: Color(0xffC4C4C4),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600),
              maxLines: 1),
          SizedBox(width: 8.w),
          Container(
            width: mediaQuery.width * 0.23.w,
            height: 29.h,
            decoration: BoxDecoration(
              color: const Color(0xffD4D4D4),
              borderRadius: BorderRadius.circular(2.r),
            ),
            alignment: Alignment.center,
            child: Text(
              'More details',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 11.sp,
              ),
              maxLines: 1,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWarningText() {
    return Padding(
      padding: EdgeInsets.all(10.0.r),
      child: RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.black87,
            height: 1.4,
          ),
          children: [
            TextSpan(
              text: 'Warning: ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
            ),
            TextSpan(
              text:
                  'Although the current score, time elapsed, video and other data provided on this site is sourced from \'live\' '
                  'feeds provided by third parties, you should be aware that this data may be subject to a time delay and/or be inaccurate. '
                  'Please also be aware that other StakeFair customers may have access to data that is faster and/or more accurate than the '
                  'data shown on the StakeFair site. If you rely on this data to place bets, you do so entirely at your own risk. StakeFair '
                  'provides this data AS IS with no warranty as to the accuracy, completeness or timeliness of such data and accepts no '
                  'responsibility for any loss (direct or indirect) suffered by you as a result of your reliance on it.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildText(String title) {
    return AutoSizeText(
      title,
      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
      maxLines: 1,
    );
  }

  Widget _buildSaferGamblingDropdown() {
    return Obx(() {
      bool expanded = homeController.isSaferGamblingExpanded.value;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: homeController.isSaferGamblingExpanded.toggle,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AutoSizeText(
                  homeController.saferGambling[0],
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500),
                  maxLines: 1,
                ),
                Icon(
                  expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                ),
              ],
            ),
          ),
          if (expanded)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: homeController.saferGambling
                  .skip(1)
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: AutoSizeText(
                          item,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500),
                          maxLines: 1,
                        ),
                      ))
                  .toList(),
            ),
        ],
      );
    });
  }

  Widget _buildAboutStakefairDropdown() {
    return Obx(() {
      bool expanded = homeController.isAboutStakefairExpanded.value;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: homeController.isAboutStakefairExpanded.toggle,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AutoSizeText(
                  homeController.aboutStakefair[0],
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500),
                  maxLines: 1,
                ),
                Icon(expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              ],
            ),
          ),
          if (expanded)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: homeController.aboutStakefair
                  .skip(1)
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: AutoSizeText(
                          item,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500),
                          maxLines: 1,
                        ),
                      ))
                  .toList(),
            ),
        ],
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

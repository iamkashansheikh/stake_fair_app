import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/controllers/Home/home_controller.dart';
import 'package:stake_fair_app/controllers/Home/inplay_controller.dart';
import 'package:stake_fair_app/res/app_colors/app_colors.dart';
import 'package:stake_fair_app/res/responsive.dart';
import 'package:stake_fair_app/scrollable.dart';
import 'package:stake_fair_app/view/screens/markets/oddsmarket.dart';
import 'package:stake_fair_app/view/screens/markets/widgets_classes/backlay.dart';
import 'package:stake_fair_app/view/screens/markets/widgets_classes/title_container.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  final HomeController homeController = Get.put(HomeController());
  final InplayController inplayController = Get.put(InplayController());
  @override
  Widget build(BuildContext context) {
    final double textScale = MediaQuery.of(context).textScaleFactor;
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
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          _buildScrollableRow(),
                        ],
                      ),

                      // Row(
                      //   children: [
                      //     _buildShowMatches(
                      //         index: 0,
                      //         label: 'Soccer',
                      //         onTap: () =>
                      //             inplayController.selectedIndex.value = 0),
                      //     _buildShowMatches(
                      //       index: 1,
                      //       label: 'Tennis',
                      //       onTap: () => inplayController.selectedIndex.value = 1,
                      //     ),
                      //     _buildShowMatches(
                      //       index: 2,
                      //       label: 'Cricket',
                      //       onTap: () => inplayController.selectedIndex.value = 2,
                      //     ),
                      //   ],
                      // ),
                      _buildTalbe(context),
                      TitleInfoContainer(
                          title: 'Bookmaker IPL CUP',
                          img: AssetImage('assets/images/cash.png'),
                          icon: Icons.timelapse_sharp),
                      BackLayInfoBar(
                          matched: '25.80M', min: '100', max: '100K'),
                      SoccerMarketWidget(
                        title: "Team A",
                        backOdds: [
                          {'price': '2500', 'size': '120000'},
                          {'price': '2.', 'size': '0'},
                          {'price': '0.5', 'size': '10'}
                        ],
                        layOdds: [
                          {'price': '200', 'size': '98880'}
                        ],
                      ),
                      // PlayerMarketTile(title: 'IPL', image: AssetImage('assets/images/market.png'), backOdds: [{'price':'131.343','size':'3.53'}], layOdds: inplayController.oddsList),
                      _buildFooter(mediaQuery, textScale),
                      _buildWarningText(),
                      SizedBox(height: 5.h),
                      Center(child: _buildSaferGamblingDropdown()),
                      SizedBox(height: 5.h),
                      Center(child: _buildAboutStakefairDropdown()),
                      SizedBox(height: 5.h),
                      _buildText('Help'),
                      _buildText('Affiliates'),
                      _buildText('18+'),
                      _buildText('Developers'),
                      _buildText('StakeFair Exchange Sitemap'),
                      _buildText('B2B Partnerships'),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(thickness: 0.6),
                      ),
                      SizedBox(height: 10.h),
                      _buildText('Privacy Policy'),
                      _buildText('Cookie Policy'),
                      _buildText('Privacy Preference Centre'),
                      _buildText('Rules & Regulations'),
                      _buildText('Terms & Conditions'),
                      SizedBox(height: 20.h),
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

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    double appBarHeight = 50;
    double logoWidth = 112;
    double logoHeight = 16;
    double searchButtonWidth = 35;
    double loginButtonWidth = 57;

    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.baryelowColor, AppColors.barorngColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: AppBar(
          toolbarHeight: appBarHeight,
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
                    width: logoWidth.w,
                    height: logoHeight.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/stakefair.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 33),
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
                      width: searchButtonWidth.w,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/login');
                    },
                    child: _buildIconButton(
                      Icons.person,
                      'Login / Join',
                      width: loginButtonWidth.w,
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

  Widget _buildIconButton(IconData icon, String text, {double width = 82}) {
    return Container(
      width: width.w,
      height: 33.h,
      decoration: BoxDecoration(
          color: AppColors.apbarbutonColor,
          borderRadius: BorderRadius.circular(2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.whiteColor, size: 15.r),
          Text(text,
              style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600)),
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

  Widget _buildShowMatches({
    required int index,
    required String label,
    required VoidCallback onTap,
  }) {
    return Obx(() {
      bool select = (index == inplayController.selectedIndex.value);
      return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 30.h,
          decoration: BoxDecoration(
            color: select ? const Color(0xffFFFFFF) : const Color(0xffF0F1F5),
            border: select
                ? Border(top: BorderSide(color: Colors.black, width: 2.w))
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10.sp,
                height: 1.0,
                color: Colors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis, // Prevent overflow
            ),
          ),
        ),
      );
    });
  }

  Widget _buildScrollableRow() {
    return Container(
      width: MediaQuery.of(context).size.width, // Use full screen width
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
            inplayController.matchLabels.length,
            (index) => _buildShowMatches(
              index: index,
              label: inplayController.matchLabels[index],
              onTap: () => inplayController.selectedIndex.value = index,
            ),
          ),
        ),
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
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: mediaQuery.width * 0.07.w,
              height: mediaQuery.height * 0.07.h,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: const Color(0xffFF0000), width: 1.8)),
              child: Center(
                  child: AutoSizeText(
                '18+',
                style: TextStyle(color: Colors.white, fontSize: 13.sp),
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
            width: mediaQuery.width * 0.22.w,
            height: 31.h,
            decoration: BoxDecoration(
              color: const Color(0xffD4D4D4),
              borderRadius: BorderRadius.circular(2),
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
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Warning',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text:
                  " : Although the current score, time elapsed, video and other ",
              style: TextStyle(
                fontSize: 11.sp,
                color: Colors.black,
              ),
            ),
            _buildWidgetSpan(
                "data provided on this site is sourced from feeds provided by third",
                0),
            _buildWidgetSpan(
                " parties, you should be aware that this data may be subject to a time",
                2),
            _buildWidgetSpan(
                " delay and/or be inaccurate. Please also be aware that other",
                22),
            _buildWidgetSpan(
                " StakeFair customers may have access to data that is faster and/or ",
                0),
            _buildWidgetSpan(
                "more accurate than the data shown on the StakeFair site. If you rely",
                6),
            _buildWidgetSpan(
                "on this data to place bets, you do so entirely at your own risk.",
                20),
            _buildWidgetSpan(
                " StakeFair provides this data AS IS with no warranty as to the ,",
                0),
            _buildWidgetSpan(
                "accuracy completeness or timeliness of such data and accepts no",
                10),
            _buildWidgetSpan(
                " responsibility for any loss (direct or indirect) suffered by you as a",
                20),
            _buildWidgetSpan(" result of your reliance on it.", 115),
          ],
        ),
      ),
    );
  }

  InlineSpan _buildWidgetSpan(String text, double horizontalPadding) {
    return WidgetSpan(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.black,
          ),
          maxLines: 1,
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

  Widget _buildTalbe(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(color: Color(0xffFFFFFF)),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.042.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.info,
                size: 20.r,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.r),
                height: 28.h,
                decoration: BoxDecoration(
                    color: Color(0xffC2C2C2),
                    borderRadius: BorderRadius.circular(2)),
                child: Center(
                    child: Text(
                  'P&L Tables',
                  style:
                      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400),
                )),
              ),
            ],
          ),
        ));
  }
}

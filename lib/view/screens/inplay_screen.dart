import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/controllers/Home/home_controller.dart';
import 'package:stake_fair_app/controllers/Home/inplay_controller.dart';
import 'package:badges/badges.dart' as badges;
import 'package:stake_fair_app/res/app_colors/app_colors.dart';
import 'package:stake_fair_app/res/responsive.dart';
import 'package:stake_fair_app/scrollable.dart';

class InplayScreen extends StatefulWidget {
  const InplayScreen({super.key});

  @override
  State<InplayScreen> createState() => _InplayScreenState();
}

class _InplayScreenState extends State<InplayScreen> {
  final HomeController homeController = Get.put(HomeController());
  final InplayController inplayController = Get.put(InplayController());

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double textScale = MediaQuery.of(context).textScaleFactor;
    return BaseResponsiveScreen(
      child: SafeArea(
        child: Scaffold(
          
          backgroundColor: AppColors.whiteColor,
          appBar:_buildAppBar(context),
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              NoBounceScrollWrapper(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildContainer(
                        'In-Play',
                        Icon(
                          Icons.timelapse,
                          color: AppColors.whiteColor,
                          size: 18.r,
                        ),
                      ),
                      SizedBox(
                        height: 05.h,
                      ),
                      Row(
                        children: [
                          _buildShowMatches(
                              index: 0,
                              label: 'Soccer',
                              badge: badges.Badge(
                                badgeStyle: badges.BadgeStyle(
                                    badgeColor: AppColors.inplaybtnColor,
                                    shape: badges.BadgeShape.square,
                                    padding: EdgeInsets.zero),
                                badgeContent: SizedBox(
                                  width: 22.w,
                                  height: 12.h,
                                  child: Center(
                                    child: Text('1',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 9.sp)),
                                  ),
                                ),
                                child:  Icon(Icons.sports_soccer,
                                    color: Colors.black,size: 18.r,),
                              ),
                              onTap: () =>
                                  inplayController.selectedIndex.value = 0),
                          _buildShowMatches(
                            index: 1,
                            label: 'Tennis',
                            badge: badges.Badge(
                              badgeStyle: badges.BadgeStyle(
                                badgeColor: AppColors.inplaybtnColor,
                                shape: badges.BadgeShape.square,
                                padding: EdgeInsets.zero,
                              ),
                              badgeContent: SizedBox(
                                width: 22.w,
                                height: 12.h,
                                child: Center(
                                  child: Text(
                                    '2',
                                    style:  TextStyle(
                                        color: Colors.white, fontSize: 9.sp),
                                  ),
                                ),
                              ),
                              child:  Icon(Icons.sports_tennis,
                                  color: Colors.black,size: 18.r,),
                            ),
                            onTap: () =>
                                inplayController.selectedIndex.value = 1,
                          ),
                          _buildShowMatches(
                            index: 2,
                            label: 'Cricket',
                            badge: badges.Badge(
                              badgeStyle: badges.BadgeStyle(
                                  badgeColor: AppColors.inplaybtnColor,
                                  shape: badges.BadgeShape.square,
                                  padding: EdgeInsets.zero),
                              badgeContent: SizedBox(
                                width: 22.w,
                                height: 12.h,
                                child: Center(
                                  child: Text('5',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 9.sp)),
                                ),
                              ),
                              child:  Icon(Icons.sports_cricket,
                                  color: Colors.black,size: 18.r,),
                            ),
                            onTap: () =>
                                inplayController.selectedIndex.value = 2,
                          ),
                        ],
                      ),
                      SizedBox(height: 05.h,),
                      Row(
                        children:  [
                          SizedBox(width: 213.w,),
                          Text('1',
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10.sp)),
                                  SizedBox(width: 50.w,),
                          Text('X',
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10.sp)),
                                  SizedBox(width: 49.w,),
                          Text('2',
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10.sp)),
                        ],
                      ),
                      Divider(
                        thickness: 0.5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('South Korean Soccer',style: TextStyle(fontSize: 11.sp),),
                            Icon(Icons.keyboard_arrow_right,size: 18.r,)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Divider(
                        thickness: 0.5,
                        height: 0,
                      ),
                      Obx(() {
                        if (inplayController.selectedIndex == 0) {
                          return Column(
                            children: [
                              _buildSoccerMarket(),
                              _buildSoccerMarket(),
                              _buildSoccerMarket(),
                              _buildSoccerMarket(),
                              _buildSoccerMarket(),
                            ],
                          );
                        }
                        if (inplayController.selectedIndex == 1) {
                          return _buildTennisMarket();
                        }
                        if (inplayController.selectedIndex == 2) {
                          return _buildCricketMarket();
                        }
                        return _buildCricketMarket();
                      }),
                      const SizedBox(height: 5),
                      _buildFooter(screenSize, textScale),
                      _buildWarningText(),
                      const SizedBox(height: 5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: _buildSaferGamblingDropdown()),
                          const SizedBox(height: 5),
                          Center(
                              child: _buildAboutStakefairDropdown()),
                          const SizedBox(height: 5),
                          _buildText('Help', ),
                          _buildText('Affiliates', ),
                          _buildText('18+', ),
                          _buildText('Developers', ),
                          _buildText('StakeFair Exchange Sitemap', ),
                          _buildText('B2B Partnerships', ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Divider(thickness: 0.6),
                          ),
                          const SizedBox(height: 10),
                          _buildText('Privacy Policy', ),
                          _buildText('Cookie Policy', ),
                          _buildText('Privacy Preference Centre', ),
                          _buildText('Rules & Regulations', ),
                          _buildText('Terms & Conditions', ),
                          const SizedBox(height: 20),
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
                      child: _buildSearchField(screenSize, ),
                    ),
                  )),
            ],
          ),
          bottomNavigationBar: Obx(() {
            return Container(
              color: const Color(0xff525252),
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
          automaticallyImplyLeading: true,
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

  Widget _buildContainer(String title, Icon icon) {
    return Container(
      width: double.infinity,
      height: 28.h,
      color: AppColors.blackthemeColor,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
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

  Widget _buildShowMatches({
    required int index,
    required String label,
    required Widget badge,
    required VoidCallback onTap,
  }) {
    return Obx(() {
      bool select = (index == inplayController.selectedIndex.value);
      return Expanded(
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 50.h,
            decoration: BoxDecoration(
                color:
                    select ? const Color(0xffFFFFFF) : const Color(0xffF0F1F5),
                border: select
                    ? Border(top: BorderSide(color: Colors.black, width: 2))
                    : null),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                badge,
                 SizedBox(height: 1.h),
                Text(
                  label,
                  style: TextStyle(
                      fontSize: 10.sp,
                      height: 1.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildTennisMarket() {
    inplayController.fetchOdds();
        return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 35.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.inplaybtnColor,
                  border: Border(
                    bottom: BorderSide(color: Colors.white),
                  ),
                ),
                child:  Text(
                  'In-Play',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9.sp,
                  ),
                ),
              ),
               SizedBox(width: 13.w),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text(
                      'James Kent',
                      style: TextStyle(fontSize: 10.sp),
                    ),
                    Text(
                      'Viktor',
                      style: TextStyle(fontSize: 10.sp),
                    ),
                  ],
                ),
              ),
              Container(
                width: 174.w,
                child: Obx(() {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    child: Row(
                      children: inplayController.oddsList
                          .asMap()
                          .entries
                          .map((entry) {
                        int index = entry.key;
                        final item = entry.value;
                        final Color bgColor = index < 3
                            ? AppColors.markitblueColor
                            : AppColors.markitpinkColor;
                        return Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: _buildOddsBox(
                            backgroundColor: bgColor,
                            odds: '${item["odds"]}',
                            amount: '${item["price"]}',
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 0.5,
          height: 0.2,
        ),
      ],
    );
  }

  Widget _buildCricketMarket() {
    inplayController.fetchOdds();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 35.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.inplaybtnColor,
                  border: Border(
                    bottom: BorderSide(color: Colors.white),
                  ),
                ),
                child:  Text(
                  'In-Play',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9.sp,
                  ),
                ),
              ),
               SizedBox(width: 13.w),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text(
                      'ICC Trophy',
                      style: TextStyle(fontSize: 10.sp),
                    ),
                    Text(
                      'Indian Premier League',
                      style: TextStyle(fontSize: 10.sp),
                    ),
                  ],
                ),
              ),
              Container(
                width: 174.w,
                child: Obx(() {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    child: Row(
                      children: inplayController.oddsList
                          .asMap()
                          .entries
                          .map((entry) {
                        int index = entry.key;
                        final item = entry.value;
                        final Color bgColor = index < 3
                            ? AppColors.markitblueColor
                            : AppColors.markitpinkColor;
                        return Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: _buildOddsBox(
                            backgroundColor: bgColor,
                            odds: '${item["odds"]}',
                            amount: '${item["price"]}',
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 0.5,
          height: 0.2,
        ),
      ],
    );
  }

  Widget _buildSoccerMarket() {
    inplayController.fetchOdds();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 35.w,
                height: 50.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.inplaybtnColor,
                  border: Border(
                    bottom: BorderSide(color: Colors.white),
                  ),
                ),
                child:  Text(
                  'In-Play',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9.sp,
                  ),
                ),
              ),
               SizedBox(width: 13.w),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text(
                      'FiFa World Cup',
                      style: TextStyle(fontSize: 10.sp),
                    ),
                    Text(
                      'Portugal Team',
                      style: TextStyle(fontSize: 10.sp),
                    ),
                  ],
                ),
              ),
              Container(
                width: 174.w,
                child: Obx(() {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    child: Row(
                      children: inplayController.oddsList
                          .asMap()
                          .entries
                          .map((entry) {
                        int index = entry.key;
                        final item = entry.value;
                        final Color bgColor = index < 3
                            ? AppColors.markitblueColor
                            : AppColors.markitpinkColor;
                        return Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: _buildOddsBox(
                            backgroundColor: bgColor,
                            odds: '${item["odds"]}',
                            amount: '${item["price"]}',
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 0.5,
          height: 0.2,
        ),
      ],
    );
  }

  Widget _buildOddsBox({
    required Color backgroundColor,
    required String odds,
    required String amount,
  }) {
    return Container(
      width: 53.w,
      height: 38.h,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            odds,
            style:  TextStyle(
                fontWeight: FontWeight.w600, fontSize: 14.sp, height: 1.0),
          ),
          Text(
            amount,
            style:  TextStyle(fontSize: 10.sp, height: 1.0),
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
}

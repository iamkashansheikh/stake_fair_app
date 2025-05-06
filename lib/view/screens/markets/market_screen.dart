import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/checkdata.dart';
import 'package:stake_fair_app/controllers/Home/home_controller.dart';
import 'package:stake_fair_app/controllers/Home/inplay_controller.dart';
import 'package:stake_fair_app/res/app_colors/app_colors.dart';
import 'package:stake_fair_app/res/responsive.dart';
import 'package:stake_fair_app/scrollable.dart';
import 'package:stake_fair_app/view/screens/markets/oddsmarket.dart';
import 'package:stake_fair_app/view/screens/markets/placebetods.dart';
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
  bool showPlaceBet = false;
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

                      _buildTalbe(context),
                      Column(
                        children: [
                          TitleInfoContainer(
                            title: 'Bookmaker IPL CUP',
                            img: AssetImage('assets/images/cash.png'),
                            icon: Icons.timelapse_sharp,
                            onTap: () {
                              Get.dialog(
                                BaseResponsiveScreen(
                                  child: Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Center(
                                        child: SizedBox(
                                          height: 225.h,
                                          child: Container(
                                            width: 255.w,
                                            child: _buildShowCashWidget(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                barrierDismissible:
                                    true, // Tap outside to dismiss
                                barrierColor: Colors.black
                                    .withOpacity(0.6), // Dim background
                              );
                            },
                          ),
                        ],
                      ),

                      BackLayInfoBar(
                          matched: '25.80M', min: '100', max: '100K'),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showPlaceBet = !showPlaceBet;
                              });
                            },
                            child: OddsMarketWidget(
                              title: "Team A",
                              backOdds: [
                                {'price': '2500', 'size': '120000'},
                              ],
                              layOdds: [
                                {'price': '200', 'size': '98880'}
                              ],
                            ),
                          )
                        ],
                      ),
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        child: showPlaceBet
                            ? SizedBox(
                                height: 219.h,
                                child: _buildBets(() {
                                  setState(() {
                                    showPlaceBet = false;
                                  });
                                })) // Constrain the size
                            : SizedBox.shrink(),
                      ),
                      SizedBox(height: 5.h),
                      _buildRotateContainer(
                          'All Markets', () {}, Icons.keyboard_arrow_right),
                      Divider(
                        thickness: 0.3,
                      ),
                      _buildRotateContainer(
                        'Rotate Screen to see market depth',
                        () {},
                        Icons.screen_rotation,
                      ),
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
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
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
    return PreferredSize(
      preferredSize:Size.fromHeight(40.h),
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
          padding: EdgeInsets.symmetric(horizontal: 10.w),
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

  Widget _buildRotateContainer(
      String title, VoidCallback onTap, IconData icon) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity.w,
        height: 28.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
        //decoration: BoxDecoration(border: Border(top: BorderSide(width: 0.3))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AutoSizeText(
              title,
              style: TextStyle(
                fontSize: 10.sp,
              ),
              maxLines: 1,
            ),
            Icon(icon, color: Colors.black, size: 22.r),
          ],
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
              GestureDetector(
                onTap: () {
                  Get.toNamed('/ruleScreen');
                },
                child: Icon(
                  Icons.info,
                  size: 20.r,
                ),
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

  Widget _buildBets(VoidCallback onCancel) {
    final BetController controller = Get.put(BetController());
    return SizedBox(
      height: 220.h,
      child: Column(
        children: [
          Container(
            width: double.infinity.w,
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: const Color(0xffDBEFFF),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.blackthemeColor,
                      ),
                    ),
                    Text(
                      ' (BetFor): ',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    Expanded(
                      child: Text(
                        'Almeria - Match Odds',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Expanded(
                      child: _buildBackOdData(context, 0),
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                        child: _buildNumberValue(
                            () => controller.betInput.value, 1)),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                        child: _buildActionButton(
                            'Cancel', const Color(0xffDCDCDC), Colors.black,
                            () {
                      onCancel();
                    })),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: _buildActionButton('Place Bet',
                          const Color(0xffFFDC86), Colors.black87, () {}),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    _buildNumberButton('+25'),
                    SizedBox(width: 1.w),
                    _buildNumberButton('+50'),
                    SizedBox(width: 1.w),
                    _buildNumberButton('+100'),
                    SizedBox(width: 1.w),
                    _buildNumberButton('+125')
                  ],
                ),
                SizedBox(height: 1.h),
                CustomKeypad(
                  onKeyTap: (val) => controller.onKeyTap(val),
                  onBackspace: () => controller.onBackspace(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBackOdData(BuildContext context, int idx) {
    final BetController controller = Get.put(BetController());
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          _buildButton('-', () => controller.Inc(idx)),
          Expanded(
            child: Center(
                child: Obx(
              () => Text(
                controller.selectorValues[idx].toString(),
                style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500),
              ),
            )),
          ),
          _buildButton('+', () => controller.Dec(idx)),
        ],
      ),
    );
  }

  Widget _buildNumberValue(VoidCallback onTap, int idx) {
    final BetController controller = Get.put(BetController());
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            _buildButton('-', () => controller.decrement(idx)),
            Expanded(
              child: Center(
                child: Obx(
                  () => Text(
                    controller.betInput.value, // SHOWING TYPED VALUE
                    style:
                        TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            _buildButton('+', () => controller.increment(idx)),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28.w,
        height: 25.h,
        decoration: BoxDecoration(
          color: const Color(0xffDCDCDC),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String title, Color bg, Color fg, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 25.h,
        decoration: BoxDecoration(
          color: bg,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              color: fg,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNumberButton(var label) {
    final BetController controller = Get.put(BetController());
    return InkWell(
      onTap: () => controller.addPreset(label),
      child: Container(
        width: 89.w,
        height: 35.h,
        decoration: BoxDecoration(
          color: const Color(0xffDCDCDC),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShowCashWidget() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildHeader('Cash Out'),
          _buildInfoRow('Liability', '\$25.00', Colors.black),
          _buildInfoRow('Cash Out', '\$24.76', Colors.black),
          _buildInfoRow('Profit', '-\$0.24', Colors.red),
          Divider(thickness: 0.5),
          _buildNote(),
          SizedBox(height: 10.h),
          _buildActionButtons(),
          SizedBox(height: 8.h),
          _buildToggleSwitch('Show Cash Out confirmation screen'),
        ],
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Container(
      width: double.infinity,
      height: 25.h,
      color: AppColors.blackthemeColor,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: AutoSizeText(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12.sp,
          color: AppColors.whiteColor,
        ),
        maxLines: 1,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 10.sp)),
          Text(value,
              style: TextStyle(
                  fontSize: 10.sp, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildNote() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
      ),
      child: Text(
        'If the odds change during submission, the amount may be increased, rejected or partially accepted.',
        style: TextStyle(
          fontSize: 11.sp,
          height: 1.0.h,
          letterSpacing: 0,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildConfirmButton('Cancel', const Color(0xffdcdcdc)),
          _buildConfirmButton('Confirm', const Color(0xffffb80a)),
        ],
      ),
    );
  }

  Widget _buildConfirmButton(String label, Color bgColor) {
    return GestureDetector(
      onTap: () {
        if (label == 'Cancel') {
          Get.back(); // Close the dialog
        } else {
          // Handle Confirm action here
        }
      },
      child: Container(
        width: 110.w,
        height: 25.h,
        color: bgColor,
        alignment: Alignment.center,
        child: AutoSizeText(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 10.sp,
            color: AppColors.blackthemeColor,
          ),
          maxLines: 1,
        ),
      ),
    );
  }

  Widget _buildToggleSwitch(String title) {
    final BetController betController = Get.put(BetController());
    return Container(
      width: double.infinity.w,
      height: 35.h,
      color: const Color(0xfff0f1f4),
      //  padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: AutoSizeText(
                title,
                style: TextStyle(
                    fontSize: 10.sp, color: AppColors.blackthemeColor),
                maxLines: 1,
              ),
            ),
          ),
          Obx(() => Expanded(
                child: Switch(
                  value: betController.isOn.value,
                  onChanged: (val) => betController.toggle(),
                  activeColor: Colors.white,
                  activeTrackColor: Colors.green,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.transparent,
                  splashRadius: 0,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              )),
        ],
      ),
    );
  }
}

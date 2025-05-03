import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/controllers/Home/home_controller.dart';
import 'package:stake_fair_app/res/app_colors/app_colors.dart';
import 'package:stake_fair_app/res/responsive.dart';

class RulesScreen extends StatefulWidget {
  RulesScreen({super.key});

  @override
  State<RulesScreen> createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen> {
  final HomeController homeController = Get.put(HomeController());
  
  @override
  void initState() {
    super.initState();
    homeController.isExpanded.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return BaseResponsiveScreen(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: Column(
            children: [
              _buildContainer('Rules'),
              bettingInfoTile(),
              _buildQuickLinksSection('title'),
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

  Widget _buildContainer(String title) {
    return Container(
      width: double.infinity.w,
      height: 36.h,
      color: AppColors.blackthemeColor,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13.sp,
                color: AppColors.whiteColor),
            maxLines: 1,
          ),
          GestureDetector(child: Icon(Icons.clear,color: Colors.white,size: 22.r,),onTap: () {
            Get.back();
          },)
        ],
      ),
    );
  }

  Widget bettingInfoTile() {
    final controller = Get.find<HomeController>();
    return Container(
      decoration: BoxDecoration(
          color: AppColors.greyColor,
          border:
              Border(bottom: BorderSide(width: 0.2.w, color: Colors.white))),
      child: Column(
        children: [
          InkWell(
            onTap: controller.toggleExpanded,
            child: Container(
              height: 32.h,
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              color: AppColors.greyColor,
              child: Row(
                children: [
                  Icon(Icons.keyboard_arrow_down,
                      color: Colors.white, size: 16.r),
                  SizedBox(width: 7.w),
                  Text(
                    'Match Odds',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(() {
            if (!controller.isExpanded.value) return const SizedBox.shrink();
            return Container(
              color: Colors.white,
              width: double.infinity.w,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _labelValue('Event Start Time', '26 January 2024 23:45'),
                  SizedBox(height: 6.h),
                  _labelValue('Rules', 'Win Only Market'),
                  SizedBox(height: 4.h),
                  Text(
                    "Predict the result of this match. All bets apply to Full Time "
                    "according to the match officials, plus any stoppage time. "
                    "Extra-time/penalty shoot-outs are not included. For further "
                    "information please see ",
                    style: TextStyle(
                        fontSize: 10.sp, color: Colors.black, letterSpacing: 0),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Rules & Regs",
                      style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.blue,
                          letterSpacing: 0),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  _labelValue('Wallet', 'UK wallet'),
                  SizedBox(height: 6.h),
                  _labelValue('Commission on this market',
                      'Log in to see your commission rate'),
                  SizedBox(height: 4.h),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Your Discount Rate Explained",
                      style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.blue,
                          letterSpacing: 0),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _labelValue(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10.sp,
              color: Colors.black,
              letterSpacing: 0),
        ),
        Text(
          value,
          style: TextStyle(
              fontSize: 10.sp, color: Colors.black87, letterSpacing: 0),
        ),
      ],
    );
  }

  Widget _buildQuickLinksSection(
    String title,
  ) {
    final rulesList = homeController.ruleInfo;
    if (rulesList.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return Container(
      color: AppColors.greyColor,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: homeController.ruleInfo.length,
        itemBuilder: (context, index) {
          final rules = rulesList[index];
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ListTile(
                  dense: true,
                  minLeadingWidth: 0,
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: -4),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 0),
                  leading: Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.whiteColor,
                    size: 16.r,
                  ),
                  title: AutoSizeText(
                    rules,
                    style:
                        TextStyle(fontSize: 10.sp, color: AppColors.whiteColor),
                    maxLines: 1,
                  ),
                ),
              ),
              const Divider(height: 0.3, thickness: 0.3),
            ],
          );
        },
      ),
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

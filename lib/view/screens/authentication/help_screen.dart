import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../res/app_colors/app_colors.dart';
import 'package:stake_fair_app/res/responsive.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> infoList = [
    {
      "title":
          'Liverpool v Fulham Featured OddsBoost - D Nunez to have 2+ shots on target & J Palhinha to commit 2+ fouls',
      "desc":
          'Nunez is not starting for Liverpool. Featured Oddsboost will be settled on remaining legs at evens (1/1) unless Nunez comes on in which case will be settled as normal. Cashout open until KO.',
    },
    {
      "title":
          'Liverpool v Fulham Featured OddsBoost - D Nunez to have 2+ shots on target & J Palhinha to commit 2+ fouls',
      "desc":
          'Nunez is not starting for Liverpool. Featured Oddsboost will be settled on remaining legs at evens (1/1) unless Nunez comes on in which case will be settled as normal. Cashout open until KO.',
    },
  ];

  final List<Map<String, String>> actionTiles = [
    {'title': 'Login & Registration', 'image': 'assets/images/h1.png'},
    {'title': 'Promotions & Rewards', 'image': 'assets/images/2.png'},
    {'title': 'Deposits & Withdrawals', 'image': 'assets/images/3.png'},
    {'title': 'Football Season 2023/24', 'image': 'assets/images/4.png'},
    {'title': 'Verifying Your Account', 'image': 'assets/images/5.png'},
    {'title': 'Sports', 'image': 'assets/images/6.png'},
    {'title': 'Gaming', 'image': 'assets/images/7.png'},
    {'title': 'Safer Gambling', 'image': 'assets/images/8.png'},
    {'title': 'Other', 'image': 'assets/images/9.png'},
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _autoSlide);
  }

  void _autoSlide() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 4));
      _currentPage = (_currentPage + 1) % infoList.length;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BaseResponsiveScreen(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: size.height * 0.35,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bgImg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.01),
                    SizedBox(
                      width: double.infinity,
                      height: size.height * 0.185,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: infoList.length,
                        itemBuilder: (_, index) {
                          final item = infoList[index];
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            padding: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                              color: const Color(0xff354351).withOpacity(0.8),
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title']!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    height: 1.1,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  item['desc']!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    height: 1.1,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Center(
                      child: Text('HERE TO HELP', style: _headerTextStyle()),
                    ),
                    Center(
                      child: Text('How can we help out?',
                          style: _subHeaderTextStyle()),
                    ),
                    SizedBox(height: 12.h),
                    _buildSearchBar(),
                    SizedBox(height: 15.h),
                    Text(
                      'Popular Questions',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: size.height * 0.006),
                    _rowHelpItems([
                      _helpItem(size, 'Account Access(Login)', 0.4),
                      _helpItem(size, 'Free Bet Information', 0.4),
                    ]),
                    SizedBox(height: size.height * 0.01),
                    _rowHelpItems([
                      _helpItem(size, 'Account Access(Login)', 0.35),
                      _helpItem(size, 'Free Bet Information', 0.35),
                    ]),
                    SizedBox(height: size.height * 0.01),
                    _rowHelpItems([
                      _helpItem(size, 'Updating or removing your card', 0.5),
                      _helpItem(size, 'Contact Us', 0.27),
                    ]),
                    SizedBox(height: size.height * 0.006),
                    _buildActionTilesSection(),
                    SizedBox(height: size.height * 0.006),
                    Text('Not found the answer you were after',style: TextStyle(color: Colors.white,fontSize: 14.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: size.height * 0.006),
                    _buildGetInTouch(),
                    SizedBox(height: size.height * 0.006),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return SizedBox(
      height: 33.h,
      child: TextFormField(
        showCursor: false,
        style: TextStyle(
          color: Colors.black,
          fontSize: 12.sp,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 0),
          hintText: 'Tell us what you are looking for',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 12.sp,
          ),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _rowHelpItems(List<Widget> children) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      child: Row(
        children: [
          ...children,
          if (children.length == 1) const Spacer(),
        ],
      ),
    );
  }

  Widget _helpItem(Size size, String title, double width) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      height: size.height * 0.05,
      width: size.width * width,
      decoration: BoxDecoration(
        color: AppColors.helpScrenColor,
        borderRadius: BorderRadius.circular(2.r),
      ),
      child: Row(
        children: [
          Container(
            width: size.width * 0.004,
            color: Colors.amber,
          ),
          SizedBox(width: size.width * 0.02),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTilesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: Text(
            'Find our more about one of these areas',
            style: _sectionTitleStyle(),
          ),
        ),
        ...actionTiles.map(_buildActionTile).toList(),
      ],
    );
  }

  Widget _buildActionTile(Map<String, String> tile) {
    return Padding(
      padding: EdgeInsets.only(bottom: 7.h), // Optional vertical spacing
      child: SizedBox(
        height: 45.h,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xff2A2A2C),
            borderRadius: BorderRadius.circular(3.r),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
            leading: Image.asset(tile['image']!, width: 20.w),
            title: Text(tile['title']!, style: _tileTextStyle()),
            trailing: Icon(
              Icons.arrow_forward,
              color: Colors.grey,
              size: 16.sp,
            ),
            onTap: () {},
          ),
        ),
      ),
    );
  }

  Widget _buildGetInTouch(){
   return Container(
    height: 110.h,
    width: 10.sw,
    decoration: BoxDecoration(
      color: const Color(0xff2A2A2C),
      borderRadius: BorderRadius.circular(3.r)
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(image: AssetImage('assets/images/dd.png')),
        SizedBox(height: 8.h),
        Text('The quickest way to get in touch',style: TextStyle(color: Colors.white,fontSize: 12.sp),),
        SizedBox(height: 10.h),
        Container(
          width: 250.w,
          height: 30.h,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white)
          ),
        
          child: Center(child: Text('Get in touch',style: TextStyle(color: Colors.white,fontSize: 12.sp))),
          
        ),
        SizedBox(height: 10.h),
      ],
    ),
   );
  }


  TextStyle _headerTextStyle() => TextStyle(
      fontSize: 28.sp, color: Colors.white, fontWeight: FontWeight.bold);

  TextStyle _subHeaderTextStyle() => TextStyle(
      color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w500);

  TextStyle _sectionTitleStyle() => TextStyle(
      color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold);

  TextStyle _tileTextStyle() => TextStyle(
      color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w600);
}

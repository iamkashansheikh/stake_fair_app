import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stake_fair_app/res/responsive.dart';

class SoccerMarketWidget extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> backOdds;
  final List<Map<String, dynamic>> layOdds;

  const SoccerMarketWidget({
    super.key,
    required this.title,
    required this.backOdds,
    required this.layOdds,
  });

  @override
  Widget build(BuildContext context) {
    return BaseResponsiveScreen(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Container(
            padding:  EdgeInsets.symmetric(vertical: 5.h, horizontal: 6.w),
            decoration:  BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 0.3.r)),
            ),
            child: Row(
              children: [
                Container(
                  width: 14.w,
                  height: 14.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/market.png'), fit: BoxFit.contain),
                  ),
                ),
                 SizedBox(width: 4.w),
                Expanded(
                  flex: 2,
                  child: Text(
                    title,
                    style:  TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 11.sp,
                      color: Color(0xff212529),
                    ),
                  ),
                ),
                ...backOdds.take(1).map((odd) => _buildOddsBox(
                      price: odd['price'].toString(),
                      size: odd['size'].toString(),
                      backgroundColor: Colors.blue.shade300,
                    )),
                const SizedBox(width: 6),
                ...layOdds.take(1).map((odd) => _buildOddsBox(
                      price: odd['price'].toString(),
                      size: odd['size'].toString(),
                      backgroundColor: Colors.pink.shade300,
                    )),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOddsBox({
    required String price,
    required String size,
    required Color backgroundColor,
  }) {
    return Container(
      width: 53.w,
      height: 38.h,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(2.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(price,
              style:  TextStyle(
                  fontSize: 14.sp,
                  height: 1.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          Text(size, style:  TextStyle(fontSize: 10.sp,height: 1.0, color: Colors.white)),
        ],
      ),
    );
  }
}

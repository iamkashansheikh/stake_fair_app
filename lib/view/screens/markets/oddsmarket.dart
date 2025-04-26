import 'package:flutter/material.dart';

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
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey, width: 0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/market.png'), fit: BoxFit.contain),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
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
    );
  }

  Widget _buildOddsBox({
    required String price,
    required String size,
    required Color backgroundColor,
  }) {
    return Container(
      width: 50,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(price,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          Text(size, style: const TextStyle(fontSize: 12, color: Colors.white)),
        ],
      ),
    );
  }
}

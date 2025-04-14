import 'package:stake_fair_app/data/network/network_api_services.dart';
import 'package:stake_fair_app/res/app_urls/app_urls.dart';

class HomeRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<dynamic> categoryApi(dynamic data) async {
    return await _apiServices.postApi(data, AppUrls.categoryApi);
  }
}

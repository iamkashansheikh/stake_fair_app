// HomeRepository.dart
import 'package:stake_fair_app/data/network/network_api_services.dart';
import 'package:stake_fair_app/res/app_urls/app_urls.dart';

class HomeRepository {
  final _appservices = NetworkApiServices();
  
  Future<dynamic> categoryApi(var data) async {
    dynamic response = _appservices.postApi(data, AppUrls.categoryApi);
    print('HomeRepository$response');
    return response;
  }
}

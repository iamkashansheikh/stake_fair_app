import 'package:stake_fair_app/data/network/network_api_services.dart';
import 'package:stake_fair_app/res/app_urls/app_urls.dart';

class HomeRepository {
  final NetworkApiServices _apiServices = NetworkApiServices();

  Future<dynamic> categoryApi(dynamic data) async {
    final String url = AppUrls.baseUrl + AppUrls.categoryApi;
    return await _apiServices.postApi(data, url);
  }

  Future<dynamic> racingEventsListApi(dynamic data) async {
    final String url = AppUrls.baseUrl + AppUrls.racingEventsListApi;
    return await _apiServices.postApi(data, url);
  }

  Future<dynamic> sportListApi(dynamic data) async {
    final String url = AppUrls.baseUrl2 + AppUrls.sportList;
    return await _apiServices.postApi(data, url);
  }

  //   Future<dynamic> alleventlist(dynamic data)async{
  //   final String url = AppUrls.baseUrl + AppUrls.allevenlist;
  //   return await _apiServices.postApi(data, url);
  // }
}

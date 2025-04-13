import 'package:get/get.dart';
import 'package:stake_fair_app/models/home_models/category_model.dart';
import 'package:stake_fair_app/repositroy/home_repository/home_repository.dart';

class CompetitionController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository(); //  Inject repository
  var isLoading = true.obs;
  var competitionList = <Competitions>[].obs;
  var eventList = <EventTypes>[].obs; //  Store all event data
  var eventId = "".obs; //  Use String for consistency with API

  //  Fetch competitions using repository
  void fetchCompetitions(String eventName) async {
    try {
      isLoading.value = true;

      var response = await _homeRepository.categoryApi({}); // Fetch API data
      if (response != null) {
        CategoryListModel model = CategoryListModel.fromJson(response);

        if (model.data != null) {
          //  Store all events
          eventList.value = model.data!.eventTypes ?? [];

          // 🔥 Find the event ID based on event name
          var matchingEvent = eventList.firstWhere(
            (event) => event.eventType?.name == eventName,
            orElse: () => EventTypes(eventType: EventType(id: "-1", name: "Unknown")),
          );

          eventId.value = matchingEvent.eventType?.id ?? "-1";

          print("Fetching competitions for eventId: ${eventId.value}");

          //  Filter competitions based on event ID
          competitionList.value = model.data!.competitions
                  ?.where((comp) => comp.eventType?.id == eventId.value)
                  .toList() ??
              [];

          print("Fetched ${competitionList.length} competitions.");
        }
      }
    } catch (e) {
      print(" Error fetching competitions: $e");
    } finally {
      isLoading.value = false;
    }
  }
}

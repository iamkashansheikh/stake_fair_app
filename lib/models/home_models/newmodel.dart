
class AllEventListModel {
  final Data data;
  final Meta meta;

  AllEventListModel({
    required this.data,
    required this.meta,
  });

  factory AllEventListModel.fromJson(Map<String, dynamic> json) {
    return AllEventListModel(
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data.toJson(),
        'meta': meta.toJson(),
      };
}

class Data {
  final List<Tournament> tournaments;
  final List<EventItem> events;

  Data({
    required this.tournaments,
    required this.events,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      tournaments: (json['tournaments'] as List)
          .map((e) => Tournament.fromJson(e as Map<String, dynamic>))
          .toList(),
      events: (json['events'] as List)
          .map((e) => EventItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'tournaments': tournaments.map((e) => e.toJson()).toList(),
        'events': events.map((e) => e.toJson()).toList(),
      };
}

class Tournament {
  final int tournamentId;
  final int sportId;
  final String tournamentName;
  final bool inPlay;

  Tournament({
    required this.tournamentId,
    required this.sportId,
    required this.tournamentName,
    required this.inPlay,
  });

  factory Tournament.fromJson(Map<String, dynamic> json) {
    return Tournament(
      tournamentId: json['tournamentId'] as int,
      sportId: json['sportId'] as int,
      tournamentName: json['tournamentName'] as String,
      inPlay: json['inPlay'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        'tournamentId': tournamentId,
        'sportId': sportId,
        'tournamentName': tournamentName,
        'inPlay': inPlay,
      };
}

class EventItem {
  final String eventId;
  final String eventName;
  final int tournamentId;
  final String tournamentName;
  final int sportId;
  final bool inPlay;
  final List<EventData> eventsData;

  EventItem({
    required this.eventId,
    required this.eventName,
    required this.tournamentId,
    required this.tournamentName,
    required this.sportId,
    required this.inPlay,
    required this.eventsData,
  });

  factory EventItem.fromJson(Map<String, dynamic> json) {
    return EventItem(
      eventId: json['eventId'].toString(),
      eventName: json['eventName'] as String,
      tournamentId: json['tournamentId'] as int,
      tournamentName: json['tournamentName'] as String,
      sportId: json['sportId'] as int,
      inPlay: json['inPlay'] as bool,
      eventsData: (json['eventsData'] as List)
          .map((e) => EventData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'eventId': eventId,
        'eventName': eventName,
        'tournamentId': tournamentId,
        'tournamentName': tournamentName,
        'sportId': sportId,
        'inPlay': inPlay,
        'eventsData': eventsData.map((e) => e.toJson()).toList(),
      };
}

class EventData {
  final String eventId;
  final bool inPlay;
  final String eventName;
  final DateTime eventTime;

  EventData({
    required this.eventId,
    required this.inPlay,
    required this.eventName,
    required this.eventTime,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      eventId: json['eventId'].toString(),
      inPlay: json['inPlay'] as bool,
      eventName: json['eventName'] as String,
      eventTime: DateTime.parse(json['eventTime'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'eventId': eventId,
        'inPlay': inPlay,
        'eventName': eventName,
        'eventTime': eventTime.toIso8601String(),
      };
}

class Meta {
  final String message;
  final int statusCode;
  final bool status;

  Meta({
    required this.message,
    required this.statusCode,
    required this.status,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      message: json['message'] as String,
      statusCode: json['status_code'] as int,
      status: json['status'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'status_code': statusCode,
        'status': status,
      };
}

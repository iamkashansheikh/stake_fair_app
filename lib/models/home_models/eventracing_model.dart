class EventRacingListModel {
  Data? data;
  Meta? meta;

  EventRacingListModel({this.data, this.meta});

  EventRacingListModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Data {
  List<Tournaments>? tournaments;
  List<Events>? events;

  Data({this.tournaments, this.events});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['tournaments'] != null) {
      tournaments = <Tournaments>[];
      json['tournaments'].forEach((v) {
        tournaments!.add(new Tournaments.fromJson(v));
      });
    }
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(new Events.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tournaments != null) {
      data['tournaments'] = this.tournaments!.map((v) => v.toJson()).toList();
    }
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tournaments {
  String? tournamentId;
  String? sportId;
  String? tournamentName;
  bool? inPlay;

  Tournaments(
      {this.tournamentId, this.sportId, this.tournamentName, this.inPlay});

  Tournaments.fromJson(Map<String, dynamic> json) {
    tournamentId = json['tournamentId'];
    sportId = json['sportId'];
    tournamentName = json['tournamentName'];
    inPlay = json['inPlay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tournamentId'] = this.tournamentId;
    data['sportId'] = this.sportId;
    data['tournamentName'] = this.tournamentName;
    data['inPlay'] = this.inPlay;
    return data;
  }
}

class Events {
  String? eventId;
  String? eventName;
  String? tournamentId;
  String? tournamentName;
  String? sportId;
  bool? inPlay;
  List<EventsData>? eventsData;

  Events(
      {this.eventId,
      this.eventName,
      this.tournamentId,
      this.tournamentName,
      this.sportId,
      this.inPlay,
      this.eventsData});

  Events.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    eventName = json['eventName'];
    tournamentId = json['tournamentId'];
    tournamentName = json['tournamentName'];
    sportId = json['sportId'];
    inPlay = json['inPlay'];
    if (json['eventsData'] != null) {
      eventsData = <EventsData>[];
      json['eventsData'].forEach((v) {
        eventsData!.add(new EventsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventId'] = this.eventId;
    data['eventName'] = this.eventName;
    data['tournamentId'] = this.tournamentId;
    data['tournamentName'] = this.tournamentName;
    data['sportId'] = this.sportId;
    data['inPlay'] = this.inPlay;
    if (this.eventsData != null) {
      data['eventsData'] = this.eventsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventsData {
  String? eventId;
  bool? inPlay;
  String? eventName;
  String? eventTime;

  EventsData({this.eventId, this.inPlay, this.eventName, this.eventTime});

  EventsData.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    inPlay = json['inPlay'];
    eventName = json['eventName'];
    eventTime = json['eventTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventId'] = this.eventId;
    data['inPlay'] = this.inPlay;
    data['eventName'] = this.eventName;
    data['eventTime'] = this.eventTime;
    return data;
  }
}

class Meta {
  String? message;
  int? statusCode;
  bool? status;

  Meta({this.message, this.statusCode, this.status});

  Meta.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['status_code'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    data['status'] = this.status;
    return data;
  }
}
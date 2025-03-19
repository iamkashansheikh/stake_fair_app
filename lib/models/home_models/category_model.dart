class CategoryListModel {
  Data? data;
  Meta? meta;

  CategoryListModel({this.data, this.meta});

  CategoryListModel.fromJson(Map<String, dynamic> json) {
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
  List<EventTypes>? eventTypes;
  List<Competitions>? competitions;
  List<Events>? events;

  Data({this.eventTypes, this.competitions, this.events});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['eventTypes'] != null) {
      eventTypes = <EventTypes>[];
      json['eventTypes'].forEach((v) {
        eventTypes!.add(new EventTypes.fromJson(v));
      });
    }
    if (json['competitions'] != null) {
      competitions = <Competitions>[];
      json['competitions'].forEach((v) {
        competitions!.add(new Competitions.fromJson(v));
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
    if (this.eventTypes != null) {
      data['eventTypes'] = this.eventTypes!.map((v) => v.toJson()).toList();
    }
    if (this.competitions != null) {
      data['competitions'] = this.competitions!.map((v) => v.toJson()).toList();
    }
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventTypes {
  EventType? eventType;
  int? marketCount;

  EventTypes({this.eventType, this.marketCount});

  EventTypes.fromJson(Map<String, dynamic> json) {
    eventType = json['eventType'] != null
        ? new EventType.fromJson(json['eventType'])
        : null;
    marketCount = json['marketCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.eventType != null) {
      data['eventType'] = this.eventType!.toJson();
    }
    data['marketCount'] = this.marketCount;
    return data;
  }
}

class EventType {
  String? id;
  String? name;

  EventType({this.id, this.name});

  EventType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Competitions {
  EventType? competition;
  EventType? eventType;
  String? competitionRegion;
  int? marketCount;

  Competitions(
      {this.competition,
      this.eventType,
      this.competitionRegion,
      this.marketCount});

  Competitions.fromJson(Map<String, dynamic> json) {
    competition = json['competition'] != null
        ? new EventType.fromJson(json['competition'])
        : null;
    eventType = json['eventType'] != null
        ? new EventType.fromJson(json['eventType'])
        : null;
    competitionRegion = json['competitionRegion'];
    marketCount = json['marketCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.competition != null) {
      data['competition'] = this.competition!.toJson();
    }
    if (this.eventType != null) {
      data['eventType'] = this.eventType!.toJson();
    }
    data['competitionRegion'] = this.competitionRegion;
    data['marketCount'] = this.marketCount;
    return data;
  }
}

class Events {
  Event? event;
  EventType? competition;
  EventType? eventType;
  int? marketCount;

  Events({this.event, this.competition, this.eventType, this.marketCount});

  Events.fromJson(Map<String, dynamic> json) {
    event = json['event'] != null ? new Event.fromJson(json['event']) : null;
    competition = json['competition'] != null
        ? new EventType.fromJson(json['competition'])
        : null;
    eventType = json['eventType'] != null
        ? new EventType.fromJson(json['eventType'])
        : null;
    marketCount = json['marketCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.event != null) {
      data['event'] = this.event!.toJson();
    }
    if (this.competition != null) {
      data['competition'] = this.competition!.toJson();
    }
    if (this.eventType != null) {
      data['eventType'] = this.eventType!.toJson();
    }
    data['marketCount'] = this.marketCount;
    return data;
  }
}

class Event {
  String? id;
  String? name;
  String? countryCode;
  String? timezone;
  String? openDate;

  Event({this.id, this.name, this.countryCode, this.timezone, this.openDate});

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryCode = json['countryCode'];
    timezone = json['timezone'];
    openDate = json['openDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['countryCode'] = this.countryCode;
    data['timezone'] = this.timezone;
    data['openDate'] = this.openDate;
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
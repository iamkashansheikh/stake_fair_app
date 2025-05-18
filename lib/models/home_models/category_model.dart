import 'dart:convert';

/// Top-level helpers
CategoryListModel categoryListModelFromJson(String str) =>
    CategoryListModel.fromJson(json.decode(str) as Map<String, dynamic>);

String categoryListModelToJson(CategoryListModel data) =>
    json.encode(data.toJson());

/// ─────────────────── CategoryListModel ─────────────────────────
class CategoryListModel {
  final Data? data;
  final Meta? meta;

  CategoryListModel({this.data, this.meta});

  factory CategoryListModel.fromJson(Map<String, dynamic> json) =>
      CategoryListModel(
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
        meta: json['meta'] == null
            ? null
            : Meta.fromJson(json['meta'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'meta': meta?.toJson(),
      };
}

/// ─────────────────── Data ──────────────────────────────────────
class Data {
  final List<EventType> eventTypes;
  final List<CompetitionElement> competitions;
  final List<CompetitionElement> events;

  Data({
    this.eventTypes = const [],
    this.competitions = const [],
    this.events = const [],
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        eventTypes: (json['eventTypes'] as List<dynamic>? ?? [])
            .map((e) => EventType.fromJson(e as Map<String, dynamic>))
            .toList(),
        competitions: (json['competitions'] as List<dynamic>? ?? [])
            .map((e) => CompetitionElement.fromJson(e as Map<String, dynamic>))
            .toList(),
        events: (json['events'] as List<dynamic>? ?? [])
            .map((e) => CompetitionElement.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'eventTypes': eventTypes.map((e) => e.toJson()).toList(),
        'competitions': competitions.map((e) => e.toJson()).toList(),
        'events': events.map((e) => e.toJson()).toList(),
      };
}

/// ─────────────────── CompetitionElement ────────────────────────
class CompetitionElement {
  final EventTypeClass? competition;
  final EventTypeClass? eventType;
  final String? competitionRegion;
  final int? marketCount;
  final Event? event;

  CompetitionElement({
    this.competition,
    this.eventType,
    this.competitionRegion,
    this.marketCount,
    this.event,
  });

  factory CompetitionElement.fromJson(Map<String, dynamic> json) =>
      CompetitionElement(
        competition: json['competition'] == null
            ? null
            : EventTypeClass.fromJson(
                json['competition'] as Map<String, dynamic>),
        eventType: json['eventType'] == null
            ? null
            : EventTypeClass.fromJson(
                json['eventType'] as Map<String, dynamic>),
        competitionRegion: json['competitionRegion'] as String?,
        marketCount: json['marketCount'] as int?,
        event: json['event'] == null
            ? null
            : Event.fromJson(json['event'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'competition': competition?.toJson(),
        'eventType': eventType?.toJson(),
        'competitionRegion': competitionRegion,
        'marketCount': marketCount,
        'event': event?.toJson(),
      };
}

/// ─────────────────── EventTypeClass ────────────────────────────
class EventTypeClass {
  final String? id;
  final String? name;

  EventTypeClass({this.id, this.name});

  factory EventTypeClass.fromJson(Map<String, dynamic> json) => EventTypeClass(
        id: json['id']?.toString(),
        name: json['name']?.toString(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

/// ─────────────────── Event ─────────────────────────────────────
class Event {
  final String? id;
  final String? name;
  final CountryCode? countryCode;
  final Timezone? timezone;
  final DateTime? openDate;

  Event({
    this.id,
    this.name,
    this.countryCode,
    this.timezone,
    this.openDate,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json['id']?.toString(),
        name: json['name']?.toString(),
        countryCode: countryCodeValues.map[json['countryCode']],
        timezone: timezoneValues.map[json['timezone']],
        openDate: _parseDate(json['openDate']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'countryCode': countryCodeValues.reverse[countryCode],
        'timezone': timezoneValues.reverse[timezone],
        'openDate': openDate?.toIso8601String(),
      };

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    try {
      return DateTime.parse(value.toString());
    } catch (_) {
      return null; // silently ignore bad date formats
    }
  }
}

/// ─────────────────── EventType ─────────────────────────────────
class EventType {
  final EventTypeClass? eventType;
  final int? marketCount;

  EventType({this.eventType, this.marketCount});

  factory EventType.fromJson(Map<String, dynamic> json) => EventType(
        eventType: json['eventType'] == null
            ? null
            : EventTypeClass.fromJson(
                json['eventType'] as Map<String, dynamic>),
        marketCount: json['marketCount'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'eventType': eventType?.toJson(),
        'marketCount': marketCount,
      };
}

/// ─────────────────── Meta ──────────────────────────────────────
class Meta {
  final String? message;
  final int? statusCode;
  final bool? status;

  Meta({this.message, this.statusCode, this.status});

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        message: json['message']?.toString(),
        statusCode: json['status_code'] as int?,
        status: json['status'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'status_code': statusCode,
        'status': status,
      };
}

/// ─────────────────── Enums & Helpers ───────────────────────────
enum CountryCode { GB, IN, PK }

enum Timezone { EUROPE_LONDON, GMT }

class EnumValues<T> {
  EnumValues(this.map);
  final Map<String, T> map;
  Map<T, String>? _reverseMap;

  Map<T, String> get reverse =>
      _reverseMap ??= map.map((k, v) => MapEntry(v, k));
}

final countryCodeValues = EnumValues({
  'GB': CountryCode.GB,
  'IN': CountryCode.IN,
  'PK': CountryCode.PK,
});

final timezoneValues = EnumValues({
  'Europe/London': Timezone.EUROPE_LONDON,
  'GMT': Timezone.GMT,
});

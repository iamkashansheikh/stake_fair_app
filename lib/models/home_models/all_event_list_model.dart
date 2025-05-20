// To parse this JSON data, do
//
//     final allEventListModel = allEventListModelFromJson(jsonString);

import 'dart:convert';

AllEventListModel allEventListModelFromJson(String str) =>
    AllEventListModel.fromJson(json.decode(str));

String allEventListModelToJson(AllEventListModel data) =>
    json.encode(data.toJson());

class AllEventListModel {
  Data? data;
  Meta? meta;

  AllEventListModel({
    this.data,
    this.meta,
  });

  factory AllEventListModel.fromJson(Map<String, dynamic> json) =>
      AllEventListModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "meta": meta?.toJson(),
      };
}

class Data {
  List<The4>? the4;

  Data({
    this.the4,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        the4: json["4"] == null
            ? []
            : List<The4>.from(json["4"]!.map((x) => The4.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "4": the4 == null
            ? []
            : List<dynamic>.from(the4!.map((x) => x.toJson())),
      };
}

class The4 {
  Event? event;
  Competition? competition;
  Competition? eventType;
  String? id;
  String? marketId;
  int? v;
  int? betDelay;
  bool? bspReconciled;
  bool? complete;
  DateTime? createdAt;
  bool? crossMatching;
  Description? description;
  bool? inplay;
  bool? isMarketDataDelayed;
  int? isSettlement;
  int? isVoid;
  MarketName? marketName;
  DateTime? marketStartTime;
  int? numberOfActiveRunners;
  int? numberOfRunners;
  int? numberOfWinners;
  List<Runner>? runners;
  List<RunnersName>? runnersName;
  bool? runnersVoidable;
  int? sequence;
  The4Status? status;
  TableFlag? tableFlag;
  double? totalAvailable;
  double? totalMatched;
  DateTime? updatedAt;
  int? version;

  The4({
    this.event,
    this.competition,
    this.eventType,
    this.id,
    this.marketId,
    this.v,
    this.betDelay,
    this.bspReconciled,
    this.complete,
    this.createdAt,
    this.crossMatching,
    this.description,
    this.inplay,
    this.isMarketDataDelayed,
    this.isSettlement,
    this.isVoid,
    this.marketName,
    this.marketStartTime,
    this.numberOfActiveRunners,
    this.numberOfRunners,
    this.numberOfWinners,
    this.runners,
    this.runnersName,
    this.runnersVoidable,
    this.sequence,
    this.status,
    this.tableFlag,
    this.totalAvailable,
    this.totalMatched,
    this.updatedAt,
    this.version,
  });

  factory The4.fromJson(Map<String, dynamic> json) => The4(
        event: json["event"] == null ? null : Event.fromJson(json["event"]),
        competition: json["competition"] == null
            ? null
            : Competition.fromJson(json["competition"]),
        eventType: json["eventType"] == null
            ? null
            : Competition.fromJson(json["eventType"]),
        id: json["_id"],
        marketId: json["marketId"],
        v: json["__v"],
        betDelay: json["betDelay"],
        bspReconciled: json["bspReconciled"],
        complete: json["complete"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        crossMatching: json["crossMatching"],
        description: json["description"] == null
            ? null
            : Description.fromJson(json["description"]),
        inplay: json["inplay"],
        isMarketDataDelayed: json["isMarketDataDelayed"],
        isSettlement: json["isSettlement"],
        isVoid: json["isVoid"],
        marketName: marketNameValues.map[json["marketName"]]!,
        marketStartTime: json["marketStartTime"] == null
            ? null
            : DateTime.parse(json["marketStartTime"]),
        numberOfActiveRunners: json["numberOfActiveRunners"],
        numberOfRunners: json["numberOfRunners"],
        numberOfWinners: json["numberOfWinners"],
        runners: json["runners"] == null
            ? []
            : List<Runner>.from(
                json["runners"]!.map((x) => Runner.fromJson(x))),
        runnersName: json["runnersName"] == null
            ? []
            : List<RunnersName>.from(
                json["runnersName"]!.map((x) => RunnersName.fromJson(x))),
        runnersVoidable: json["runnersVoidable"],
        sequence: json["sequence"],
        status: the4StatusValues.map[json["status"]]!,
        tableFlag: tableFlagValues.map[json["tableFlag"]]!,
        totalAvailable: json["totalAvailable"]?.toDouble(),
        totalMatched: json["totalMatched"]?.toDouble(),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "event": event?.toJson(),
        "competition": competition?.toJson(),
        "eventType": eventType?.toJson(),
        "_id": id,
        "marketId": marketId,
        "__v": v,
        "betDelay": betDelay,
        "bspReconciled": bspReconciled,
        "complete": complete,
        "createdAt": createdAt?.toIso8601String(),
        "crossMatching": crossMatching,
        "description": description?.toJson(),
        "inplay": inplay,
        "isMarketDataDelayed": isMarketDataDelayed,
        "isSettlement": isSettlement,
        "isVoid": isVoid,
        "marketName": marketNameValues.reverse[marketName],
        "marketStartTime": marketStartTime?.toIso8601String(),
        "numberOfActiveRunners": numberOfActiveRunners,
        "numberOfRunners": numberOfRunners,
        "numberOfWinners": numberOfWinners,
        "runners": runners == null
            ? []
            : List<dynamic>.from(runners!.map((x) => x.toJson())),
        "runnersName": runnersName == null
            ? []
            : List<dynamic>.from(runnersName!.map((x) => x.toJson())),
        "runnersVoidable": runnersVoidable,
        "sequence": sequence,
        "status": the4StatusValues.reverse[status],
        "tableFlag": tableFlagValues.reverse[tableFlag],
        "totalAvailable": totalAvailable,
        "totalMatched": totalMatched,
        "updatedAt": updatedAt?.toIso8601String(),
        "version": version,
      };
}

class Competition {
  String? id;
  String? name;

  Competition({
    this.id,
    this.name,
  });

  factory Competition.fromJson(Map<String, dynamic> json) => Competition(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Description {
  bool? persistenceEnabled;
  bool? bspMarket;
  DateTime? marketTime;
  DateTime? suspendTime;
  BettingType? bettingType;
  bool? turnInPlayEnabled;
  TableFlag? marketType;
  Regulator? regulator;
  int? marketBaseRate;
  bool? discountAllowed;
  Wallet? wallet;
  String? rules;
  bool? rulesHasDate;
  PriceLadderDescription? priceLadderDescription;

  Description({
    this.persistenceEnabled,
    this.bspMarket,
    this.marketTime,
    this.suspendTime,
    this.bettingType,
    this.turnInPlayEnabled,
    this.marketType,
    this.regulator,
    this.marketBaseRate,
    this.discountAllowed,
    this.wallet,
    this.rules,
    this.rulesHasDate,
    this.priceLadderDescription,
  });

  factory Description.fromJson(Map<String, dynamic> json) => Description(
        persistenceEnabled: json["persistenceEnabled"],
        bspMarket: json["bspMarket"],
        marketTime: json["marketTime"] == null
            ? null
            : DateTime.parse(json["marketTime"]),
        suspendTime: json["suspendTime"] == null
            ? null
            : DateTime.parse(json["suspendTime"]),
        bettingType: bettingTypeValues.map[json["bettingType"]]!,
        turnInPlayEnabled: json["turnInPlayEnabled"],
        marketType: tableFlagValues.map[json["marketType"]]!,
        regulator: regulatorValues.map[json["regulator"]]!,
        marketBaseRate: json["marketBaseRate"],
        discountAllowed: json["discountAllowed"],
        wallet: walletValues.map[json["wallet"]]!,
        rules: json["rules"],
        rulesHasDate: json["rulesHasDate"],
        priceLadderDescription: json["priceLadderDescription"] == null
            ? null
            : PriceLadderDescription.fromJson(json["priceLadderDescription"]),
      );

  Map<String, dynamic> toJson() => {
        "persistenceEnabled": persistenceEnabled,
        "bspMarket": bspMarket,
        "marketTime": marketTime?.toIso8601String(),
        "suspendTime": suspendTime?.toIso8601String(),
        "bettingType": bettingTypeValues.reverse[bettingType],
        "turnInPlayEnabled": turnInPlayEnabled,
        "marketType": tableFlagValues.reverse[marketType],
        "regulator": regulatorValues.reverse[regulator],
        "marketBaseRate": marketBaseRate,
        "discountAllowed": discountAllowed,
        "wallet": walletValues.reverse[wallet],
        "rules": rules,
        "rulesHasDate": rulesHasDate,
        "priceLadderDescription": priceLadderDescription?.toJson(),
      };
}

enum BettingType { ODDS }

final bettingTypeValues = EnumValues({"ODDS": BettingType.ODDS});

enum TableFlag { MATCH_ODDS }

final tableFlagValues = EnumValues({"MATCH_ODDS": TableFlag.MATCH_ODDS});

class PriceLadderDescription {
  Type? type;

  PriceLadderDescription({
    this.type,
  });

  factory PriceLadderDescription.fromJson(Map<String, dynamic> json) =>
      PriceLadderDescription(
        type: typeValues.map[json["type"]]!,
      );

  Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
      };
}

enum Type { CLASSIC }

final typeValues = EnumValues({"CLASSIC": Type.CLASSIC});

enum Regulator { MALTA_LOTTERIES_AND_GAMBLING_AUTHORITY }

final regulatorValues = EnumValues({
  "MALTA LOTTERIES AND GAMBLING AUTHORITY":
      Regulator.MALTA_LOTTERIES_AND_GAMBLING_AUTHORITY
});

enum Wallet { UK_WALLET }

final walletValues = EnumValues({"UK wallet": Wallet.UK_WALLET});

class Event {
  String? id;
  String? name;
  CountryCode? countryCode;
  Timezone? timezone;
  DateTime? openDate;

  Event({
    this.id,
    this.name,
    this.countryCode,
    this.timezone,
    this.openDate,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        name: json["name"],
        countryCode: countryCodeValues.map[json["countryCode"]]!,
        timezone: timezoneValues.map[json["timezone"]]!,
        openDate:
            json["openDate"] == null ? null : DateTime.parse(json["openDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "countryCode": countryCodeValues.reverse[countryCode],
        "timezone": timezoneValues.reverse[timezone],
        "openDate": openDate?.toIso8601String(),
      };
}

enum CountryCode { GB }

final countryCodeValues = EnumValues({"GB": CountryCode.GB});

enum Timezone { GMT }

final timezoneValues = EnumValues({"GMT": Timezone.GMT});

enum MarketName { MATCH_ODDS }

final marketNameValues = EnumValues({"Match Odds": MarketName.MATCH_ODDS});

class Runner {
  int? selectionId;
  int? handicap;
  RunnerStatus? status;
  double? lastPriceTraded;
  double? totalMatched;
  Ex? ex;

  Runner({
    this.selectionId,
    this.handicap,
    this.status,
    this.lastPriceTraded,
    this.totalMatched,
    this.ex,
  });

  factory Runner.fromJson(Map<String, dynamic> json) => Runner(
        selectionId: json["selectionId"],
        handicap: json["handicap"],
        status: runnerStatusValues.map[json["status"]]!,
        lastPriceTraded: json["lastPriceTraded"]?.toDouble(),
        totalMatched: json["totalMatched"]?.toDouble(),
        ex: json["ex"] == null ? null : Ex.fromJson(json["ex"]),
      );

  Map<String, dynamic> toJson() => {
        "selectionId": selectionId,
        "handicap": handicap,
        "status": runnerStatusValues.reverse[status],
        "lastPriceTraded": lastPriceTraded,
        "totalMatched": totalMatched,
        "ex": ex?.toJson(),
      };
}

class Ex {
  List<AvailableTo>? availableToBack;
  List<AvailableTo>? availableToLay;
  List<dynamic>? tradedVolume;

  Ex({
    this.availableToBack,
    this.availableToLay,
    this.tradedVolume,
  });

  factory Ex.fromJson(Map<String, dynamic> json) => Ex(
        availableToBack: json["availableToBack"] == null
            ? []
            : List<AvailableTo>.from(
                json["availableToBack"]!.map((x) => AvailableTo.fromJson(x))),
        availableToLay: json["availableToLay"] == null
            ? []
            : List<AvailableTo>.from(
                json["availableToLay"]!.map((x) => AvailableTo.fromJson(x))),
        tradedVolume: json["tradedVolume"] == null
            ? []
            : List<dynamic>.from(json["tradedVolume"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "availableToBack": availableToBack == null
            ? []
            : List<dynamic>.from(availableToBack!.map((x) => x.toJson())),
        "availableToLay": availableToLay == null
            ? []
            : List<dynamic>.from(availableToLay!.map((x) => x.toJson())),
        "tradedVolume": tradedVolume == null
            ? []
            : List<dynamic>.from(tradedVolume!.map((x) => x)),
      };
}

class AvailableTo {
  double? price;
  double? size;

  AvailableTo({
    this.price,
    this.size,
  });

  factory AvailableTo.fromJson(Map<String, dynamic> json) => AvailableTo(
        price: json["price"]?.toDouble(),
        size: json["size"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "size": size,
      };
}

enum RunnerStatus { ACTIVE, LOSER, WINNER }

final runnerStatusValues = EnumValues({
  "ACTIVE": RunnerStatus.ACTIVE,
  "LOSER": RunnerStatus.LOSER,
  "WINNER": RunnerStatus.WINNER
});

class RunnersName {
  int? selectionId;
  String? runnerName;
  int? handicap;
  int? sortPriority;

  RunnersName({
    this.selectionId,
    this.runnerName,
    this.handicap,
    this.sortPriority,
  });

  factory RunnersName.fromJson(Map<String, dynamic> json) => RunnersName(
        selectionId: json["selectionId"],
        runnerName: json["runnerName"],
        handicap: json["handicap"],
        sortPriority: json["sortPriority"],
      );

  Map<String, dynamic> toJson() => {
        "selectionId": selectionId,
        "runnerName": runnerName,
        "handicap": handicap,
        "sortPriority": sortPriority,
      };
}

enum The4Status { CLOSED, OPEN, SUSPENDED }

final the4StatusValues = EnumValues({
  "CLOSED": The4Status.CLOSED,
  "OPEN": The4Status.OPEN,
  "SUSPENDED": The4Status.SUSPENDED
});

class Meta {
  String? message;
  int? statusCode;
  bool? status;

  Meta({
    this.message,
    this.statusCode,
    this.status,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        message: json["message"],
        statusCode: json["status_code"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status_code": statusCode,
        "status": status,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

import 'dart:convert';
import 'dart:developer';

CompetitionMarketListModel competitionMarketListModelFromJson(String str) =>
    CompetitionMarketListModel.fromJson(json.decode(str));

String competitionMarketListModelToJson(CompetitionMarketListModel data) =>
    json.encode(data.toJson());

class CompetitionMarketListModel {
  List<Datum>? data;
  Meta? meta;

  CompetitionMarketListModel({
    this.data,
    this.meta,
  });

  factory CompetitionMarketListModel.fromJson(Map<String, dynamic> json) {
    try {
      return CompetitionMarketListModel(
        data: json["data"] is List
            ? List<Datum>.from(json["data"]
                .map((x) => Datum.fromJson(x as Map<String, dynamic>)))
            : [],
        meta: json["meta"] != null
            ? Meta.fromJson(json["meta"] as Map<String, dynamic>)
            : null,
      );
    } catch (e) {
      log('Error parsing CompetitionMarketListModel: $e');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
      };
}

class Datum {
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
  String? marketName;
  DateTime? marketStartTime;
  int? numberOfActiveRunners;
  int? numberOfRunners;
  int? numberOfWinners;
  List<Runner>? runners;
  List<RunnersName>? runnersName;
  bool? runnersVoidable;
  int? sequence;
  String? status;
  String? tableFlag;
  double? totalAvailable;
  double? totalMatched;
  DateTime? updatedAt;
  int? version;

  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        marketName: json["marketName"],
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
        status: json["status"],
        tableFlag: json["tableFlag"],
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
        "marketName": marketName,
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
        "status": status,
        "tableFlag": tableFlag,
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
  String? bettingType;
  bool? turnInPlayEnabled;
  String? marketType;
  String? regulator;
  int? marketBaseRate;
  bool? discountAllowed;
  String? wallet;
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
        bettingType: json["bettingType"],
        turnInPlayEnabled: json["turnInPlayEnabled"],
        marketType: json["marketType"],
        regulator: json["regulator"],
        marketBaseRate: json["marketBaseRate"],
        discountAllowed: json["discountAllowed"],
        wallet: json["wallet"],
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
        "bettingType": bettingType,
        "turnInPlayEnabled": turnInPlayEnabled,
        "marketType": marketType,
        "regulator": regulator,
        "marketBaseRate": marketBaseRate,
        "discountAllowed": discountAllowed,
        "wallet": wallet,
        "rules": rules,
        "rulesHasDate": rulesHasDate,
        "priceLadderDescription": priceLadderDescription?.toJson(),
      };
}

class PriceLadderDescription {
  String? type;

  PriceLadderDescription({
    this.type,
  });

  factory PriceLadderDescription.fromJson(Map<String, dynamic> json) =>
      PriceLadderDescription(
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
      };
}

class Event {
  String? id;
  String? name;
  String? countryCode;
  String? timezone;
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
        countryCode: json["countryCode"],
        timezone: json["timezone"],
        openDate:
            json["openDate"] == null ? null : DateTime.parse(json["openDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "countryCode": countryCode,
        "timezone": timezone,
        "openDate": openDate?.toIso8601String(),
      };
}

class Runner {
  int? selectionId;
  int? handicap;
  String? status;
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
        status: json["status"],
        lastPriceTraded: json["lastPriceTraded"]?.toDouble(),
        totalMatched: json["totalMatched"]?.toDouble(),
        ex: json["ex"] == null ? null : Ex.fromJson(json["ex"]),
      );

  Map<String, dynamic> toJson() => {
        "selectionId": selectionId,
        "handicap": handicap,
        "status": status,
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

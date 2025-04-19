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
  final List<EventModel> soccer;
  final List<EventModel> tennis;
  final List<EventModel> cricket;
  final List<EventModel> horseRacing;
  final List<EventModel> basketball;
  final List<EventModel> binary;

  Data({
    required this.soccer,
    required this.tennis,
    required this.cricket,
    required this.horseRacing,
    required this.basketball,
    required this.binary,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      soccer: (json['1'] as List)
          .map((e) => EventModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      tennis: (json['2'] as List)
          .map((e) => EventModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      cricket: (json['4'] as List)
          .map((e) => EventModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      horseRacing: (json['7'] as List)
          .map((e) => EventModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      basketball: (json['7522'] as List)
          .map((e) => EventModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      binary: (json['66103'] as List)
          .map((e) => EventModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        '1': soccer.map((e) => e.toJson()).toList(),
        '2': tennis.map((e) => e.toJson()).toList(),
        '4': cricket.map((e) => e.toJson()).toList(),
        '7': horseRacing.map((e) => e.toJson()).toList(),
        '7522': basketball.map((e) => e.toJson()).toList(),
        '66103': binary.map((e) => e.toJson()).toList(),
      };
}

class EventModel {
  final String id;
  final String marketId;
  final String marketName;
  final String exEventId;
  final String eventName;
  final String sportId;
  final String sportName;
  final DateTime eventTime;
  final String tournamentId;
  final String tournamentName;
  final OddsData oddsData;
  final bool? isFancy;
  final String marketType;
  final bool? isBookmakers;
  final bool popular;
  final RunnersData runnersData;
  final bool quickLink;
  final bool? isStreaming;
  final bool? isVirtual;
  final bool? isSportsbook;
  final bool? isCasinoGame;

  EventModel({
    required this.id,
    required this.marketId,
    required this.marketName,
    required this.exEventId,
    required this.eventName,
    required this.sportId,
    required this.sportName,
    required this.eventTime,
    required this.tournamentId,
    required this.tournamentName,
    required this.oddsData,
    this.isFancy,
    required this.marketType,
    this.isBookmakers,
    required this.popular,
    required this.runnersData,
    required this.quickLink,
    this.isStreaming,
    this.isVirtual,
    this.isSportsbook,
    this.isCasinoGame,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['_id'] as String,
      marketId: json['marketId'] as String,
      marketName: json['marketName'] as String,
      exEventId: json['exEventId'] as String,
      eventName: json['eventName'] as String,
      sportId: json['sportId'] as String,
      sportName: json['sportName'] as String,
      eventTime: DateTime.parse(json['eventTime'] as String),
      tournamentId: json['tournamentId'] as String,
      tournamentName: json['tournamentName'] as String,
      oddsData: OddsData.fromJson(json['oddsData'] as Map<String, dynamic>),
      isFancy: json['isFancy'] as bool?,
      marketType: json['marketType'] as String,
      isBookmakers: json['isBookmakers'] as bool?,
      popular: json['popular'] as bool,
      runnersData:
          RunnersData.fromJson(json['runnersData'] as Map<String, dynamic>),
      quickLink: json['quickLink'] as bool,
      isStreaming: json['isStreaming'] as bool?,
      isVirtual: json['isVirtual'] as bool?,
      isSportsbook: json['isSportsbook'] as bool?,
      isCasinoGame: json['isCasinoGame'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'marketId': marketId,
        'marketName': marketName,
        'exEventId': exEventId,
        'eventName': eventName,
        'sportId': sportId,
        'sportName': sportName,
        'eventTime': eventTime.toIso8601String(),
        'tournamentId': tournamentId,
        'tournamentName': tournamentName,
        'oddsData': oddsData.toJson(),
        'isFancy': isFancy,
        'marketType': marketType,
        'isBookmakers': isBookmakers,
        'popular': popular,
        'runnersData': runnersData.toJson(),
        'quickLink': quickLink,
        'isStreaming': isStreaming,
        'isVirtual': isVirtual,
        'isSportsbook': isSportsbook,
        'isCasinoGame': isCasinoGame,
      };
}

class OddsData {
  final bool inPlay;
  final bool preBet;
  final int betDelay;
  final int totalMatched;
  final String status;
  final bool crossMatching;
  final List<Runners> runners;

  OddsData({
    required this.inPlay,
    required this.preBet,
    required this.betDelay,
    required this.totalMatched,
    required this.status,
    required this.crossMatching,
    required this.runners,
  });

  factory OddsData.fromJson(Map<String, dynamic> json) {
    return OddsData(
      inPlay: json['inPlay'] as bool,
      preBet: json['preBet'] as bool,
      betDelay: json['betDelay'] as int,
      totalMatched: json['totalMatched'] as int,
      status: json['status'] as String,
      crossMatching: json['crossMatching'] as bool,
      runners: (json['runners'] as List)
          .map((e) => Runners.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'inPlay': inPlay,
        'preBet': preBet,
        'betDelay': betDelay,
        'totalMatched': totalMatched,
        'status': status,
        'crossMatching': crossMatching,
        'runners': runners.map((e) => e.toJson()).toList(),
      };
}

class Runners {
  final int selectionId;
  final int handicap;
  final String status;
  final Price price;

  Runners({
    required this.selectionId,
    required this.handicap,
    required this.status,
    required this.price,
  });

  factory Runners.fromJson(Map<String, dynamic> json) {
    return Runners(
      selectionId: json['selectionId'] as int,
      handicap: json['handicap'] as int,
      status: json['status'] as String,
      price: Price.fromJson(json['price'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'selectionId': selectionId,
        'handicap': handicap,
        'status': status,
        'price': price.toJson(),
      };
}

class Price {
  final List<Back> back;
  final List<Lay> lay;

  Price({
    required this.back,
    required this.lay,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      back: (json['back'] as List)
          .map((e) => Back.fromJson(e as Map<String, dynamic>))
          .toList(),
      lay: (json['lay'] as List)
          .map((e) => Lay.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'back': back.map((e) => e.toJson()).toList(),
        'lay': lay.map((e) => e.toJson()).toList(),
      };
}

class Back {
  final int? size;
  final int? price;

  Back({
    this.size,
    this.price,
  });

  factory Back.fromJson(Map<String, dynamic> json) {
    return Back(
      size: json['size'] as int?,
      price: json['price'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'size': size,
        'price': price,
      };
}

class Lay {
  final int? size;
  final int? price;

  Lay({
    this.size,
    this.price,
  });

  factory Lay.fromJson(Map<String, dynamic> json) {
    return Lay(
      size: json['size'] as int?,
      price: json['price'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'size': size,
        'price': price,
      };
}

class RunnersData {
  final String v1;
  final String v2;
  final String v3;

  RunnersData({
    required this.v1,
    required this.v2,
    required this.v3,
  });

  factory RunnersData.fromJson(Map<String, dynamic> json) {
    return RunnersData(
      v1: json['58805'] as String,
      v2: json['5181445'] as String,
      v3: json['8015153'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        '58805': v1,
        '5181445': v2,
        '8015153': v3,
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

class SportsListModel {
  List<Data>? data;
  Meta? meta;

  SportsListModel({this.data, this.meta});

  SportsListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Data {
  String? sportId;
  String? sportName;
  bool? highlight;
  int? sequence;
  bool? popular;
  bool? status;
  bool? others;

  Data(
      {this.sportId,
      this.sportName,
      this.highlight,
      this.sequence,
      this.popular,
      this.status,
      this.others});

  Data.fromJson(Map<String, dynamic> json) {
    sportId = json['sportId'];
    sportName = json['sportName'];
    highlight = json['highlight'];
    sequence = json['sequence'];
    popular = json['popular'];
    status = json['status'];
    others = json['others'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sportId'] = this.sportId;
    data['sportName'] = this.sportName;
    data['highlight'] = this.highlight;
    data['sequence'] = this.sequence;
    data['popular'] = this.popular;
    data['status'] = this.status;
    data['others'] = this.others;
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
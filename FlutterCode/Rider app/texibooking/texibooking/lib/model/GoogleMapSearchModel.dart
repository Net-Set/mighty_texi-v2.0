class GoogleMapSearchModel {
  List<Prediction>? predictions;
  String? status;

  GoogleMapSearchModel({this.predictions, this.status});

  factory GoogleMapSearchModel.fromJson(Map<String, dynamic> json) {
    return GoogleMapSearchModel(
      predictions: json['predictions'] != null ? (json['predictions'] as List).map((i) => Prediction.fromJson(i)).toList() : null,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.predictions != null) {
      data['predictions'] = this.predictions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Prediction {
  String? description;
  String? placeId;
  String? reference;
  List<String>? types;

  Prediction({this.description, this.placeId, this.reference,  this.types});

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      description: json['description'],
      placeId: json['place_id'],
      reference: json['reference'],
      types: json['types'] != null ? new List<String>.from(json['types']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['place_id'] = this.placeId;
    data['reference'] = this.reference;
    if (this.types != null) {
      data['types'] = this.types;
    }
    return data;
  }
}
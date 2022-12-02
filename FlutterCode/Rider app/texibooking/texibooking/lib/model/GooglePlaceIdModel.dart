class GooglePlaceIdModel {
  Result? result;
  String? status;

  GooglePlaceIdModel({this.result, this.status});

  factory GooglePlaceIdModel.fromJson(Map<String, dynamic> json) {
    return GooglePlaceIdModel(
      result: json['result'] != null ? Result.fromJson(json['result']) : null,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  Geometry? geometry;
  String? icon;
  String? vicinity;

  Result({this.geometry, this.icon, this.vicinity});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      geometry: json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null,
      icon: json['icon'],
      vicinity: json['vicinity'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['icon'] = this.icon;
    data['vicinity'] = this.vicinity;
    if (this.geometry != null) {
      data['geometry'] = this.geometry!.toJson();
    }

    return data;
  }
}

class Geometry {
  Location? location;

  Geometry({this.location});

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      location: json['location'] != null ? Location.fromJson(json['location']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    return data;
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
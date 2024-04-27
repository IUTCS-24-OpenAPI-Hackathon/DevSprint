class propertiesModel{

  final Coordinates coordinates;

  propertiesModel({
    required this.coordinates,
  });

  factory propertiesModel.fromJson(Map<String, dynamic> json) {
    return propertiesModel(
      coordinates: Coordinates.fromJson(json['coordinates']),
    );
  }
  
}

class Coordinates {
  final double lat;
  final double long;

  Coordinates({required this.lat, required this.long});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      lat: json['latitude'],
      long: json['longitude'],
    );
  }
}
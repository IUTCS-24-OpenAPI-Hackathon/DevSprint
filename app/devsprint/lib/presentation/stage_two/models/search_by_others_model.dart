class SearchByOthersModel {
  List<Data> data;
  String status;

  SearchByOthersModel({required this.data, required this.status});

  factory SearchByOthersModel.fromJson(Map<String, dynamic> json) {
    return SearchByOthersModel(
      data: (json['data'] as List).map((e) => Data.fromJson(e)).toList(),
      status: json['status'],
    );
  }
}

class Data {
  Weather weather;

  Properties properties;
  String type;

  Data({required this.weather,  required this.properties, required this.type});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      weather: Weather.fromJson(json['weather']),
      // geometry: Geometry.fromJson(json['geometry']),
      properties: Properties.fromJson(json['properties']),
      type: json['type']??"",
    );
  }
}

class Weather {
  Location location;
  Current current;

  Weather({required this.location, required this.current});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      location: Location.fromJson(json['location']),
      current: Current.fromJson(json['current']),
    );
  }
}

class Location {
  String name;
  String region;
  String country;
  double lat;
  double lon;
  String tzId;
  int localtimeEpoch;
  String localtime;

  Location(
      {required this.name,
      required this.region,
      required this.country,
      required this.lat,
      required this.lon,
      required this.tzId,
      required this.localtimeEpoch,
      required this.localtime});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      region: json['region'],
      country: json['country'],
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
      tzId: json['tz_id'],
      localtimeEpoch: json['localtime_epoch'],
      localtime: json['localtime'],
    );
  }
}

class Current {
  int lastUpdatedEpoch;
  String lastUpdated;
  double tempC;
  double tempF;
  int isDay;
  Condition condition;
  double windMph;
  double windKph;
  int windDegree;
  String windDir;
  double pressureMb;
  double pressureIn;
  double precipMm;
  int precipIn;
  int humidity;
  int cloud;
  double feelslikeC;
  double feelslikeF;
  int visKm;
  int visMiles;
  int uv;
  double gustMph;
  double gustKph;
  AirQuality airQuality;

  Current(
      {required this.lastUpdatedEpoch,
      required this.lastUpdated,
      required this.tempC,
      required this.tempF,
      required this.isDay,
      required this.condition,
      required this.windMph,
      required this.windKph,
      required this.windDegree,
      required this.windDir,
      required this.pressureMb,
      required this.pressureIn,
      required this.precipMm,
      required this.precipIn,
      required this.humidity,
      required this.cloud,
      required this.feelslikeC,
      required this.feelslikeF,
      required this.visKm,
      required this.visMiles,
      required this.uv,
      required this.gustMph,
      required this.gustKph,
      required this.airQuality});

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      lastUpdatedEpoch: json['last_updated_epoch'],
      lastUpdated: json['last_updated'],
      tempC: json['temp_c'].toDouble(),
      tempF: json['temp_f'].toDouble(),
      isDay: json['is_day'],
      condition: Condition.fromJson(json['condition']),
      windMph: json['wind_mph'].toDouble(),
      windKph: json['wind_kph'].toDouble(),
      windDegree: json['wind_degree'],
      windDir: json['wind_dir'],
      pressureMb: json['pressure_mb'].toDouble(),
      pressureIn: json['pressure_in'].toDouble(),
      precipMm: json['precip_mm'].toDouble(),
      precipIn: json['precip_in'],
      humidity: json['humidity'],
      cloud: json['cloud'],
      feelslikeC: json['feelslike_c'].toDouble(),
      feelslikeF: json['feelslike_f'].toDouble(),
      visKm: json['vis_km'],
      visMiles: json['vis_miles'],
      uv: json['uv'],
      gustMph: json['gust_mph'].toDouble(),
      gustKph: json['gust_kph'].toDouble(),
      airQuality: AirQuality.fromJson(json['air_quality']),
    );
  }
}

class Condition {
  String text;
  String icon;
  int code;

  Condition({required this.text, required this.icon, required this.code});

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text'],
      icon: json['icon'],
      code: json['code'],
    );
  }
}

class AirQuality {
  int co;
  int no2;
  int o3;
  int so2;
  int pm25;
  int pm10;
  int usEpaIndex;
  int gbDefraIndex;

  AirQuality(
      {required this.co,
      required this.no2,
      required this.o3,
      required this.so2,
      required this.pm25,
      required this.pm10,
      required this.usEpaIndex,
      required this.gbDefraIndex});

  factory AirQuality.fromJson(Map<String, dynamic> json) {
    return AirQuality(
      co: json['co'],
      no2: json['no2'],
      o3: json['o3'],
      so2: json['so2'],
      pm25: json['pm2_5'],
      pm10: json['pm10'],
      usEpaIndex: json['us-epa-index'],
      gbDefraIndex: json['gb-defra-index'],
    );
  }
}

// class Geometry {
//   List<double> coordinates;
//   String type;

//   Geometry({required this.coordinates, required this.type});

//   factory Geometry.fromJson(Map<String, dynamic> json) {
//     return Geometry(
//       coordinates: List<double>.from(json['coordinates'].map((x) => x.toDouble())),
//       type: json['type'],
//     );
//   }
// }

class Properties {
  String address;
  Context context;
  Coordinates coordinates;
  ExternalIds externalIds;
  String featureType;
  String fullAddress;
  String language;
  String maki;
  String mapboxId;
  Map<String, dynamic> metadata;
  String name;
  String placeFormatted;
  List<String>? poiCategory;
  List<String>? poiCategoryIds;

  Properties(
      {required this.address,
      required this.context,
      required this.coordinates,
      required this.externalIds,
      required this.featureType,
      required this.fullAddress,
      required this.language,
      required this.maki,
      required this.mapboxId,
      required this.metadata,
      required this.name,
      required this.placeFormatted,
      required this.poiCategory,
      required this.poiCategoryIds});

  factory Properties.fromJson(Map<String, dynamic> json) {
    return Properties(
      address: json['address'],
      context: Context.fromJson(json['context']),
      coordinates: Coordinates.fromJson(json['coordinates']),
      externalIds: ExternalIds.fromJson(json['external_ids']),
      featureType: json['feature_type']??"",
      fullAddress: json['full_address'],
      language: json['language']??"",
      maki: json['maki'] ?? "",
      mapboxId: json['mapbox_id']??"",
      metadata: json['metadata'],
      name: json['name'],
      placeFormatted: json['place_formatted']??"",
      poiCategory: json['poi_category'] == null ? null : List<String>.from(json['poi_category']),
      poiCategoryIds: json['poi_category_ids'] == null? null : List<String>.from(json['poi_category_ids']),
    );
  }
}

class Context {
  Country country;
  Place place;
  Postcode postcode;

  Context({required this.country, required this.place, required this.postcode});

  factory Context.fromJson(Map<String, dynamic> json) {
    return Context(
      country: Country.fromJson(json['country']),
      place: Place.fromJson(json['place']),
      postcode: Postcode.fromJson(json['postcode']),
    );
  }
}

class Country {
  String countryCode;
  String name;

  Country({required this.countryCode, required this.name});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      countryCode: json['country_code'],
      name: json['name'],
    );
  }
}

class Place {
  String name;

  Place({required this.name});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      // id: json['id'],
      name: json['name']?? "",
    );
  }
}

class Postcode {
  String name;

  Postcode({required this.name});

  factory Postcode.fromJson(Map<String, dynamic> json) {
    return Postcode(
      name: json['name'],
    );
  }
}

class Coordinates {
  double latitude;
  double longitude;
  List<RoutablePoints>? routablePoints;

  Coordinates({required this.latitude, required this.longitude, required this.routablePoints});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      latitude: json['latitude'],
      longitude: json['longitude'],
      routablePoints: json['routable_points'] == null? null : List<RoutablePoints>.from(json['routable_points'].map((x) => RoutablePoints.fromJson(x))),
    );
  }
}

class RoutablePoints {
  double latitude;
  double longitude;
  String name;

  RoutablePoints({required this.latitude, required this.longitude, required this.name});

  factory RoutablePoints.fromJson(Map<String, dynamic> json) {
    return RoutablePoints(
      latitude: json['latitude'],
      longitude: json['longitude'],
      name: json['name'],
    );
  }
}

class ExternalIds {
  String? foursquare;

  ExternalIds({this.foursquare});

  factory ExternalIds.fromJson(Map<String, dynamic> json) {
    return ExternalIds(
      foursquare: json['foursquare'],
    );
  }
}

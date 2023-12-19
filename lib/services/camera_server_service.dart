import 'package:flutter/material.dart' as material;
import 'package:http/http.dart' as http;
import 'package:motah/models/parking_status.dart';
import 'package:motah/models/predections.dart';

import '../const.dart';

class CameraServerService {
  String baseUrl = URL;
// singleton
  static final CameraServerService _cameraServerService =
      CameraServerService._internal();

  factory CameraServerService() => _cameraServerService;

  CameraServerService._internal();

// http get request url to get image file mime type jpg
  Future<material.ImageProvider> getImage() async {
    String cameraUrl = "$baseUrl/image";
    final getImage = await http.get(Uri.parse(cameraUrl));
    print(getImage.statusCode);
    if (getImage.statusCode == 200) {
      var image = material.Image.memory(getImage.bodyBytes).image;
      return image;
    } else {
      return Future.error('Error: ${getImage.statusCode}');
    }
  }

  // http get request url to get json object
  Future<ParkingStatus> getTraffic() async {
    String trafficUrl = "$baseUrl/traffic";
    final getJson = await http.get(Uri.parse(trafficUrl));
    print(getJson.statusCode);
    if (getJson.statusCode == 200) {
      ParkingStatus predection = parkingStatusFromJson(getJson.body);
      return predection;
    } else {
      return Future.error('Error: ${getJson.statusCode}');
    }
  }

  // http get request url to get json object
  Future<List<Predictions>> getPredictionsJson() async {
    String predectionsUrl = "$baseUrl/predections";
    final getJson = await http.get(Uri.parse(predectionsUrl));
    print(getJson.statusCode);
    if (getJson.statusCode == 200) {
      List<Predictions> predection = predictionsFromJson(getJson.body);
      return predection;
    } else {
      return Future.error('Error: ${getJson.statusCode}');
    }
  }
}

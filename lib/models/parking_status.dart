// To parse this JSON data, do
//
//     final parkingStatus = parkingStatusFromJson(jsonString);

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

ParkingStatus parkingStatusFromJson(String str) => ParkingStatus.fromJson(json.decode(str));

String parkingStatusToJson(ParkingStatus data) => json.encode(data.toJson());

class ParkingStatus {
    ParkingStatus({
        required this.spaceOccupied,
        required this.spaceEmpty,
        this.timestamp,
    });

    final int spaceOccupied;
    final int spaceEmpty;
    final Timestamp? timestamp;

    factory ParkingStatus.fromJson(Map<String, dynamic> json) => ParkingStatus(
        spaceOccupied: json["space_occupied"],
        spaceEmpty: json["space_empty"],
        timestamp: json["timestamp"],
    );

    Map<String, dynamic> toJson() => {
        "space_occupied": spaceOccupied,
        "space_empty": spaceEmpty,
        "timestamp": timestamp,
    };
}

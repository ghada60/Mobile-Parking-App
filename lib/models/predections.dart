// To parse this JSON data, do
//
//     final predictions = predictionsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Predictions> predictionsFromJson(String str) => List<Predictions>.from(json.decode(str).map((x) => Predictions.fromJson(x)));

String predictionsToJson(List<Predictions> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Predictions {
    Predictions({
        required this.predictionClass,
        required this.confidence,
        required this.height,
        required this.id,
        required this.width,
        required this.x,
        required this.y,
    });

    final Class predictionClass;
    final double confidence;
    final double height;
    final int id;
    final double width;
    final double x;
    final double y;

    factory Predictions.fromJson(Map<String, dynamic> json) => Predictions(
        predictionClass: classValues.map[json["class"]]!,
        confidence: json["confidence"]?.toDouble(),
        height: json["height"]?.toDouble(),
        id: json["id"],
        width: json["width"]?.toDouble(),
        x: json["x"]?.toDouble(),
        y: json["y"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "class": classValues.reverse[predictionClass],
        "confidence": confidence,
        "height": height,
        "id": id,
        "width": width,
        "x": x,
        "y": y,
    };
}

enum Class { CAR, EMPTY }

final classValues = EnumValues({
    "Car": Class.CAR,
    "Empty": Class.EMPTY
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motah/models/parking_status.dart';

class FirestoreService {
  FirestoreService._();

  static final instance = FirestoreService._();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> setData({String? path, Map<String, dynamic>? data}) async {
    final reference = _db.doc(path!);

    print('$path: $data');

    await reference.set(data!);
  }

  Future<void> deleteData({String? path}) async {
    final reference = _db.doc(path!);

    print('deleting $path');

    await reference.delete();
  }

// get parking_status dialy report future
  Future<List<ParkingStatus>> getMonthlyParkingStatus(Timestamp today) async {
    var snapshot = await _db
        .collection('parking_status')
        .orderBy('timestamp', descending: true)
        .get();
    List<ParkingStatus> list =
        snapshot.docs.map((doc) => ParkingStatus.fromJson(doc.data())).toList();
    // get records for each week in last 4 weeks from today
    List<ParkingStatus> list2 = [];
    for (int i = 0; i < 4; i++) {
      Timestamp week =
          Timestamp.fromDate(today.toDate().subtract(Duration(days: i * 7)));
      ParkingStatus ps = list.firstWhere(
          (element) => element.timestamp!.toDate().day == week.toDate().day,
          orElse: () =>
              ParkingStatus(spaceOccupied: 0, spaceEmpty: 0, timestamp: week));
      list2.add(ps);
    }

    return list2;
  }

// get parking_status weekly report future
  Future<List<ParkingStatus>> getWeeklyParkingStatus(Timestamp today) async {
    var snapshot = await _db
        .collection('parking_status')
        .orderBy('timestamp', descending: true)
        .get();
    List<ParkingStatus> list =
        snapshot.docs.map((doc) => ParkingStatus.fromJson(doc.data())).toList();
    // get records for each day in last 7 days from today
    List<ParkingStatus> list2 = [];
    for (int i = 0; i < 7; i++) {
      Timestamp day =
          Timestamp.fromDate(today.toDate().subtract(Duration(days: i)));
      ParkingStatus ps = list.firstWhere(
          (element) => element.timestamp!.toDate().day == day.toDate().day,
          orElse: () =>
              ParkingStatus(spaceOccupied: 0, spaceEmpty: 0, timestamp: day));
      list2.add(ps);
    }
    return list2;
  }

// get parking_status hourly report future
  Future<List<ParkingStatus>> getDailyParkingStatus(Timestamp today) async {
    var snapshot = await _db.collection('parking_status').get();
    List<ParkingStatus> list =
        snapshot.docs.map((doc) => ParkingStatus.fromJson(doc.data())).toList();

    // get records for each hour in last 24 hours from today
    List<ParkingStatus> list2 = [];
    for (int i = 0; i < 24; i++) {
      Timestamp hour =
          Timestamp.fromDate(today.toDate().subtract(Duration(hours: i)));
      ParkingStatus ps = list.firstWhere(
          (element) =>
              element.timestamp != null &&
              element.timestamp!.toDate().hour == hour.toDate().hour,
          orElse: () =>
              ParkingStatus(spaceOccupied: 0, spaceEmpty: 0, timestamp: hour));
      list2.add(ps);
    }
    return list2;
  }
}

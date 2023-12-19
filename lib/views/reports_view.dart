import 'package:charts_painter/chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motah/models/parking_status.dart';
import 'package:motah/services/firestore_service.dart';
import 'package:motah/widgets/custom_widgets.dart';

class ReportsView extends StatefulWidget {
  const ReportsView({super.key});

  @override
  State<ReportsView> createState() => _ReportsViewState();
}

class _ReportsViewState extends State<ReportsView> {
  // firestore_service
  FirestoreService firestoreService = FirestoreService.instance;
  Future<List<ParkingStatus>>? future;
  String? dropdownValue;
  @override
  Widget build(BuildContext context) {
    // height of the screen
    double height = MediaQuery.of(context).size.height;
    // width of the screen
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: MotahAppBar(context, "Reports Page", height * 0.15, false),
      body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                        if (dropdownValue == 'Daily') {
                          future = firestoreService.getDailyParkingStatus(Timestamp.now());
                        } else if (dropdownValue == 'Weekly') {
                          future = firestoreService.getWeeklyParkingStatus(Timestamp.now());
                        } else if (dropdownValue == 'Monthly') {
                          future = firestoreService.getMonthlyParkingStatus(Timestamp.now());
                        }
                      },
                      items: <String>['Daily', 'Weekly', 'Monthly']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  Text(
                    '$dropdownValue Traffic Report',
                  ),
                  FutureBuilder<List<ParkingStatus>>(
                    future: future,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error');
                      } else if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.data == null) {
                        return Text('No data');
                      }
                      List<ParkingStatus> parkingStatusList = snapshot.data!;
                      if (parkingStatusList.isEmpty) {
                        return Text('No data');
                      }
                      return Chart(
                        
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        state: ChartState<void>(
                          data: ChartData.fromList(
                            parkingStatusList.map((e) => ChartItem<void>(e.spaceOccupied.toDouble()/20 *100)).toList(),
                            axisMax: 5,
                          ),
                          itemOptions: BarItemOptions(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                            barItemBuilder: (_) => BarItem(
                              color: Colors.purple,
                              
                            ),
                          ),
                          backgroundDecorations: [
                            GridDecoration(
                              verticalAxisStep: 1,
                              horizontalAxisStep: 4,
                              horizontalAxisUnit: "%",
                              showTopHorizontalValue: true,
                              showVerticalGrid: true,
                              showHorizontalGrid: true,
                              showHorizontalValues: true,
                              showVerticalValues: true,
                              horizontalAxisValueFromValue: (value) =>
                                  value.toInt().toString(),
                              verticalAxisValueFromIndex: (value) =>
                                  value.toInt().toString(),
                              textStyle: Theme.of(context).textTheme.caption,
                              gridColor: Theme.of(context).dividerColor,
                            ),
                            SparkLineDecoration(
                              lineColor: Theme.of(context).accentColor,
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                ],
              ),
    );
  }
}
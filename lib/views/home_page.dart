import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motah/models/parking_status.dart';
import 'package:motah/models/predections.dart';
import 'package:motah/services/camera_server_service.dart';
import 'package:motah/views/bottom_views/home_bottom_tap.dart';
import 'package:motah/views/map_view.dart';
import 'package:motah/widgets/custom_widgets.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CameraServerService cameraServerService = CameraServerService();
  // get current user
  User? user = FirebaseAuth.instance.currentUser;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // height of the screen
    double screenHeight = MediaQuery.of(context).size.height;
    List<Widget> _widgetOptions = user != null && user!.isAnonymous == false
        ? <Widget>[
            HomeNavBar(),
            Expanded(child: MapView()),
          ]
        : <Widget>[
            Expanded(child: MapView()),
            FutureBuilder<List<Predictions>>(
                future: cameraServerService.getPredictionsJson(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Predictions> predictions = snapshot.data!;
                    // sort predictions by id
                    predictions.sort((a, b) => a.id.compareTo(b.id));
                    // draw two rows each on them contains 10 predictions
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (int i = 0; i < 10; i++)
                            if(i == 8 || i == 9)
                            Icon(Icons.accessible_outlined,
                              color: predictions[i].predictionClass.name == 'CAR' ? Colors.red : Colors.green,
                              )
                            else
                              Icon(Icons.directions_car,
                              color: predictions[i].predictionClass.name == 'CAR' ? Colors.red : Colors.green,
                              )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (int i = 10; i < 20; i++)
                              if(i == 18 || i == 19)
                            Icon(Icons.accessible_outlined,
                              color: predictions[i].predictionClass.name == 'CAR' ? Colors.red : Colors.green,
                              )
                            else
                              Icon(Icons.directions_car,
                              color: predictions[i].predictionClass.name == 'CAR' ? Colors.red : Colors.green,
                              )
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
            FutureBuilder<ParkingStatus>(
                future: cameraServerService.getTraffic(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    int space_empty = snapshot.data!.spaceEmpty;
                    int space_occupied = snapshot.data!.spaceOccupied;
                    int totalParkingSlots = space_empty + space_occupied;
                    // half of total parking slots
                    int halfParkingSlots = totalParkingSlots ~/ 2;

                    // draw grid the number of cars based on the data from the server
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      //  show all details in style
                      Text(
                        'Traffic Status',
                        style: optionStyle,
                      ),
                      Text(
                        'Total Cars: $space_occupied',
                        style: optionStyle,
                      ),
                      // traffic status with color
                      Text(
                        'Traffic Status: ${space_occupied > 15 ? 'Busy' : 'Not Busy'}',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color:
                              space_occupied > 15 ? Colors.red : Colors.green,
                        ),
                      ),
                      // warning icon color based on traffic status
                      Icon(
                        Icons.warning,
                        color: space_occupied > 15 ? Colors.red : Colors.green,
                        size: 100,
                      ),
                    ]);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ];

    return Scaffold(
        appBar: MotahAppBar(context, "Home Page", screenHeight *0.15, true),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
            items: user != null && user!.isAnonymous == false
                ? [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.watch_later_outlined),
                      label: 'Arrival Time',
                    ),
                  ]
                : [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.watch_later_outlined),
                      label: 'Arrival Time',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.local_parking_outlined),
                      label: 'Parking Status',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.minor_crash),
                      label: 'Congestion',
                    ),
                  ],
            selectedItemColor: Colors.purple,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped));
  }
}

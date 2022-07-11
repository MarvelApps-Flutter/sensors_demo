import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<double>? _accelerometerValues;
  List<double>? _userAccelerometerValues;
  List<double>? _gyroscopeValues;
  List<double>? _magnetometerValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  @override
  Widget build(BuildContext context) {
    final accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
    final gyroscope =
        _gyroscopeValues?.map((double v) => v.toStringAsFixed(1)).toList();
    final userAccelerometer = _userAccelerometerValues
        ?.map((double v) => v.toStringAsFixed(1))
        .toList();
    final magnetometer =
        _magnetometerValues?.map((double v) => v.toStringAsFixed(1)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensors Module'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              accelerometer == null
                  ? Container()
                  : _displayCard('Accelerometer', accelerometer),
              userAccelerometer == null
                  ? Container()
                  : _displayCard('UserAccelerometer', userAccelerometer),
              gyroscope == null
                  ? Container()
                  : _displayCard('Gyroscope', gyroscope),
              magnetometer == null
                  ? Container()
                  : _displayCard('Magnetometer', magnetometer),
            ],
          ),
        ),
      ),
    );
  }

  Widget _displayCard(String title, List<String> sensorValue) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Card(
          color: Colors.blueGrey.shade100,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    title,
                    textScaleFactor: 2,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 5,
                      color: Colors.red.shade100,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'X-axis: ',
                          textScaleFactor: 2,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 70,
                      child: Text(
                        sensorValue[0],
                        textScaleFactor: 2,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 5,
                      color: Colors.blue.shade100,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Y-axis: ',
                          textScaleFactor: 2,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 70,
                      child: Text(
                        sensorValue[1],
                        textScaleFactor: 2,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 5,
                      color: Colors.orange.shade100,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Z-axis: ',
                          textScaleFactor: 2,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 70,
                      child: Text(
                        sensorValue[2],
                        textScaleFactor: 2,
                      ),
                    ),
                  ],
                ),

                // Text(
                //   'Y-axis: ${sensorValue[1]}',
                //   textScaleFactor: 2,
                // ),
                // Text(
                //   'Z-axis: ${sensorValue[2]}',
                //   textScaleFactor: 2,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(
      accelerometerEvents.listen(
        (AccelerometerEvent event) {
          setState(() {
            _accelerometerValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
    _streamSubscriptions.add(
      gyroscopeEvents.listen(
        (GyroscopeEvent event) {
          setState(() {
            _gyroscopeValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
    _streamSubscriptions.add(
      userAccelerometerEvents.listen(
        (UserAccelerometerEvent event) {
          setState(() {
            _userAccelerometerValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
    _streamSubscriptions.add(
      magnetometerEvents.listen(
        (MagnetometerEvent event) {
          setState(() {
            _magnetometerValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
  }
}

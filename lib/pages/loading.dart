import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time/services/world_time.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setUpWorldTime() async {
    WorldTime obj =
        WorldTime(flag: 'India.png', location: 'Delhi', url: 'Asia/Kolkata');
    await obj.getTime();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'flag': obj.flag,
        'time': obj.time.toString(),
        'location': obj.location,
        'isDayTime': obj.isDayTime,
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setUpWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SpinKitSpinningLines(
          color: Colors.amber,
          size: 100,
        ),
      ),
    );
  }
}

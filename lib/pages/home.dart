import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;
    print(data);
    String bgImage = data['isDayTime'] ? 'day.jfif' : 'night.jfif';
    Color? bgImageColor = data['isDayTime'] ? Colors.blue : Colors.indigo[900];
    Color? timeColor = data['isDayTime'] ? Colors.black : Colors.white;
    return Scaffold(
      backgroundColor: bgImageColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('../assets/images/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
                child: TextButton.icon(
                  style: TextButton.styleFrom(primary: timeColor),
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result['time'],
                        'isDayTime': result['isDayTime'],
                        'flag': result['flag'],
                        'location': result['location'],
                      };
                    });
                  },
                  icon: Icon(Icons.edit_location),
                  label: Text('Edit location'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data['location'],
                    style: TextStyle(
                      fontSize: 28,
                      letterSpacing: 2,
                      color: timeColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                data['time'],
                style: TextStyle(
                  fontSize: 66,
                  color: timeColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

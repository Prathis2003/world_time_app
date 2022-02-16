import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String? flag;
  String? url;
  String? time;
  String? location;
  bool? isDayTime;
  WorldTime({this.location, this.url, this.flag});
  Future<void> getTime() async {
    try {
      Response response = await get(
        Uri.parse('http://worldtimeapi.org/api/timezone/$url'),
      );
      Map data = jsonDecode(response.body);

      String offset_hours = data['utc_offset'].substring(1, 3);
      String offset_minutes = data['utc_offset'].substring(4, 6);
      String datetime = data['utc_datetime'];
      DateTime now = DateTime.parse(datetime);
      now = now.add(
        Duration(
          hours: int.parse(offset_hours),
          minutes: int.parse(offset_minutes),
        ),
      );
      isDayTime = now.hour >= 6 && now.hour < 18 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Error caught:$e');
      time = "Could not get time data";
    }
  }
}

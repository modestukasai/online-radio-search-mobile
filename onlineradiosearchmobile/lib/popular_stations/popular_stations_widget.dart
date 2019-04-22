import 'package:flutter/material.dart';
import 'package:onlineradiosearchmobile/popular_stations/popular_stations_data_source.dart';

class PopularStationsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PopularStationsWidgetState();
  }
}

class PopularStationsWidgetState extends State<PopularStationsWidget> {
  var _stations = List<Station>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: items(),
    );
  }

  Widget items() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (_stations.length == 0 && i == 0) {
            return _loading();
          }
          debugPrint("Index: ${i}");
          if (i < _stations.length) {
            return _buildRow(_stations[i]);
          } else {
            return null;
          }
        });
  }

  Widget _loading() {
    return ListTile(
      title: Text('Loading...', style: TextStyle(fontSize: 18.0)),
    );
  }

  Widget _buildRow(Station station) {
    return ListTile(
      onTap: () {
        debugPrint("Index: ${station.url}");
      },
      title:
          Text(station.title.toLowerCase(), style: TextStyle(fontSize: 18.0)),
    );
  }
}

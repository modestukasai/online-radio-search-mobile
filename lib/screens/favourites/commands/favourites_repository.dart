import 'dart:async';

import 'package:onlineradiosearchmobile/db/app_database.dart';
import 'package:optional/optional_internal.dart';

class FavouritesRepository {
  static Future<List<FavouriteStation>> findAll() async {
    return AppDatabase.init()
        .then((db) => db.query(Tables.favouriteRadioStations))
        .then((value) => value.map(FavouriteStation._fromMap).toList());
  }

  static Future<Optional<FavouriteStation>> findOne(
          String radioStationId) async =>
      await AppDatabase.init()
          .then((db) => db.query(Tables.favouriteRadioStations,
              where: 'radioStationId = ?', whereArgs: [radioStationId]))
          .then((value) => value.length > 0 ? value.first : null)
          .then(FavouriteStation._fromMap)
          .then((value) => Optional.ofNullable(value));

  static Future<int> insert(FavouriteStation model) async {
    return AppDatabase.init()
        .then((db) => db.insert(Tables.favouriteRadioStations, model.toMap()));
  }

  static Future<void> delete(int id) async => await AppDatabase.init().then(
      (db) => db.delete(Tables.favouriteRadioStations,
          where: 'id = ?', whereArgs: [id]));
}

class FavouriteStation {
  final int id;
  final String radioStationId;
  final String uniqueId;
  final String title;
  final String streamUrl;
  final List<String> genres;

  const FavouriteStation(
      {this.id,
      this.radioStationId,
      this.uniqueId,
      this.title,
      this.streamUrl,
      this.genres});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'radioStationId': radioStationId,
      'uniqueId': uniqueId,
      'title': title,
      'streamUrl': streamUrl,
      'genres': genres.isEmpty ? "" : genres.join(";")
    };
    return map;
  }

  static FavouriteStation _fromMap(Map<String, dynamic> input) {
    if (input == null) {
      return null;
    }
    var genres = (input['genres'] as String);
    return FavouriteStation(
      id: input['id'] as int,
      radioStationId: input['radioStationId'].toString(),
      uniqueId: input['uniqueId'],
      title: input['title'],
      streamUrl: input['streamUrl'],
      genres: genres.isEmpty ? [] : genres.split(';'),
    );
  }
}

import 'dart:convert';

import 'package:ditonton/data/models/tv_show_model.dart';
import 'package:ditonton/data/models/tv_show_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvShowModel = TvShowModel(
    backdropPath: '/kfUWupX3phYp7AleZA2U1dmVcjX.jpg',
    firstAirDate: '2013-09-12',
    genreIds: [18, 80],
    id: 60574,
    name: 'Peaky Blinders',
    originalLanguage: 'en',
    originalName: 'Peaky Blinders',
    overview:
        'A gangster family epic set in 1919 Birmingham, England and centered on a gang who sew razor blades in the peaks of their caps, and their fierce boss Tommy Shelby, who means to move up in the world.',
    popularity: 1555.966,
    posterPath: '/vUUqzWa2LnHIVqkaKVlVGkVcZIW.jpg',
    voteAverage: 8.6,
    voteCount: 5732,
  );

  final tTvShowResponseModel =
      TvShowResponse(tvShowList: <TvShowModel>[tTvShowModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_now_airing.json'));
      // act
      final result = TvShowResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvShowResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvShowResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "backdropPath",
            "first_air_date": "firstAirDate",
            "genre_ids": [1, 2, 3],
            "id": 1,
            "name": "name",
            "original_language": "originalLanguage",
            "original_name": "originalName",
            "overview": "overview",
            "popularity": 1,
            "poster_path": "posterPath",
            "vote_average": 1,
            "vote_count": 1,
          }
        ]
      };
      expect(result, expectedJsonMap);
    });
  });
}

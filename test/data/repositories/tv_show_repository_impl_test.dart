import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tv_show_detail_model.dart';
import 'package:ditonton/data/models/tv_show_model.dart';
import 'package:ditonton/data/models/tv_show_table.dart';
import 'package:ditonton/data/repositories/tv_show_repository_impl.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvShowRepositoryImpl repository;
  late MockTvShowRemoteDataSource mockRemoteDataSource;
  late MockTvShowLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockTvShowRemoteDataSource();
    mockLocalDataSource = MockTvShowLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TvShowRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tTvShowModel = TvShowModel(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvShow = TvShow(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvShowModelList = <TvShowModel>[tTvShowModel];
  final tTvShowList = <TvShow>[tTvShow];

  group('Now Airing Tv Shows', () {
    test('should return tv shows list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowAiringTvShows())
          .thenAnswer((_) async => tTvShowModelList);
      // act
      final result = await repository.getNowAiringTvShows();

      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowAiringTvShows())
          .thenThrow(ServerException());
      // act
      final result = await repository.getNowAiringTvShows();

      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowAiringTvShows())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowAiringTvShows();

      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Popular Tv Shows', () {
    test('should return list of tv shows when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvShows())
          .thenAnswer((_) async => tTvShowModelList);

      //  act
      final result = await repository.getPopularTvShows();

      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test('should return server failure when call to data source is unsuccesful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvShows())
          .thenThrow(ServerException());

      // act
      final call = await repository.getPopularTvShows();

      // assert
      expect(call, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvShows())
          .thenThrow(SocketException('Failed to connect to the network'));

      // act
      final call = await repository.getPopularTvShows();

      // assert
      expect(call, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Tv Shows', () {
    test('should return list of tv shows when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvShows())
          .thenAnswer((_) async => tTvShowModelList);

      // act
      final result = await repository.getTopRatedTvShows();

      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvShows())
          .thenThrow(ServerException());

      // act
      final call = await repository.getTopRatedTvShows();

      // assert
      expect(call, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvShows())
          .thenThrow(SocketException('Failed to connect to the network'));

      // act
      final call = await repository.getTopRatedTvShows();

      // assert
      expect(call, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Tv Show Detail', () {
    final tId = 1;
    final tTvShowResponse = TvShowDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      firstAirDate: 'firstAirDate',
      genres: [GenreModel(id: 1, name: 'name')],
      id: 1,
      lastAirDate: 'lastAirDate',
      name: 'name',
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      originalLanguage: 'originalLanguage',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      inProduction: false,
      nextEpisodeToAir: 'nextEpisodeToAir',
      languages: ['languages'],
      productionCompanies: ['productionCompanies'],
      type: 'type',
      episodeRunTime: [1],
      status: 'status',
      homepage: 'homepage',
      createdBy: ['createdBy'],
      originCountry: ['originCountry'],
      tagline: 'tagline',
      posterPath: 'posterPath',
      voteAverage: 1,
      voteCount: 1,
    );

    test('should return tv show detail when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowDetail(any))
          .thenAnswer((_) async => tTvShowResponse);

      // act
      final result = await repository.getTvShowDetail(tId);

      // assert
      verify(mockRemoteDataSource.getTvShowDetail(tId));
      expect(result, Right(testTvShowDetail));
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowDetail(any))
          .thenThrow(ServerException());

      // act
      final call = await repository.getTvShowDetail(tId);

      // assert
      verify(mockRemoteDataSource.getTvShowDetail(tId));
      expect(call, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connect to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowDetail(any))
          .thenThrow(SocketException('Failed to connect to the network'));

      // act
      final call = await repository.getTvShowDetail(tId);

      // assert
      verify(mockRemoteDataSource.getTvShowDetail(tId));
      expect(call, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Tv Show Recommendations', () {
    final tId = 1;
    final tTvShowList = <TvShowModel>[];

    test(
        'should return list of tv shows when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowRecommendations(any))
          .thenAnswer((_) async => tTvShowList);

      // act
      final result = await repository.getTvShowRecommendations(tId);

      // assert
      verify(mockRemoteDataSource.getTvShowRecommendations(tId));
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvShowList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowRecommendations(tId))
          .thenThrow(ServerException());

      // act
      final call = await repository.getTvShowRecommendations(tId);

      // assert
      verify(mockRemoteDataSource.getTvShowRecommendations(tId));
      expect(call, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));

      // act
      final call = await repository.getTvShowRecommendations(tId);

      // assert
      expect(call,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search Tv Shows', () {
    final tQuery = 'spiderman';

    test(
        'should return list of tv shows when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvShows(any))
          .thenAnswer((_) async => tTvShowModelList);

      // act
      final result = await repository.searchTvShows(tQuery);

      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });
    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvShows(tQuery))
          .thenThrow(ServerException());

      // act
      final call = await repository.searchTvShows(tQuery);

      // assert
      expect(call, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvShows(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));

      // act
      final call = await repository.searchTvShows(tQuery);

      // assert
      expect(call, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Save Watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource
              .insertWatchlist(TvShowTable.fromEntity(testTvShowDetail)))
          .thenAnswer((_) async => 'Added to Watchlist');

      // act
      final result = await repository.saveWatchlist(testTvShowDetail);

      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return database failure when saving unsuccesful', () async {
      // arrange
      when(mockLocalDataSource
              .insertWatchlist(TvShowTable.fromEntity(testTvShowDetail)))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTvShowDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('Remove Watchlist', () {
    test('should return success message when removing successful', () async {
      // arrange
      when(mockLocalDataSource
              .removeWatchlist(TvShowTable.fromEntity(testTvShowDetail)))
          .thenAnswer((_) async => 'Removed from Watchlist');

      // act
      final result = await repository.removeWatchlist(testTvShowDetail);

      // assert
      expect(result, Right('Removed from Watchlist'));
    });

    test('should return database failure when removing unsuccesful', () async {
      // arrange
      when(mockLocalDataSource
              .removeWatchlist(TvShowTable.fromEntity(testTvShowDetail)))
          .thenThrow(DatabaseException('Failed to remove watchlist'));

      // act
      final call = await repository.removeWatchlist(testTvShowDetail);

      // assert
      expect(call, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('Get Watchlist Status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getTvShowById(tId))
          .thenAnswer((_) async => null);

      // act
      final result = await repository.isAddedToWatchlist(tId);

      // assert
      expect(result, false);
    });
  });

  group('Get Watchlist Tv Shows', () {
    test('should return list of tv shows', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvShows())
          .thenAnswer((_) async => [testTvShowTable]);

      // act
      final result = await repository.getWatchlistTvShows();

      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvShow]);
    });
  });
}

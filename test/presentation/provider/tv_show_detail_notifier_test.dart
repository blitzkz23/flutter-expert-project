import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_tv_show_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_show_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_shows_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv_shows.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_shows.dart';
import 'package:ditonton/presentation/provider/tv_show_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_notifier_test.mocks.dart';
import 'tv_show_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvShowDetail,
  GetTvShowRecommendations,
  GetWatchlistTvShowsStatus,
  SaveWatchlistTvShows,
  RemoveWatchlistTvShows,
])
void main() {
  late TvShowDetailNotifier provider;
  late MockGetTvShowDetail mockGetTvShowDetail;
  late MockGetTvShowRecommendations mockGetTvShowRecommendations;
  late MockGetWatchlistTvShowsStatus mockGetWatchlistTvShowsStatus;
  late MockSaveWatchlistTvShows mockSaveWatchlistTvShows;
  late MockRemoveWatchlistTvShows mockRemoveWatchlistTvShows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvShowDetail = MockGetTvShowDetail();
    mockGetTvShowRecommendations = MockGetTvShowRecommendations();
    mockGetWatchlistTvShowsStatus = MockGetWatchlistTvShowsStatus();
    mockSaveWatchlistTvShows = MockSaveWatchlistTvShows();
    mockRemoveWatchlistTvShows = MockRemoveWatchlistTvShows();
    provider = TvShowDetailNotifier(
        getTvShowDetail: mockGetTvShowDetail,
        getTvShowRecommendations: mockGetTvShowRecommendations,
        getWatchlistTvShowsStatus: mockGetWatchlistTvShowsStatus,
        saveWatchlistTvShows: mockSaveWatchlistTvShows,
        removeWatchlistTvShows: mockRemoveWatchlistTvShows)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;

  final tTvShow = TvShow(
    id: 1,
    overview: 'overview',
    voteAverage: 1,
    voteCount: 1,
    posterPath: 'posterPath',
    genreIds: [1, 2, 3],
    name: 'name',
    originalLanguage: 'originalLanguage',
    popularity: 1,
    originalName: 'originalName',
    firstAirDate: 'firstAirDate',
    backdropPath: 'backdropPath',
  );

  final tTvShows = <TvShow>[tTvShow];

  void _arrangeUseCase() {
    when(mockGetTvShowDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvShowDetail));
    when(mockGetTvShowRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvShows));
  }

  group('Get Tv Show Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUseCase();

      // act
      await provider.fetchTvShowDetail(tId);

      // assert
      verify(mockGetTvShowDetail.execute(tId));
      verify(mockGetTvShowRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUseCase();

      // act
      provider.fetchTvShowDetail(tId);

      // assert
      expect(provider.tvShowState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv show when data is gotten successfully', () async {
      // arrange
      _arrangeUseCase();

      // act
      await provider.fetchTvShowDetail(tId);

      // assert
      expect(provider.tvShowState, RequestState.Loaded);
      expect(provider.tvShow, testTvShowDetail);
      expect(listenerCallCount, 3);
    });

    test(
        'should change recommendation tv shows when data is gotten successfully',
        () async {
      // arrange
      _arrangeUseCase();

      // act
      await provider.fetchTvShowDetail(tId);

      // assert
      expect(provider.tvShowState, RequestState.Loaded);
      expect(provider.tvRecommendations, tTvShows);
    });
  });

  group('Get Tv Show Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUseCase();

      // act
      await provider.fetchTvShowDetail(tId);

      // assert
      verify(mockGetTvShowRecommendations.execute(tId));
      expect(provider.tvRecommendations, tTvShows);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUseCase();

      // act
      await provider.fetchTvShowDetail(tId);

      // assert
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.tvRecommendations, tTvShows);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvShowDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvShowDetail));
      when(mockGetTvShowRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));

      // act
      await provider.fetchTvShowDetail(tId);

      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistTvShowsStatus.execute(tId))
          .thenAnswer((_) async => true);

      // act
      await provider.loadWatchlistStatus(1);

      // assert
      expect(provider.isAddedtoWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlistTvShows.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistTvShowsStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => true);

      // act
      await provider.addWatchlist(testTvShowDetail);

      // assert
      verify(mockSaveWatchlistTvShows.execute(testTvShowDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlistTvShows.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistTvShowsStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => false);

      // act
      await provider.removeFromWatchlist(testTvShowDetail);

      // assert
      verify(mockRemoveWatchlistTvShows.execute(testTvShowDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlistTvShows.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistTvShowsStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => true);

      // act
      await provider.addWatchlist(testTvShowDetail);

      // assert
      verify(mockGetWatchlistTvShowsStatus.execute(testTvShowDetail.id));
      expect(provider.isAddedtoWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlistTvShows.execute(testTvShowDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistTvShowsStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => true);

      // act
      await provider.addWatchlist(testTvShowDetail);

      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('On Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvShowDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvShowRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvShows));

      // act
      await provider.fetchTvShowDetail(tId);

      // assert
      expect(provider.tvShowState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}

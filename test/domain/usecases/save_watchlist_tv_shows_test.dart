import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SaveWatchlistTvShows usecase;
  late TvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = SaveWatchlistTvShows(mockTvShowRepository);
  });

  test('should save tv show to repository', () async {
    // arrange
    when(mockTvShowRepository.saveWatchlist(testTvShowDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));

    // act
    final result = await usecase.execute(testTvShowDetail);

    // assert
    verify(mockTvShowRepository.saveWatchlist(testTvShowDetail));
    expect(result, Right('Added to Watchlist'));
  });
}

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_show_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvShowLocalDataSourceImpl dataSource;
  late MockTvDatabaseHelper mockTvDatabaseHelper;

  setUp(() {
    mockTvDatabaseHelper = MockTvDatabaseHelper();
    dataSource =
        TvShowLocalDataSourceImpl(databaseHelper: mockTvDatabaseHelper);
  });

  group('save tv watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockTvDatabaseHelper.insertWatchlistTv(testTvShowTable))
          .thenAnswer((_) async => 1);

      // act
      final result = await dataSource.insertWatchlist(testTvShowTable);

      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockTvDatabaseHelper.insertWatchlistTv(testTvShowTable))
          .thenThrow(Exception());

      // act
      final call = dataSource.insertWatchlist(testTvShowTable);

      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });

    group('remove tv watchlist', () {
      test('should return success message when remove from database is success',
          () async {
        // arrange
        when(mockTvDatabaseHelper.removeWatchlistTv(testTvShowTable))
            .thenAnswer((_) async => 1);

        // act
        final result = await dataSource.removeWatchlist(testTvShowTable);

        //assert
        expect(result, 'Removed from Watchlist');
      });
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockTvDatabaseHelper.removeWatchlistTv(testTvShowTable))
          .thenThrow(Exception());

      // act
      final call = dataSource.removeWatchlist(testTvShowTable);

      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });
}

import 'package:ditonton/data/models/tv_show_table.dart';

abstract class TvShowLocalDataSource {
  Future<void> cacheNowAiringTvShows(List<TvShowTable> tvShows);
  Future<List<TvShowTable>> getCachedNowAiringTvShows();
  Future<String> insertWatchlist(TvShowTable tvShow);
  Future<String> removeWatchlist(TvShowTable tvShow);
  Future<TvShowTable?> getTvShowById(int id);
  Future<List<TvShowTable>> getWatchlistTvShows();
}

class TvShowLocalDataSourceImple implements TvShowLocalDataSource {
  @override
  Future<void> cacheNowAiringTvShows(List<TvShowTable> tvShows) {
    // TODO: implement cacheNowAiringTvShows
    throw UnimplementedError();
  }

  @override
  Future<List<TvShowTable>> getCachedNowAiringTvShows() {
    // TODO: implement getCachedNowAiringTvShows
    throw UnimplementedError();
  }

  @override
  Future<TvShowTable?> getTvShowById(int id) {
    // TODO: implement getTvShowById
    throw UnimplementedError();
  }

  @override
  Future<List<TvShowTable>> getWatchlistTvShows() {
    // TODO: implement getWatchlistTvShows
    throw UnimplementedError();
  }

  @override
  Future<String> insertWatchlist(TvShowTable tvShow) {
    // TODO: implement insertWatchlist
    throw UnimplementedError();
  }

  @override
  Future<String> removeWatchlist(TvShowTable tvShow) {
    // TODO: implement removeWatchlist
    throw UnimplementedError();
  }
}

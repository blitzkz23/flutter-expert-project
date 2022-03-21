import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class TvShowRepositoryImpl implements TvShowRepository {
  @override
  Future<Either<Failure, List<TvShow>>> getNowAiringTvShows() {
    // TODO: implement getOnTheAirTvShows
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TvShow>>> getPopularTvShows() {
    // TODO: implement getPopularTvShows
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TvShow>>> getTopRatedTvShows() {
    // TODO: implement getTopRatedTvShows
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TvShowDetail>> getTvShowDetail(int id) {
    // TODO: implement getTvShowDetail
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TvShow>>> getTvShowRecommendations(int id) {
    // TODO: implement getTvShowRecommendations
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TvShow>>> getWatchlistTvShows() {
    // TODO: implement getWatchlistTvShows
    throw UnimplementedError();
  }

  @override
  Future<bool> isAddedToWatchlist(int id) {
    // TODO: implement isAddedToWatchlist
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(TvShowDetail tvShow) {
    // TODO: implement removeWatchlist
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(TvShowDetail tvShow) {
    // TODO: implement saveWatchlist
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TvShow>>> searchTvShows(String query) {
    // TODO: implement searchTvShows
    throw UnimplementedError();
  }
}

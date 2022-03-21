import 'package:ditonton/data/models/tv_show_model.dart';
import 'package:http/http.dart' as http;

abstract class TvShowRemoteDataSource {
  Future<List<TvShowModel>> getNowAiringTvShows();
  Future<List<TvShowModel>> getPopularTvShows();
  Future<List<TvShowModel>> getTopRatedTvShows();
  Future<TvShowModel> getTvShowDetail(int id);
  Future<List<TvShowModel>> getTvShowRecommendations(int id);
  Future<List<TvShowModel>> searchTvShows(String query);
}

class TvShowRemoteDataSourceImpl implements TvShowRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TvShowRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvShowModel>> getNowAiringTvShows() {
    // TODO: implement getNowAiringTvShows
    throw UnimplementedError();
  }

  @override
  Future<List<TvShowModel>> getPopularTvShows() {
    // TODO: implement getPopularTvShows
    throw UnimplementedError();
  }

  @override
  Future<List<TvShowModel>> getTopRatedTvShows() {
    // TODO: implement getTopRatedTvShows
    throw UnimplementedError();
  }

  @override
  Future<TvShowModel> getTvShowDetail(int id) {
    // TODO: implement getTvShowDetail
    throw UnimplementedError();
  }

  @override
  Future<List<TvShowModel>> getTvShowRecommendations(int id) {
    // TODO: implement getTvShowRecommendations
    throw UnimplementedError();
  }

  @override
  Future<List<TvShowModel>> searchTvShows(String query) {
    // TODO: implement searchTvShows
    throw UnimplementedError();
  }
}

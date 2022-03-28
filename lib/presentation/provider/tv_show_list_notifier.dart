import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_now_airing_tv_shows.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_shows.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_shows.dart';
import 'package:flutter/cupertino.dart';

class TvShowListNotifier extends ChangeNotifier {
  var _nowAiringTvShows = <TvShow>[];
  List<TvShow> get nowAiringTvShows => _nowAiringTvShows;

  RequestState _nowAiringState = RequestState.Empty;
  RequestState get nowAiringState => _nowAiringState;

  var _popularTvShows = <TvShow>[];
  List<TvShow> get popularTvShows => _popularTvShows;

  RequestState _popularState = RequestState.Empty;
  RequestState get popularState => _popularState;

  var _topRatedTvShows = <TvShow>[];
  List<TvShow> get topRatedTvShows => _topRatedTvShows;

  RequestState _topRatedState = RequestState.Empty;
  RequestState get topRatedState => _topRatedState;

  String _message = '';
  String get message => _message;

  TvShowListNotifier({
    required this.getNowAiringTvShows,
    required this.getPopularTvShows,
    required this.getTopRatedTvShows,
  });

  final GetNowAiringTvShows getNowAiringTvShows;
  final GetPopularTvShows getPopularTvShows;
  final GetTopRatedTvShows getTopRatedTvShows;

  Future<void> fetchNowAiringTvShows() async {
    _nowAiringState = RequestState.Loading;
    notifyListeners();

    final result = await getNowAiringTvShows.execute();
    result.fold(
      (failure) {
        _nowAiringState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _nowAiringState = RequestState.Loaded;
        _nowAiringTvShows = tvShowsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvShows() async {
    _popularState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvShows.execute();
    result.fold(
      (failure) {
        _popularState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _popularState = RequestState.Loaded;
        _popularTvShows = tvShowsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvShows() async {
    _topRatedState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvShows.execute();
    result.fold(
      (failure) {
        _topRatedState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _topRatedState = RequestState.Loaded;
        _topRatedTvShows = tvShowsData;
        notifyListeners();
      },
    );
  }
}

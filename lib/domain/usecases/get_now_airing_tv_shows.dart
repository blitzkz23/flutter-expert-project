import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_show.dart';

import '../../common/failure.dart';
import '../repositories/tv_show_repository.dart';

class GetNowAiringTvShows {
  final TvShowRepository repository;

  GetNowAiringTvShows(this.repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getNowAiringTvShows();
  }
}

import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:equatable/equatable.dart';

class TvShowTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  TvShowTable(
      {required this.id,
      required this.name,
      required this.posterPath,
      required this.overview});

  factory TvShowTable.fromEntity(TvShowDetail tvShow) => TvShowTable(
        id: tvShow.id,
        name: tvShow.name,
        posterPath: tvShow.posterPath,
        overview: tvShow.overview,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, posterPath, overview];
}

import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:equatable/equatable.dart';

class TvShowTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;

  TvShowTable(
      {required this.id,
      required this.title,
      required this.posterPath,
      required this.overview});

  factory TvShowTable.fromEntity(TvShowDetail tvShow) => TvShowTable(
        id: tvShow.id,
        title: tvShow.name,
        posterPath: tvShow.posterPath,
        overview: tvShow.overview,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, posterPath, overview];
}

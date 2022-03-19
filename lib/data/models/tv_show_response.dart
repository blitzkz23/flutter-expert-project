import 'package:ditonton/data/models/tv_show_model.dart';

class TvShowResponse {
  TvShowResponse({required this.tvShowList});

  List<TvShowModel> tvShowList;

  factory TvShowResponse.fromJson(Map<String, dynamic> json) => TvShowResponse(
        tvShowList: List<TvShowModel>.from(
            json["results"].map((x) => TvShowModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(tvShowList.map((x) => x.toJson())),
      };
}

import 'package:flutter/material.dart';

class TvShowDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-show-detail';
  final int id;

  const TvShowDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<TvShowDetailPage> createState() => _TvShowDetailPageState();
}

class _TvShowDetailPageState extends State<TvShowDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

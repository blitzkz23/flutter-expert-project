import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_tv_shows_page.dart';
import 'package:flutter/material.dart';

class WatchlistMainPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  const WatchlistMainPage({Key? key}) : super(key: key);

  @override
  State<WatchlistMainPage> createState() => _WatchlistMainPageState();
}

class _WatchlistMainPageState extends State<WatchlistMainPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: Icon(Icons.movie),
            ),
            Tab(
              icon: Icon(Icons.tv),
            ),
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        WatchlistMoviesPage(),
        WatchlistTvShowsPage(),
      ]),
    );
  }
}

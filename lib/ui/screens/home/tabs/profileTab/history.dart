import 'package:flutter/material.dart';
import 'package:movies/API/profile/history_service.dart';
import 'package:movies/Model/movie.dart';
import 'package:movies/core/assets/app_assets.dart';
import 'package:movies/core/theme/app_colors.dart';
import 'package:movies/ui/shared_widgets/movie_design.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryTab extends StatefulWidget {
  @override
  _HistoryTabState createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  List<Movie> historyMovies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("user_id");

    if (userId != null) {
      List<Movie> history = await HistoryService.getHistoryMovies(userId);
      setState(() {
        historyMovies = history;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : historyMovies.isEmpty
        ? Center(
      child: Image.asset(
        AppAssets.movieHistory,
        color: AppColors.white,
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.13,
      ),
    )
        : Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: historyMovies.length,
        itemBuilder: (context, index) {
          return MovieDesign(movie: historyMovies[index]);
        },
      ),
    );
  }
}

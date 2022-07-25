import 'package:flutter/material.dart';

import 'package:game_lib_app/results_grid/results_grid.dart';

class GenresGridPage extends StatefulWidget {
  const GenresGridPage({Key? key, required this.whereFilters})
      : super(key: key);
  final String whereFilters;
  @override
  State<GenresGridPage> createState() => _GenresGridPageState();
}

class _GenresGridPageState extends State<GenresGridPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(), body: ResultsGrid(whereFilters: widget.whereFilters));
  }
}

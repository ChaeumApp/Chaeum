import 'package:fe/repeat/search.dart';
import 'package:flutter/material.dart';

class SearchMain extends StatefulWidget {
  const SearchMain({super.key});

  @override
  State<SearchMain> createState() => _SearchMainState();
}

class _SearchMainState extends State<SearchMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Search(),
        ],
      ),
    );
  }
}

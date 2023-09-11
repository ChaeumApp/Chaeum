import 'package:flutter/material.dart';
import './pricechart.dart';

class PriceInfo extends StatelessWidget {
  const PriceInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PriceChart(),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class BagPage extends StatelessWidget {
  const BagPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Bag Page',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
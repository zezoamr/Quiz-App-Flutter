import 'package:flutter/material.dart';

import '../shared/bottom_nav.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavbar(),
      body: Center(
        child: ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/topics'),
            child: const Text('topics')),
      ),
    );
  }
}

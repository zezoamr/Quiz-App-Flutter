import 'package:flutter/material.dart';
import 'package:quizapp/services/firestore.dart';

import '../shared/bottom_nav.dart';
import '../shared/error.dart';
import '../shared/loading.dart';
import './topic_item.dart';
import './drawer.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirestoreService().getTopics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Center(
              child: ErrorMessage(
            message: snapshot.error.toString(),
          ));
        } else if (snapshot.hasData) {
          var topics = snapshot.data!;

          return Scaffold(
            drawer: TopicsDrawer(topics: topics),
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              title: const Text('Topics'),
            ),
            bottomNavigationBar: const BottomNavbar(),
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: List<Widget>.from(
                  topics.map((topic) => TopicItem(topic: topic))),
            ),
          );
        } else {
          return const Text('no Topics Found, please contact the developer');
        }
      },
    );
  }
}

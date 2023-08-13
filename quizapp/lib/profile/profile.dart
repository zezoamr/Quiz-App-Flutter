import 'package:flutter/material.dart';
import 'package:quizapp/services/auth.dart';
import 'package:provider/provider.dart';
import '../services/models.dart';
import '../shared/loading.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var report = Provider.of<Report>(context);
    var user = AuthService().user;

    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('ProfileScreen'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(user.photoURL ??
                        'https://www.gravatar.com/avatar/placeholder'),
                  ),
                ),
              ),
              Text(user.email ?? 'anonymous login',
                  style: Theme.of(context).textTheme.titleLarge),
              const Spacer(),
              Text('${report.total}',
                  style: Theme.of(context).textTheme.displayMedium),
              Text('Quizzes Completed',
                  style: Theme.of(context).textTheme.titleSmall),
              const Spacer(),
              ElevatedButton(
                child: const Text('SignOut'),
                onPressed: () async {
                  await AuthService().signOut();
                  if (!context.mounted) return;
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                },
              ),
            ],
          ),
        ),
      );
    } else {
      return const Loader();
    }
  }
}

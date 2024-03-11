import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../application/providers/providers.dart';

class GoogleSignInComponent extends ConsumerWidget {
  const GoogleSignInComponent({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final notifier = ref.watch(userSignInProvider.notifier);
    final state = ref.read(userSignInProvider);

    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Divider(
            thickness: 2.0,
            color: Colors.black,
            height: 2.0,
          ),
          GestureDetector(
            onTap: () async {
              await notifier.signInWithGoogle(context: context);
              final user = state.user;

              final prefs = ref.read(preferencesProvider);
              prefs.whenData(
                  (pref) async => await pref.setUserData(user!.toJson()));

              ref.read(routerProvider).router.pop();
              ref.read(routerProvider).router.refresh();
            },
            child: Image.asset(
              'assets/app_icons/google_logo.png',
              width: 50,
              height: 50,
            ),
          ),
          const Divider(
            thickness: 2.0,
            color: Colors.black,
            height: 2.0,
          ),
        ],
      ),
    );
  }
}

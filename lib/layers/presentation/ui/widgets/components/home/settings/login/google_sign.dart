import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_pasantia/layers/aplication/providers/providers.dart';

import '../../../../../../../domain/entities/user/users.dart';

class GoogleSignInComponent extends ConsumerWidget {
  const GoogleSignInComponent({super.key});

  @override
  Widget build(BuildContext context, ref) {
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
              ref
                  .read(userSignInProvider.notifier)
                  .signInWithGoogle(context: context);
              final user = ref.read(preferencesProvider).user;
              ref
                  .read(preferencesProvider.notifier)
                  .setUserData(user!.toJson());
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

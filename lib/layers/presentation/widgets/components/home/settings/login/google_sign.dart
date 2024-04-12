import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../application/providers/providers.dart';

class GoogleSignInComponent extends ConsumerWidget {
  const GoogleSignInComponent({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final notifier = ref.watch(userSignInProvider.notifier);

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
              final user = await notifier.signInWithGoogle(context: context);

              final prefs = await ref.read(preferencesProvider);
              prefs.setUserData(user.toJson());
              prefs.setUserId(user.id);

              ref.read(routerProvider).router.pop();
            },
            child: Image.network(
              'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fapp_icons%2Fgoogle_logo.png?alt=media&token=c5d2022b-8d37-4adf-af6a-7ff27d27915d',
              width: 50,
              height: 50,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
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

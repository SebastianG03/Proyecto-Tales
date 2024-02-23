import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/components/forms/sign_in_form.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/components/settings/settings_components.dart';

import '../../../../aplication/providers/providers.dart';

class SignInView extends ConsumerStatefulWidget {
  const SignInView({super.key});

  @override
  SignInViewState createState() => SignInViewState();
}

class SignInViewState extends ConsumerState<SignInView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    ref.read(usernameProvider.notifier).dispose();
    ref.read(ageProvider.notifier).dispose();
    ref.read(emailProvider.notifier).dispose();
    ref.read(passwordProvider.notifier).dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.read(routerProvider);
    final signNotifier = ref.read(userSignInProvider.notifier);

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - 30,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SignInForm(),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                    onPressed: () async {
                      final user =
                          await signNotifier.signInWithEmailAndPassword(
                              context: context,
                              email: ref.read(emailProvider.notifier).state,
                              password:
                                  ref.read(passwordProvider.notifier).state);
                      ref
                          .read(preferencesProvider.notifier)
                          .setUserData(user.toJson());
                      router.router.pop();
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const GoogleSignInComponent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

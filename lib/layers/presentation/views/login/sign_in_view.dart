import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/providers/providers.dart';
import '../../widgets/components/forms/sign_in_form.dart';
import '../../widgets/components/home/settings/settings_components.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.read(routerProvider);
    final loginForm = ref.watch(loginFormProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
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
                    onPressed: loginForm.isPosting
                        ? null
                        : () async {
                            if (context.mounted) {
                              ref
                                  .read(loginFormProvider.notifier)
                                  .onSubmit(context);
                            }
                            router.router.pop();
                          },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                      child: Text(
                        "Iniciar sesión",
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

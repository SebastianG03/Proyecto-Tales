import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../application/providers/providers.dart';
import '../../widgets/components/forms/register_form.dart';
import '../../widgets/components/home/settings/settings_components.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends ConsumerState<RegisterView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signInNotifier = ref.read(userSignInProvider.notifier);
    final loginForm = ref.watch(loginFormProvider);
    final router = ref.read(routerProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - 50,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const UserRegisterForm(),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                    onPressed: (loginForm.isPosting)
                        ? null
                        : () async {
                            ref.read(registerFormProvider.notifier).onSubmit();
                            signInNotifier.signInWithEmailAndPassword(
                                context: context,
                                email: loginForm.email.value,
                                password: loginForm.password.value);
                            final user = ref.read(userSignInProvider).user!;
                            final prefs = await ref.read(preferencesProvider);
                            prefs.setUserData(user.toJson());
                            prefs.setUserId(user.id);
                            router.router.pop();
                          },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                      child: Text(
                        "Sign Up",
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

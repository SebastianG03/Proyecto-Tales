import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/components/forms/register_form.dart';

import '../../../../aplication/providers/providers.dart';
import '../../widgets/components/settings/settings_components.dart';

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
    ref.read(usernameProvider.notifier).dispose();
    ref.read(ageProvider.notifier).dispose();
    ref.read(emailProvider.notifier).dispose();
    ref.read(passwordProvider.notifier).dispose();
  }

  @override
  Widget build(BuildContext context) {
    final register = ref.read(userDatasourceProvider);
    final signInNotifier = ref.read(userSignInProvider.notifier);
    final router = ref.read(routerProvider);

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - 50,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                const UserRegisterForm(),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final name = ref.read(usernameProvider.notifier).state;
                        final age = ref.read(ageProvider.notifier).state;
                        final email = ref.read(emailProvider.notifier).state;
                        final password =
                            ref.read(passwordProvider.notifier).state;
                        debugPrint('''
                          Username: $name
                          Age: $age
                          Email: $email
                          Password: $password        
                          ''');
                        register.createUserWithEmailAndPassword(
                          ref.read(usernameProvider.notifier).state,
                          ref.read(ageProvider.notifier).state,
                          ref.read(emailProvider.notifier).state,
                          ref.read(passwordProvider.notifier).state,
                        );
                        // final user =
                        //     await signInNotifier.signInWithEmailAndPassword(
                        //         context: context,
                        //         email: data['email'],
                        //         password: data['password']);
                        // ref
                        //     .read(preferencesProvider.notifier)
                        //     .setUserData(user.toJson());
                        // router.router.pop();
                      }
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

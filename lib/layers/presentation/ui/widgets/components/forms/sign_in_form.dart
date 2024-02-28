import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:proyecto_pasantia/layers/aplication/providers/providers.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/components/settings/settings_components.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/custom/inputs/inputs.dart';

class SignInForm extends ConsumerStatefulWidget {
  const SignInForm({super.key});

  @override
  SignInFormState createState() => SignInFormState();
}

class SignInFormState extends ConsumerState<SignInForm> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final loginForm = ref.watch(loginFormProvider);
    return Column(
      children: <Widget>[
        TextFormsModel(
          textInputType: TextInputType.emailAddress,
          labelText: "Email",
          icon: LineIcons.at,
          errorMessage:
              (loginForm.isFormPosted) ? loginForm.email.errorMessage : null,
          onChanged: (value) {
            ref.read(loginFormProvider.notifier).emailChanged(value.trim());
          },
        ),
        const SizedBox(height: 10),
        PasswordFormsModel(
          textInputType: TextInputType.visiblePassword,
          label: "Contraseña",
          onChanged: (value) {
            ref.read(loginFormProvider.notifier).passwordChanged(value.trim());
          },
          erroMessage:
              (loginForm.isFormPosted) ? loginForm.password.errorMessage : null,
          obscureText: obscurePassword,
          tap: _obscurePassword,
        ),
        TextButton(
          child: Text(
            'Me olvidé la contraseña',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.blue.shade300,
              fontStyle: FontStyle.italic,
              decoration: TextDecoration.underline,
            ),
          ),
          onPressed: () {
            ForgotPasswordAlert.showAlertDialog(
              context,
              'Reestablezca su contraseña',
              (email) {
                ref.read(userDatasourceProvider).sendPasswordResetEmail(email);
                ref.read(routerProvider).router.pop();
              },
            );
          },
        ),
      ],
    );
  }

  void _obscurePassword() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }
}

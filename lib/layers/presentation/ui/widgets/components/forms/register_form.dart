import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:proyecto_pasantia/layers/aplication/providers/providers.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/custom/inputs/inputs.dart';

class UserRegisterForm extends ConsumerStatefulWidget {
  const UserRegisterForm({super.key});

  @override
  UserRegisterFormState createState() => UserRegisterFormState();
}

class UserRegisterFormState extends ConsumerState<UserRegisterForm> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final registerForm = ref.watch(registerFormProvider);
    return Column(
      children: <Widget>[
        TextFormsModel(
          textInputType: TextInputType.name,
          labelText: "Nombre de usuario",
          icon: LineIcons.user,
          validator: (value) => registerForm.username.errorMessage,
          onChanged: (value) {
            ref
                .read(registerFormProvider.notifier)
                .usernameChanged(value.trim());
          },
        ),
        const SizedBox(height: 10.0),
        TextFormsModel(
          textInputType: TextInputType.number,
          labelText: "Edad",
          icon: LineIcons.calendar,
          validator: (value) => registerForm.age.errorMassage,
          onChanged: (value) {
            ref.read(registerFormProvider.notifier).ageChanged(value.trim());
          },
        ),
        const SizedBox(height: 10.0),
        TextFormsModel(
          textInputType: TextInputType.emailAddress,
          labelText: "Email",
          icon: LineIcons.at,
          validator: (value) => registerForm.email.errorMessage,
          onChanged: (value) {
            ref.read(registerFormProvider.notifier).emailChanged(value.trim());
          },
        ),
        const SizedBox(height: 10.0),
        PasswordFormsModel(
          textInputType: TextInputType.visiblePassword,
          label: "Contraseña",
          onChanged: (value) {
            ref
                .read(registerFormProvider.notifier)
                .passwordChanged(value.trim());
          },
          validator: (value) => registerForm.password.errorMessage,
          obscureText: obscurePassword,
          tap: _obscurePassword,
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }

  void _obscurePassword() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }
}

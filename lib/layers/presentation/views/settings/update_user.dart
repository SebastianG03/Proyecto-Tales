import 'package:cuentos_pasantia/layers/domain/entities/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/providers/providers.dart';
import '../../widgets/components/forms/register_form.dart';
import '../../widgets/custom/custom_components.dart';

class UpdateUserView extends ConsumerStatefulWidget {
  final UserModel user;
  const UpdateUserView({super.key, required this.user});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateUserViewState();
}

class _UpdateUserViewState extends ConsumerState<UpdateUserView> {
  bool isReadOnly = true;
  String buttonText = "Editar";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  const Text('Información del usuario',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 20,
                  ),
                  UserRegisterForm(
                    updateUser: true,
                    isReadOnly: isReadOnly,
                    user: widget.user,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextButton(
                    onPressed: () =>
                        isReadOnly ? null : updatePassword(widget.user.email),
                    label: 'Actualizar Contraseña',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextButton(
                    onPressed: () => editForm(),
                    label: buttonText,
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void editForm() {
    setState(() {
      isReadOnly = !isReadOnly;
      buttonText = isReadOnly ? "Editar" : "Guardar Cambios";
    });
    if (!isReadOnly) {
      _updateUser();
    }
  }

  void updatePassword(String email) {
    final auth = ref.read(authRepositoryProvider);
    auth.sendEmailToChangePassword(email);
    CustomAlertDialog.showAlertDialog(
        context,
        'Reestablecimiento de contraseña',
        'Un correo para reestablecer su contraseña ha sido enviado a $email.',
        () {},
        () {});
  }

  void _updateUser() async {
    final repo = ref.read(authRepositoryProvider);
    final data = ref.read(registerFormProvider);

    final user = UserModel(
      id: widget.user.id,
      name: data.username.value,
      email: data.email.value,
      age: int.parse(data.age.value),
      suscription: widget.user.suscription,
    );

    final response = repo.updateUser(user);
    CustomAlertDialog.showAlertDialog(
        context, "Su información fue modificada", response, () {}, () {});
  }
}

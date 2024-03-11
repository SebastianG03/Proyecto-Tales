import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/providers/providers.dart';
import '../../../domain/entities/user/users.dart';
import '../../widgets/components/forms/register_form.dart';

class UpdateUserView extends ConsumerStatefulWidget {
  const UpdateUserView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdateUserViewState();
}

class _UpdateUserViewState extends ConsumerState<UpdateUserView> {
  bool isReadOnly = true;
  String buttonText = "Editar";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final prefs = ref.read(preferencesProvider);
    late UserModel user;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - 50,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: prefs.when(
            data: (pref) {
              user = pref.getUserData()!;
              return Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text('Información del usuario'),
                    const SizedBox(
                      height: 20,
                    ),
                    UserRegisterForm(
                      updateUser: true,
                      isReadOnly: isReadOnly,
                      user: user,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ElevatedButton(
                        onPressed: () => editForm,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10.0),
                          child: Text(
                            buttonText,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            error: (error, stack) {
              return Center(
                child: Text(
                  'Error: $error',
                  style: const TextStyle(fontSize: 20),
                ),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  void editForm() {
    setState(() {
      isReadOnly = !isReadOnly;
      buttonText = isReadOnly ? "Editar" : "Guardar Cambios";
    });
  }
}

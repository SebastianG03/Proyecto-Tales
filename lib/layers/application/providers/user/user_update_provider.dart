import 'package:cuentos_pasantia/layers/application/providers/providers.dart';
import 'package:cuentos_pasantia/layers/domain/entities/user/user.dart';
import 'package:cuentos_pasantia/layers/presentation/widgets/custom/custom_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userUpdateDataProvider =
    Provider.family<void, BuildContext>((ref, context) async {
  final data = ref.watch(registerFormProvider);
  final repository = ref.watch(authRepositoryProvider);
  final emailChangeResponse = repository.changeEmail(data.email.value);

  if (emailChangeResponse.isNotEmpty) {
    CustomSnackbar.showSnackBar(context, emailChangeResponse);
  }

  final response = await repository.updateUser(UserModel(
    id: repository.getActualUserId(),
    name: data.username.value,
    email: data.email.value,
    age: int.tryParse(data.age.value),
  ));

  debugPrint('User update response: $response');
});

import 'package:flutter/material.dart';
import 'package:proyecto_pasantia/layers/domain/entities/user/user.dart';

class UserCard extends StatelessWidget {
  final UserModel? user;
  const UserCard({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    String name = (user != null) ? user!.name : 'Guest';
    String suscriptionStatus =
        (user != null && user!.suscription) ? 'Premium' : 'Gratis';
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Card(
        margin: const EdgeInsets.all(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              Text(name, style: const TextStyle(fontSize: 18)),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: Text(
                  suscriptionStatus,
                  style: const TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

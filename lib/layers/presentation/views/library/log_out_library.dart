import 'package:flutter/material.dart';

class LogOutLibrary extends StatelessWidget {
  const LogOutLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20)),
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Mis cuentos',
                style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Inicie sesión para acceder a su biblioteca o cree una cuenta para empezar su colección.",
            maxLines: 3,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: 250,
            child: Image.network(
              "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fapp_icons%2Flibrary_img1.png?alt=media&token=c0f82980-e0a8-443f-8813-dce9ab5c9944",
              fit: BoxFit.cover,
              width: 250,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}

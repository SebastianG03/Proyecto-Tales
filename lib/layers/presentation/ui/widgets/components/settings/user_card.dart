import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Card(
        margin: EdgeInsets.all(12),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.green,
                child: Text('G', style: TextStyle(fontSize: 25)),
              ),
              SizedBox(
                width: 30,
              ),
              Text('Guest', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}

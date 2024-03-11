import 'package:flutter/material.dart';

class LibraryTale extends StatelessWidget {
  final String urlImage;
  final String title;
  final String chapter;
  final int lastRead;
  const LibraryTale(
      {super.key,
      required this.title,
      required this.chapter,
      required this.lastRead, required this.urlImage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 15),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: AssetImage(urlImage),
                  fit: BoxFit.cover,
                  height: 80,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(chapter,
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('Leído hace $lastRead dias',
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade600))
                ],
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.delete_outline))
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../../../domain/entities/tales/tales_exports.dart';

class DetailsGenders extends StatelessWidget {
  final List<Gender> taleGenders;
  const DetailsGenders({super.key, required this.taleGenders});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      verticalDirection: VerticalDirection.down,
      runAlignment: WrapAlignment.start,
      direction: Axis.horizontal,
      children: [
        ...taleGenders.map(
          (gender) => Container(
            margin: const EdgeInsets.only(right: 10),
            child: Chip(
              label: Text(GenderTalesHelper.getGenderName(gender)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

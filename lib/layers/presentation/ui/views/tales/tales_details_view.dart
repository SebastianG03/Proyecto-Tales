import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/tales/tales_exports.dart';

class TaleDetailsView extends ConsumerWidget {
  final String taleId;
  const TaleDetailsView({super.key, required this.taleId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String imageUrl = 'assets/tales_sample/portada1.jpg';
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        _CustomSliverAppBar(
            imageUrl: imageUrl, title: 'Blanca nieves y los 7 enanitos'),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) => const _TaleDescription(
              abstract:
                  '''Aliqua do exercitation in eiusmod officia proident. Fugiat proident consequat culpa nulla proident excepteur
                   cillum sint exercitation labore reprehenderit minim quis ullamco. Esse veniam ipsum ad et tempor elit in aliqua
                    eiusmod proident exercitation amet duis. In occaecat aliquip do mollit ad commodo ullamco ipsum.
                    Aliqua do exercitation in eiusmod officia proident. Fugiat proident consequat culpa nulla proident excepteur
                   cillum sint exercitation labore reprehenderit minim quis ullamco. Esse veniam ipsum ad et tempor elit in aliqua
                    eiusmod proident exercitation amet duis. In occaecat aliquip do mollit ad commodo ullamco ipsum.
                    Aliqua do exercitation in eiusmod officia proident. Fugiat proident consequat culpa nulla proident excepteur
                   cillum sint exercitation labore reprehenderit minim quis ullamco. Esse veniam ipsum ad et tempor elit in aliqua
                    eiusmod proident exercitation amet duis. In occaecat aliquip do mollit ad commodo ullamco ipsum.''',
              taleGenders: [
                Gender.Aventura,
                Gender.Fantasia,
                Gender.Romance,
                Gender.Humor
              ]),
        ))
      ],
    );
  }
}

class _TaleDescription extends StatelessWidget {
  final List<Gender> taleGenders;
  final String abstract;
  const _TaleDescription({required this.abstract, required this.taleGenders});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Resumen",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        // _ExpandedText(text: abstract),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Géneros',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Wrap(
          alignment: WrapAlignment.start,
          verticalDirection: VerticalDirection.down,
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
            PlatformTextButton(
              onPressed: () {},
              color: Colors.blue,
              child: const Text('Leer'),
            ),
          ],
        ),
      ],
    );
  }
}

class _ExpandedText extends StatefulWidget {
  final String text;
  const _ExpandedText({required this.text});

  @override
  State<_ExpandedText> createState() => __ExpandedTextState();
}

class __ExpandedTextState extends State<_ExpandedText> {
  bool isExpanded = false;
  IconData icon = Icons.keyboard_arrow_down_outlined;
  late String firstHalf;
  late String secondHalf;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > 100) {
      firstHalf = widget.text.substring(0, 100);
      secondHalf = widget.text.substring(100, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade300,
      child: (secondHalf == "")
          ? Text(
              firstHalf,
            )
          : GestureDetector(
              onTap: () => _toggleExpanded(),
              child: Column(
                children: [
                  Text((!isExpanded) ? ("$firstHalf...") : (widget.text)),
                  const Spacer(),
                  Row(
                    children: [
                      const Spacer(),
                      Icon(icon),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  void _toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
      icon = isExpanded
          ? Icons.keyboard_arrow_up_outlined
          : Icons.keyboard_arrow_down_outlined;
    });
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final String imageUrl;
  final String title;
  const _CustomSliverAppBar({required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.5,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          title,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.centerRight,
                          stops: [
                    0.0,
                    0.5
                  ],
                          colors: [
                    Colors.black87,
                    Colors.transparent,
                  ]))),
            )
          ],
        ),
      ),
    );
  }
}

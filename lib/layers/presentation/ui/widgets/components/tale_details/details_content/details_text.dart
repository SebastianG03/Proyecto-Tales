import 'package:flutter/material.dart';

class DetailsText extends StatefulWidget {
  final String text;
  const DetailsText({super.key, required this.text});

  @override
  State<DetailsText> createState() => _DetailsTextState();
}

class _DetailsTextState extends State<DetailsText> {
  bool isExpanded = false;
  IconData icon = Icons.keyboard_arrow_down_outlined;
  late String firstHalf;
  late String secondHalf;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > 150) {
      firstHalf = widget.text.substring(0, 150);
      secondHalf = widget.text.substring(100, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 14,
      letterSpacing: 0.5,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: (secondHalf == "")
              ? Text(
                  firstHalf,
                  style: textStyle,
                  softWrap: true,
                  textAlign: TextAlign.justify,
                )
              : GestureDetector(
                  onTap: () => _toggleExpanded(),
                  child: Column(
                    children: [
                      Text(
                        (!isExpanded) ? ("$firstHalf...") : (widget.text),
                        style: textStyle,
                        softWrap: true,
                        textAlign: TextAlign.justify,
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          Icon(
                            icon,
                            size: 28,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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

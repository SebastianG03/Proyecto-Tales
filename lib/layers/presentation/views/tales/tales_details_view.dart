import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/tales/tales_exports.dart';
import '../../widgets/components/tale_details/tales_description.dart';
import '../../widgets/components/tale_details/tales_details.dart';

class TaleDetailsView extends ConsumerStatefulWidget {
  final String imageUrl;
  final String title;
  final String abstract;
  final List<Gender> tags;
  final String taleId;
  const TaleDetailsView({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.abstract,
    required this.tags,
    required this.taleId,
  });

  @override
  ConsumerState<TaleDetailsView> createState() => _TaleDetailsViewState();
}

class _TaleDetailsViewState extends ConsumerState<TaleDetailsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        CoverDetails(imageUrl: widget.imageUrl, title: widget.title),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          childCount: 1,
          (context, index) => TaleDescription(
            abstract: widget.abstract,
            taleGenders: widget.tags,
          ),
        ))
      ],
    );
  }
}

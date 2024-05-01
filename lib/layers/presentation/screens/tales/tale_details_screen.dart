import 'package:cuentos_pasantia/layers/presentation/widgets/components/tale_details/details_content/details_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/providers/providers.dart';
import '../../views/views.dart';

class TaleDetailsScreen extends ConsumerStatefulWidget {
  final String taleId;
  const TaleDetailsScreen({super.key, required this.taleId});

  @override
  ConsumerState<TaleDetailsScreen> createState() => _TaleDetailsScreenState();
}

class _TaleDetailsScreenState extends ConsumerState<TaleDetailsScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taleAsync = ref.watch(taleContentProvider(widget.taleId));

    return SafeArea(
      child: taleAsync.when(
        data: (tale) {
          final auth = ref.read(authRepositoryProvider);
          final uid = auth.getActualUserId();
          final bool isFollowing =
              ref.read(userTaleIsFollowing(uid)).asData?.value ?? false;
          return Scaffold(
            // resizeToAvoidBottomInset: false,
            body: TaleDetailsView(
              imageUrl: tale.getCoverUrl,
              title: '${tale.title} (${tale.ageLimit}+)',
              abstract: tale.abstract,
              tags: tale.genders,
              taleId: tale.id,
            ),
            floatingActionButtonLocation: ExpandableFab.location,
            floatingActionButton: FBDetailsActions(
              taleId: tale.id,
              taleTitle: tale.title,
              coverUrl: tale.getCoverUrl,
              isFollowing: isFollowing,
            ),
          );
        },
        error: (_, __) {
          return const Center(
            child: Text('Error al cargar la historia'),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

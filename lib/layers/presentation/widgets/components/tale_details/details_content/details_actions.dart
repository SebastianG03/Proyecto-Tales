// ignore_for_file: must_be_immutable

import 'package:cuentos_pasantia/layers/application/providers/providers.dart';
import 'package:cuentos_pasantia/layers/domain/entities/user/user_tales_status.dart';
import 'package:cuentos_pasantia/layers/presentation/widgets/custom/custom_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../../../config/router/app_routes.dart';

class DetailsActions extends ConsumerStatefulWidget {
  final String taleId;
  final String taleTitle;
  final String coverUrl;
  bool isFollowing;

  DetailsActions({
    super.key,
    required this.taleId,
    required this.taleTitle,
    required this.coverUrl,
    required this.isFollowing,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FloatingButtonDetailsActionsState();
}

class _FloatingButtonDetailsActionsState extends ConsumerState<DetailsActions> {
  final _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      key: _key,
      distance: MediaQuery.of(context).size.height * 0.08,
      type: ExpandableFabType.up,
      openButtonBuilder: RotateFloatingActionButtonBuilder(
        child: const Icon(Icons.add),
        fabSize: ExpandableFabSize.regular,
        heroTag: 'openButton',
        shape: const CircleBorder(),
      ),
      closeButtonBuilder: DefaultFloatingActionButtonBuilder(
        heroTag: 'closeButton',
        child: const Icon(Icons.close),
        fabSize: ExpandableFabSize.regular,
        shape: const CircleBorder(),
      ),
      children: [
        FloatingActionButton.extended(
          heroTag: 'playButton',
          label: const Text('Iniciar'),
          icon: const Icon(
            LineIcons.play,
            size: 30,
          ),
          onPressed: () => _onPressedPlay(
              widget.taleId, widget.coverUrl, widget.taleTitle, ref),
        ),
        FloatingActionButton.extended(
          heroTag: 'restartButton',
          label: const Text('Reiniciar'),
          icon: const Icon(
            LineIcons.backward,
            size: 30,
          ),
          onPressed: () => _onPressedPlay(
              widget.taleId, widget.coverUrl, widget.taleTitle, ref),
        ),
        FloatingActionButton.extended(
          heroTag: 'followButton',
          label: const Text('Seguir'),
          icon: !widget.isFollowing
              ? const Icon(
                  Icons.favorite_outline_rounded,
                  size: 30,
                )
              : const Icon(
                  Icons.favorite,
                  size: 30,
                ),
          onPressed: () => _onPressedFollow(
              ref, widget.coverUrl, widget.taleTitle, widget.taleId),
        )
      ],
    );
  }

  void _onPressedPlay(
      String taleId, String imageUrl, String title, WidgetRef ref) async {
    final userId = ref.read(authRepositoryProvider).getActualUserId();

    if (!isUserSigned(userId)) return;
    debugPrint(taleId);
    final userTalesController = ref.read(libraryManagementProvider.notifier);
    final exists = await userTalesController.userTaleExists(userId, taleId);

    // List<UserTalesStatus> progress = [UserTalesStatus.reading];
    UserTalesStatus progress = UserTalesStatus.reading;

    String actualSection = "";
    int actualChapter = 0;

    if (!exists) {
      userTalesController.updateTale(
        userId: userId,
        taleId: taleId,
        taleTitle: title,
        coverUrl: imageUrl,
        progress: progress,
        lastChapterReaded: actualChapter,
        lastSectionReaded: actualSection,
      );

      debugPrint('not exists');
    } else {
      final usertale = await userTalesController.getTale(userId, taleId);
      actualSection = usertale.getLastSectionReaded;
      actualChapter = usertale.getLastChapterReaded;
    }

    final sectionDataNotifier = ref.read(sectionDataProvider.notifier);
    await sectionDataNotifier.initData(taleId, actualChapter);
    ref.read(selectedOptionProvider.notifier).update((state) => actualSection);

    ref.read(favoriteUsertalesProvider.notifier).loadUserTales(userId);

    ref.read(routerProvider).router.goNamed(AppRoutes.readerView,
        pathParameters: {
          'taleId': ref.read(actualTaleProvider.notifier).state
        });
  }

  void _onPressedRestart(
      String taleId, String imageUrl, String title, WidgetRef ref) async {
    final userId = ref.read(authRepositoryProvider).getActualUserId();

    if (!isUserSigned(userId)) return;
    debugPrint(taleId);
    final userTalesController = ref.read(libraryManagementProvider.notifier);

    // List<UserTalesStatus> progress = [UserTalesStatus.reading];
    UserTalesStatus progress = UserTalesStatus.reading;

    String actualSection = "";
    int actualChapter = 0;

    userTalesController.updateTale(
      userId: userId,
      taleId: taleId,
      taleTitle: title,
      coverUrl: imageUrl,
      progress: progress,
      lastChapterReaded: actualChapter,
      lastSectionReaded: actualSection,
    );

    final sectionDataNotifier = ref.read(sectionDataProvider.notifier);
    await sectionDataNotifier.initData(taleId, actualChapter);
    ref.read(selectedOptionProvider.notifier).update((state) => actualSection);

    ref.read(favoriteUsertalesProvider.notifier).loadUserTales(userId);

    ref.read(routerProvider).router.goNamed(AppRoutes.readerView,
        pathParameters: {
          'taleId': ref.read(actualTaleProvider.notifier).state
        });
  }

  void _onPressedFollow(
      WidgetRef ref, String imageUrl, String title, String taleId) async {
    final uid = ref.read(authRepositoryProvider).getActualUserId();

    if (!isUserSigned(uid)) return;
    final userTalesController = ref.read(libraryManagementProvider.notifier);
    if (!widget.isFollowing) {
      await userTalesController.updateTale(
        userId: uid,
        taleId: taleId,
        taleTitle: title,
        coverUrl: imageUrl,
        progress: UserTalesStatus.following,
      );
      debugPrint('following');
    } else {
      await userTalesController.updateTale(
        userId: uid,
        taleId: taleId,
        taleTitle: title,
        coverUrl: imageUrl,
        progress: UserTalesStatus.unfollowing,
      );

      ref.read(favoriteUsertalesProvider.notifier).loadUserTales(uid);
      debugPrint('not following');
    }

    _toogleFollowing(!widget.isFollowing);
  }

  void _toogleFollowing(bool value) {
    setState(() {
      widget.isFollowing = value;
    });
  }

  bool isUserSigned(String userId) {
    if (userId == "") {
      CustomSnackbar.showSnackBar(context, "Inicie sesión para continuar");
      return false;
    }
    return true;
  }

  Widget floatingButton({required String label, required IconData icon}) {
    return Column(
      children: [
        Icon(
          icon,
          size: 30,
        ),
        Text(label)
      ],
    );
  }
}

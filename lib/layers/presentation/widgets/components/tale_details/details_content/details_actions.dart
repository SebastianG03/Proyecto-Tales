import 'package:cuentos_pasantia/layers/application/providers/providers.dart';
import 'package:cuentos_pasantia/layers/domain/entities/user/user_tales_status.dart';
import 'package:cuentos_pasantia/layers/presentation/widgets/custom/custom_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../../../config/router/app_routes.dart';
import '../../../custom/custom_text_button_with_icon.dart';

class FBDetailsActions extends ConsumerStatefulWidget {
  final String taleId;
  final String taleTitle;
  final String coverUrl;
  final String userId;
  const FBDetailsActions({
    super.key,
    required this.taleId,
    required this.taleTitle,
    required this.coverUrl,
    required this.userId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FloatingButtonDetailsActionsState();
}

class _FloatingButtonDetailsActionsState
    extends ConsumerState<FBDetailsActions> {
  bool isFollowing = false;
  final _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      key: _key,
      openButtonBuilder: RotateFloatingActionButtonBuilder(
        child: const Icon(Icons.add),
        fabSize: ExpandableFabSize.regular,
        heroTag: 'openButton',
        shape: const CircleBorder(),
      ),
      closeButtonBuilder: DefaultFloatingActionButtonBuilder(
        heroTag: 'closeButton',
        child: const Icon(Icons.close),
        fabSize: ExpandableFabSize.small,
        shape: const CircleBorder(),
      ),
      children: [
        FloatingActionButton.small(
          heroTag: 'playButton',
          child: const Icon(
            LineIcons.play,
            size: 30,
          ),
          onPressed: () {
            _onPressedPlay(widget.taleId, widget.userId, widget.coverUrl,
                widget.taleTitle, ref);
          },
        ),
        FloatingActionButton.small(
          heroTag: 'restartButton',
          child: const Icon(
            LineIcons.backward,
            size: 30,
          ),
          onPressed: () {},
        ),
        FloatingActionButton.small(
          heroTag: 'followButton',
          child: !isFollowing
              ? const Icon(
                  Icons.favorite_outline_rounded,
                  size: 30,
                )
              : const Icon(
                  Icons.favorite,
                  size: 30,
                ),
          onPressed: () {
            _onPressedFollow(ref, widget.userId, widget.coverUrl,
                widget.taleTitle, widget.taleId);
          },
        )
      ],
    );
  }

  void _onPressedPlay(String taleId, String userId, String imageUrl,
      String title, WidgetRef ref) async {
    if (!isUserSigned(userId)) return;
    debugPrint(taleId);
    final userTalesController = ref.read(libraryManagementProvider.notifier);
    final exists = await userTalesController.userTaleExists(userId, taleId);

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

    ref.read(routerProvider).router.goNamed(AppRoutes.readerView,
        pathParameters: {
          'taleId': ref.read(actualTaleProvider.notifier).state
        });
  }

  void _onPressedFollow(WidgetRef ref, String uid, String imageUrl,
      String title, String taleId) async {
    if (!isUserSigned(uid)) return;
    final userTalesController = ref.read(libraryManagementProvider.notifier);
    if (!isFollowing) {
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
        progress: UserTalesStatus.unFollow,
      );
      debugPrint('not following');
    }

    _toogleFollowing(!isFollowing);
  }

  void _toogleFollowing(bool value) {
    setState(() {
      isFollowing = value;
    });
  }

  bool isUserSigned(String userId) {
    if (userId == "") {
      CustomSnackbar.showSnackBar(context, "Inicie sesión para continuar");
      return false;
    }
    return true;
  }
}

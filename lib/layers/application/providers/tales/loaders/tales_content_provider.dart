import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/entities/tales/tales_exports.dart';
import '../../providers.dart';

final taleContentProvider =
    FutureProvider.autoDispose.family<Tales, String>((ref, id) async {
  return await ref.read(talesRepositoryProvider).getTale(id);
});

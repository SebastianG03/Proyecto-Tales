import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cuentos_pasantia/layers/domain/entities/tales/tales.dart';
import 'package:cuentos_pasantia/layers/presentation/widgets/components/search/tales_results_suggestions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

typedef SearchTalesCallback = Future<List<Tales>> Function(String query);

class SearchTaleDelegate extends SearchDelegate<Tales?> {
  final SearchTalesCallback searchTales;
  List<Tales> initialTales;

  SearchTaleDelegate({required this.searchTales, this.initialTales = const []});

  StreamController<List<Tales>> debounceTales = StreamController.broadcast();
  StreamController<bool> isLoading = StreamController.broadcast();
  Timer? _debounceTimer;

  void clearStreams() {
    debounceTales.close();
    isLoading.close();
  }

  void _onQueryChange(String query) {
    isLoading.add(true);

    debugPrint("query: $query");

    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        debounceTales.add([]);
        isLoading.add(false);
        return;
      }

      final List<Tales> tales = await searchTales(query);
      isLoading.add(false);
      // debugPrint('Tales data: ${tales.length}, First: ${tales.first.title}');
      initialTales = tales;
      debounceTales.add(tales);
    });
  }

  void _onClose(BuildContext context, Tales tale) {
    clearStreams();
    close(context, tale);
  }

  @override
  String? get searchFieldLabel => "Buscar";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoading.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              spins: 10,
              curve: Curves.fastOutSlowIn,
              duration: const Duration(seconds: 10),
              infinite: true,
              child: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.refresh_rounded)),
            );
          }

          return FadeIn(
            animate: query.isNotEmpty,
            delay: const Duration(microseconds: 100),
            curve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 200),
            child: IconButton(
                onPressed: () => query = "", icon: const Icon(Icons.clear)),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return PlatformIconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      },
      cupertinoIcon: const Icon(CupertinoIcons.back),
      materialIcon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return BuildResultsAndSuggestions(
      initialTales: initialTales,
      debounceTales: debounceTales,
      onClose: _onClose,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChange(query);
    return BuildResultsAndSuggestions(
      initialTales: initialTales,
      debounceTales: debounceTales,
      onClose: _onClose,
    );
  }
}

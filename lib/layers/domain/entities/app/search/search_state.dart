import 'package:cuentos_pasantia/layers/domain/entities/app/search/enums/tags_helper.dart';
import 'package:flutter/material.dart';

import 'enums/enums.dart';

class SearchState extends ChangeNotifier {
  final TimeLapse timeLapse;
  final List<Gender> genders;
  final AgeLimit ageLimit;
  final Accessibility accesibility;
  final String search;
  final bool isLoading;

  SearchState({
    this.genders = const [],
    this.ageLimit = AgeLimit.forAll,
    this.accesibility = Accessibility.all,
    this.timeLapse = TimeLapse.recent,
    this.search = "",
    this.isLoading = false,
  });

  SearchState copyWith({
    TimeLapse? timeLapse,
    List<Gender>? genders,
    AgeLimit? ageLimit,
    Accessibility? accesibility,
    String? search,
    bool? isLoading,
  }) {
    return SearchState(
      timeLapse: timeLapse ?? this.timeLapse,
      genders: genders ?? this.genders,
      ageLimit: ageLimit ?? this.ageLimit,
      accesibility: accesibility ?? this.accesibility,
      search: search ?? this.search,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  SearchState updateByKey(SearchKeys key, dynamic value) {
    switch (key) {
      case SearchKeys.timeLapse:
        return copyWith(timeLapse: TagsHelper.getTimeLapseByName(value));
      case SearchKeys.genders:
        List<Gender> genders = (value as List<String>)
            .map((e) => GenderTalesHelper.getGenderByName(e))
            .toList();
        return copyWith(genders: genders);
      case SearchKeys.ageLimit:
        return copyWith(ageLimit: TagsHelper.getAgeLimitByName(value));
      case SearchKeys.accesibility:
        return copyWith(accesibility: TagsHelper.getAccessibilityByName(value));
    }
  }

  SearchState resetKeyValue(SearchKeys key) {
    switch (key) {
      case SearchKeys.timeLapse:
        return copyWith(timeLapse: TimeLapse.recent);
      case SearchKeys.genders:
        return copyWith(genders: []);
      case SearchKeys.ageLimit:
        return copyWith(ageLimit: AgeLimit.forAll);
      case SearchKeys.accesibility:
        return copyWith(accesibility: Accessibility.all);
    }
  }

  void notify() {
    notifyListeners();
  }
}

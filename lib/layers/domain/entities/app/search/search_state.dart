import 'enums/enums.dart';

class SearchState {
  final TimeLapse timeLapse;
  final List<Gender>? genders;
  final AgeLimit ageLimit;
  final Accesibility accesibility;
  final String search;
  final bool isLoading;

  SearchState({
    this.genders,
    this.ageLimit = AgeLimit.forAll,
    this.accesibility = Accesibility.all,
    this.timeLapse = TimeLapse.recent,
    this.search = "",
    this.isLoading = false,
  });

  SearchState copyWith({
    TimeLapse? timeLapse,
    List<Gender>? genders,
    AgeLimit? ageLimit,
    Accesibility? accesibility,
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
}

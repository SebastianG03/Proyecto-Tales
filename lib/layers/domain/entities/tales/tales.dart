import 'dart:io';

import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'tales_exports.dart';

/// Clase Tales, representa el cuerpo principal del cuento que será
/// subido a la base de datos. Contiene el título del cuento, un resumen
/// al cual el usuario podrá acceder mediante la aplicación y una imagen de
/// portada, la cual se colocará en la aplicación para reconocer al cuento de la página principal.

class Tales {
  final String id;
  final String title;
  final int ageLimit;
  final List<Gender> genders;
  final String abstract;
  final File? coverImage;
  final DateTime creationTime;
  final bool premium;
  String _coverUrl = "";
  List<Chapter> _chapters = [];

  Tales({
    required this.title,
    required this.abstract,
    required this.coverImage,
    required this.ageLimit,
    required this.genders,
    required this.premium,
  })  : id = const Uuid().v4(),
        creationTime = DateTime.now();

  Tales.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        abstract = json["abstract"],
        coverImage = null,
        ageLimit = json['ageLimit'],
        premium = json['premium'],
        creationTime = DateTime.parse(json['creationTime']),
        genders = [] {
    _coverUrl = json['coverUrl'];
    json['genders'].forEach((element) {
      genders.add(GenderTalesHelper.getGenderByName(element));
    });
  }

  Tales.allDataFromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        abstract = json["abstract"],
        coverImage = null,
        ageLimit = json['ageLimit'],
        premium = json['premium'],
        creationTime = DateTime.parse(json['creationTime']),
        genders = [] {
    _coverUrl = json['coverUrl'];
    json['genders'].forEach((element) {
      genders.add(GenderTalesHelper.getGenderByName(element));
    });

    if (json['chapters'] != null) {
      _chapters = <Chapter>[];
      json['chapters'].forEach((v) {
        _chapters.add(Chapter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final dateFormat = DateFormat('yyyy-MM-dd');
    return {
      'id': id,
      'title': title,
      'abstract': abstract,
      'coverUrl': _coverUrl,
      'ageLimit': ageLimit,
      'premium': premium,
      'creationTime': dateFormat.format(creationTime),
      'genders': genders.map((e) => e.name).toList(),
      'chapters': _chapters.map((e) => e.toJson()).toList(),
    };
  }

  Map<String, dynamic> dataToJson() {
    final dateFormat = DateFormat('yyyy-MM-dd');
    return {
      'id': id,
      'title': title,
      'abstract': abstract,
      'coverUrl': _coverUrl,
      'ageLimit': ageLimit,
      'premium': premium,
      'creationTime': dateFormat.format(creationTime),
      'genders': genders.map((e) => e.name).toList(),
    };
  }

  String get getCoverUrl => _coverUrl;
  set setCoverUrl(String coverUrl) => _coverUrl = coverUrl;

  List<Chapter> get getChapters => _chapters;
  set setChapters(List<Chapter> chapters) => _chapters = chapters;
}

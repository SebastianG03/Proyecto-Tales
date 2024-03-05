import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:proyecto_pasantia/layers/domain/entities/tales/tales_exports.dart';
import 'package:proyecto_pasantia/layers/infrastructure/datasources/tales_datasource.dart';

class MockData {
  void mockData() async {
    final List<Tales> tales = await generateTestTales();
    final talesDatasource = TalesDataSource();

    for (Tales tale in tales) {
      Future.delayed(const Duration(seconds: 10), () {
        talesDatasource.uploadTale(tale);
      });
    }
    debugPrint('Mock data uploaded.');
  }

  Future<List<Tales>> generateTestTales() async {
    List<Tales> tales = [];
    int imageIndex = 1;

    for (int i = 0; i <= 40; i++) {
      String title = "Cuento de prueba ${i + 1}";
      String abstract = '''
      Resumen del cuento de prueba ${i + 1}.
      Fugiat est adipisicing et ut. Ullamco labore voluptate culpa aliquip sit irure incididunt
      deserunt ullamco irure do occaecat cillum. Eu duis nulla consectetur sit.
      Nisi veniam irure et eu excepteur aute incididunt incididunt consectetur occaecat qui nisi qui aute.
      Consectetur non ut irure amet nostrud excepteur. Pariatur proident aliquip dolor pariatur culpa dolor 
      aliqua id.
      Magna eu anim voluptate nulla eu dolore nulla cillum. Cupidatat laboris culpa proident aute voluptate
      proident voluptate anim. Velit minim nostrud in non nulla sint proident aute duis est culpa elit.
      Tempor et proident quis adipisicing labore incididunt magna nisi aute nisi aliqua commodo minim.
      Sit mollit amet ullamco elit duis dolor proident.
    ''';
      int ageLimit = Random().nextInt(16).clamp(8, 16);
      bool premium = i % 3 != 0;
      const values = Gender.values;
      List<Gender> genders = [
        values[Random().nextInt(values.length).clamp(0, 3)],
        values[Random().nextInt(values.length).clamp(4, 6)],
        values[Random().nextInt(values.length).clamp(7, 10)],
        values[Random().nextInt(values.length).clamp(11, 13)],
      ];
      if (imageIndex > 27) {
        imageIndex = 1;
      } else {
        imageIndex++;
      }

      final dir = (await getApplicationDocumentsDirectory()).path;
      File coverImage = File('$dir/portada$imageIndex.jpg');

      tales.add(Tales(
        title: title,
        abstract: abstract,
        premium: premium,
        coverImage: coverImage,
        ageLimit: ageLimit,
        genders: genders,
      ));

      final chapters = generateChapters();
      tales[i].setCoverUrl = getRandomUrl();
      tales[i].setChapters = chapters;
    }

    return tales;
  }

  List<Chapter> generateChapters() {
    List<Chapter> chapters = [];
    for (int i = 0; i < 10; i++) {
      String chapterTitle = "Capítulo ${i + 1}";

      final firstSections = generateSections(0);
      final secondSections = generateSections(10);
      final sections = linkSections(firstSections, secondSections);
      final chapter =
          Chapter(id: i, chapterTitle: chapterTitle, sections: sections);
      chapters.add(chapter);
    }
    return chapters;
  }

  List<Section> generateSections(int firstIndex) {
    int index = firstIndex;
    List<Section> sections = [];
    bool pasted = false;
    for (int i = 0; i < 10; i++) {
      String sectionTitle = "Sección $index";
      String sectionContent = '''
      Contenido de la sección $index.
      Fugiat est adipisicing et ut. Ullamco labore voluptate culpa aliquip sit irure incididunt
      deserunt ullamco irure do occaecat cillum. Eu duis nulla consectetur sit.
      Nisi veniam irure et eu excepteur aute incididunt incididunt consectetur occaecat qui nisi qui aute.
      Consectetur non ut irure amet nostrud excepteur. Pariatur proident aliquip dolor pariatur culpa dolor 
      aliqua id.
    ''';
      final options = generateOptions();
      final section = Section(
          publicId: sectionTitle, text: sectionContent, options: options);

      if (!pasted) section.setImageUrl = getRandomUrl();
      sections.add(section);
      pasted = true;
      index++;
    }
    return sections;
  }

  List<Section> linkSections(
      List<Section> firstSections, List<Section> secondSections) {
    String idPrevius = "";
    for (int i = 0; i < firstSections.length; i++) {
      if (i == 0) {
        firstSections.first.options.first.setNext = firstSections[i + 1].id;
      } else if (i + 1 != firstSections.length) {
        firstSections[i].options.first.setPrevious = idPrevius;
        firstSections[i].options.first.setNext = firstSections[i + 1].id;
      } else {
        firstSections[i].options.first.setPrevious = idPrevius;
      }
      idPrevius = firstSections[i].id;
    }
    idPrevius = "";

    for (int i = 0; i < secondSections.length; i++) {
      if (i == 0) {
        firstSections.first.options.last.setNext = secondSections[i].id;
      } else if (i + 1 != secondSections.length) {
        secondSections[i].options.first.setPrevious = idPrevius;
        secondSections[i].options.first.setNext = secondSections[i + 1].id;
      }
      {
        firstSections[i].options.first.setPrevious = idPrevius;
      }
      idPrevius = secondSections[i].id;
    }
    final List<Section> newList = [];
    newList.addAll(firstSections);
    newList.addAll(secondSections);

    return newList;
  }

  String getRandomUrl() {
    final List<String> imageUrls = [
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada1.jpg?alt=media&token=1b95061d-a935-4b8b-b68a-5a0f6b0a7530',
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada2.jpg?alt=media&token=75965b10-4a4d-4e82-8c35-c21199865d07',
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada3.jpg?alt=media&token=d7f743a3-59e3-434d-a220-fe08fc27b268',
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada4.jpg?alt=media&token=29b99035-0023-4f3c-b3e6-788c31db1701',
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada5.jpg?alt=media&token=67ceb494-6071-472d-834c-2daa8d5c43fa',
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada6.jpg?alt=media&token=cf180769-1287-4ad0-ae42-7d543a119532',
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada7.jpg?alt=media&token=a5cd1735-d5bc-4f74-bedf-71efb2fa78d5',
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada8.jpg?alt=media&token=90fc1441-cd69-43cf-adfd-a19b6a18a3a8',
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada9.jpg?alt=media&token=80b3645a-b0e0-4ba4-8edd-f01ba25408db',
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada10.jpg?alt=media&token=38cb05e9-ff98-4d28-bb1d-71b56e43c21b',
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada11.jpg?alt=media&token=a5b5d9fb-3301-4700-8b89-e8fab4fc4ab0',
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada12.jpg?alt=media&token=9e81622d-9eea-42a0-80ba-33e2cc77c784',
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada13.jpg?alt=media&token=41a0cac3-53f5-401f-a405-9045ec66e402',
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada14.jpg?alt=media&token=93441b8a-6ade-4df8-8fa4-ee3b218a3dad',
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada15.jpg?alt=media&token=3df8ea7a-2ed5-48a7-8fc6-9a2df0a3ec85',
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada16.jpg?alt=media&token=fa3f648f-1bb6-4298-bb4f-0595584cb2bf',
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada17.jpg?alt=media&token=f09e9aeb-5781-4535-a43f-1e1fa18a9309',
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada18.jpg?alt=media&token=a8cfa51f-08f6-43da-a4d4-a2593c5a356f',
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada19.jpg?alt=media&token=c1d68371-f69d-4a7d-8681-644cdd4a80c3',
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada20.jpg?alt=media&token=1eccd6ad-c3c6-4795-9821-4ca2c9370e2a',
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada21.jpg?alt=media&token=102b35f8-fa33-49eb-8861-e6c5fef09d9e',
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada22.jpg?alt=media&token=ddc6d7b2-359b-47b6-b6b7-61918a3ab246',
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada23.jpg?alt=media&token=fc01fb36-f696-4b54-be83-87dd81bf92a5',
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada24.jpg?alt=media&token=e2db677f-2b21-4860-b97f-2265945cb98d',
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada25.jpg?alt=media&token=372d3deb-2f62-4b61-8c75-058357b8e56f',
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada26.jpg?alt=media&token=93af8358-f4b8-4bd3-aa86-db91cdb9256a',
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada27.jpg?alt=media&token=48ca17c4-bc11-4b00-b537-b9cc53e41a48',
      'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada27.jpg?alt=media&token=48ca17c4-bc11-4b00-b537-b9cc53e41a48',
    ];

    return imageUrls[Random().nextInt(imageUrls.length)];
  }

  List<Options> generateOptions() {
    var option = Options(text: 'Opción 1', id: 'A');
    var option2 = Options(text: 'Opción 2', id: 'B');
    return [option, option2];
  }
}

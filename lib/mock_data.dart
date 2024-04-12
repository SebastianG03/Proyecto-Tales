import 'dart:io';

import 'package:cuentos_pasantia/layers/infraestructure/datasources/datasources.dart';

import 'layers/domain/entities/tales/tales_exports.dart';

class MockData {
  void mockData() async {
    final tale = await createTale();
    final datasource = TalesDataSource();
    Future.delayed(const Duration(microseconds: 100), () {
      datasource.uploadTale(tale);
    });
  }

  void loadData() {}

  Future<Tales> createTale() async {
    // Directory dir = await getApplicationDocumentsDirectory();
    Tales tale = Tales(
        title: "Las aventuras de Alan y Elena",
        abstract:
            "Este es un cuento de prueba creado con el fin de comprobar el comportamiento de la App.",
        coverImage: File(
            "/Users/guama/Desktop/cuentos_pasantia/assets/tales_sample/portada_elena_alan.jpg"),
        ageLimit: 8,
        genders: [Gender.Aventura, Gender.Fantasia, Gender.Magia],
        premium: false);
    tale.setChapters = [generateFirstChapter(), generateSecondChapter()];
    tale.setCoverUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada_elena_alan.jpg?alt=media&token=098f53de-4400-41a0-ba41-316c11bf91d8";
    return tale;
  }

  Chapter generateFirstChapter() {
    return Chapter(
      id: 0,
      chapterTitle: "Capítulo 1: La gran aventura.",
      sections: firstChapterGenerateSectionsRoutes(),
    );
  }

  Chapter generateSecondChapter() {
    return Chapter(
        id: 1,
        chapterTitle: "Capítulo 2: El desafío final.",
        sections: generateSecondChapterRoutes());
  }

  List<Section> firstChapterGenerateSectionsRoutes() {
    final endOfChapter = Section(
        publicId: "",
        text:
            " Mientras tanto, en el pueblo, los rumores de la desaparición de los niños se propagaban como un incendio, "
            "sembrando el temor y la desconfianza en los corazones de los lugareños. ¿Lograrían Elena y Alan encontrar el camino de regreso a casa?",
        options: []);
    final introduction = Section(
      publicId: "Introduccion",
      text:
          "En un reino lejano, donde la magia impregnaba el aire, vivía Elena, una niña de noble cuna pero con un espíritu inquieto. Ansiaba explorar más allá de los muros de su hogar, curiosa por descubrir los secretos que se ocultaban en el vasto mundo.",
      options: const [],
    );
    introduction.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_aventuras_de_elena_y_alan%2Fchapter_1%2Fintroduction.jpg?alt=media&token=b82d5db1-8e7e-4b25-be42-a9828f5ade98";

    final firstSelection = Section(
      publicId: "Primero",
      text:
          "Un día, mientras jugaba en los jardines, Elena descubrió un pasadizo oculto que la llevó a un bosque encantado. "
          "Elena avanzó mediante el pasadizo hasta llegar a una bifurcación. ¿Qué camino ha de tomar?",
      options: [],
    );
    firstSelection.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_aventuras_de_elena_y_alan%2Fchapter_1%2Felena_discovers_passage.jpg?alt=media&token=65f07ecc-baf0-4de9-b4ab-a425e5333c9f";
    introduction.options = [
      getOption("Continuar", "Continuar", "", firstSelection.id)
    ];
    List<Section> sectionsRouteA =
        getFirstChapterRouteA(firstSelection, endOfChapter);
    List<Section> sectionsRouteB =
        getFirstChapterRouteB(firstSelection, endOfChapter);

    firstSelection.options.add(getOption("Opcion A", "Camino de la izquierda",
        introduction.id, sectionsRouteA.first.id));
    firstSelection.options.add(getOption("Opcion B", "Camino de la derecha",
        introduction.id, sectionsRouteB.first.id));
    endOfChapter.options
        .add(getOption("Continuará...", "Continuará...", "", ""));

    return [
      introduction,
      endOfChapter,
      firstSelection,
      ...sectionsRouteA,
      ...sectionsRouteB
    ];
  }

  List<Section> getFirstChapterRouteA(
      Section firstSection, Section endOfChapter) {
    //Ruta A
    final initARoute = Section(
      publicId: "Primera Ruta",
      text: "Elena decidió tomar el camino de la izquierda. "
          "Allí entró a un bosque mágico con árboles cubiertos de musgo fosforecente, donde vivía un sabío que la guió en su aventura",
      options: [],
    );
    initARoute.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_aventuras_de_elena_y_alan%2Fchapter_1%2Felena-meeting-wiseman.jpg?alt=media&token=8451789d-f705-4708-a989-059d1c5e2230";

    final secondSelectionSection = Section(
        publicId: "Inicio ruta AA y AB",
        text:
            "El sabio la guió por el bosque, enseñádole todo tipo de criaturas mágicas que habitaban el lugar. "
            "Maravillada se desvió del camino para perseguir a un conejo blanco como la nieve y con un cuerno en la frente que resplandecía en la oscuridad."
            " De pronto, se encontró perdida y sin rumbo. ¿Qué debería hacer Elena?",
        options: []);
    secondSelectionSection.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_aventuras_de_elena_y_alan%2Fchapter_1%2Felena_chasing_rabbit.jpg?alt=media&token=381f6b16-8a98-4b93-8e44-b0ee6714d515";

    initARoute.options = [
      getOption(
          "Siguiente", "Continuar", firstSection.id, secondSelectionSection.id)
    ];
    //Ruta AA
    final initAARoute = Section(
        publicId: "Llegada al pueblo",
        text: "Llegó a un pequeño pueblo de mala muerte."
            "Allí conoció a Alan, un niño vivaz y travieso, quien se unió a su aventura sin dudarlo.",
        options: []);
    initAARoute.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_aventuras_de_elena_y_alan%2Fchapter_1%2Felena_meeting_alan.jpg?alt=media&token=8326ba06-91bf-4c09-bdcc-725c9f514ce3";

    secondSelectionSection.options.add(getOption(
        "Ruta AA", "Deambular por el bosque", initARoute.id, initAARoute.id));

    final lastSectionAARoute = Section(
        publicId: "",
        text: "Tiempo después el sabio los encontró en el pueblo."
            "El sabio les reveló que una fuerza oscura amenazaba el reino y que sólo ellos, con su valentía y pureza de corazón, podrían detenerla.",
        options: []);
    lastSectionAARoute.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_aventuras_de_elena_y_alan%2Fchapter_1%2Felena_alan_wiseman_in_the_forest.jpg?alt=media&token=1991e9ad-6944-4da9-9be7-fe372f7bbee2";

    initAARoute.options.add(getOption("Continuar", "Continuar",
        secondSelectionSection.id, lastSectionAARoute.id));
    lastSectionAARoute.options.add(
        getOption("Continuar", "Continuar", initAARoute.id, endOfChapter.id));
    //Ruta AB
    final initABRoute = Section(
        publicId: "Encuetro inesperado",
        text:
            "Tiempo después, Elena escuchó el sonido de arbustos moviéndose cerca suyo. "
            "Asustada lanzó lo primero que alcanzó su mano al arbusto."
            " Del cual, salió un niño cubriendo su cabeza mientras gemía de dolor. ¿Cuál es la reacción de Elena?",
        options: []);
    initABRoute.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_aventuras_de_elena_y_alan%2Fchapter_1%2Falan_hitted_by_a_rock.jpg?alt=media&token=b3cd0ee1-11fb-4300-9974-86988d15ac22";

    secondSelectionSection.options.add(getOption("Opcion B",
        "Esperar a la ayuda del sabio", initARoute.id, initABRoute.id));

    //Ruta ABA
    final initABARoute = Section(
        publicId: "",
        text:
            "Tras un silencio incómodo Elena da un paso adelante y se presenta. En respuesta, Alan, un poco enojado también se presenta."
            "Después de charlar un poco respecto a su situación, ambos descubren que están perdidos por lo que sin otra opción se recuestan "
            "en un árbol cercano a esperar por ayuda del sabio.",
        options: []);
    initABRoute.options.add(getOption("Opcion A", "Finge que nada sucedió",
        secondSelectionSection.id, initABARoute.id));

    final endOfRouteABA = Section(
        publicId: "",
        text: "Tiempo después el sabio los encuentra."
            "El sabio les reveló que una fuerza oscura amenazaba el reino y que sólo ellos, con su valentía y pureza de corazón, podrían detenerla. "
            "Alan emocionado se une a la aventura ignorando la opinión de Elena.",
        options: []);
    endOfRouteABA.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_aventuras_de_elena_y_alan%2Fchapter_1%2Felena_alan_wiseman_in_the_forest.jpg?alt=media&token=1991e9ad-6944-4da9-9be7-fe372f7bbee2";

    initABARoute.options.add(
        getOption("Continuar", "Continuar", initABRoute.id, endOfRouteABA.id));
    endOfRouteABA.options.add(
        getOption("Continuar", "Continuar", initABARoute.id, endOfChapter.id));

    //Ruta ABB
    final initABBRoute = Section(
        publicId: "",
        text:
            "Después de disculparse y presentarse. Elena aprende que Alan es un niño de un pueblo cercano que se perdió en el bosque. "
            "Por simpatía Elena invita a Alan a unirse a viajar con ella y acepta gustosamente. "
            "Tiempo después el sabio los encuentra.",
        options: []);

    initABRoute.options.add(getOption(
        "Opcion B", "Se disculpa", secondSelectionSection.id, initABBRoute.id));

    final endABBRoute = Section(
        publicId: "",
        text:
            "El sabio les reveló que una fuerza oscura amenazaba el reino y que sólo ellos, con su valentía y pureza de corazón, podrían detenerla.",
        options: []);

    endABBRoute.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_aventuras_de_elena_y_alan%2Fchapter_1%2Felena_alan_wiseman_in_the_forest.jpg?alt=media&token=1991e9ad-6944-4da9-9be7-fe372f7bbee2";

    initABBRoute.options.add(
        getOption("Continuar", "Continuar", initABRoute.id, endABBRoute.id));

    endABBRoute.options.add(
        getOption("Continuar", "Continuar", initABBRoute.id, endOfChapter.id));

    return [
      initARoute,
      secondSelectionSection,
      initAARoute,
      lastSectionAARoute,
      initABRoute,
      initABARoute,
      endOfRouteABA,
      initABBRoute,
      endABBRoute,
    ];
  }

  List<Section> getFirstChapterRouteB(
      Section firstSelection, Section endOfChapter) {
    final initSectionB = Section(
        publicId: "Init Route B",
        text:
            "Allí conoció a Alan, un niño del pueblo cercano, quien se unió a su aventura sin dudarlo.",
        options: []);
    initSectionB.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_aventuras_de_elena_y_alan%2Fchapter_1%2Felena_meeting_alan.jpg?alt=media&token=8326ba06-91bf-4c09-bdcc-725c9f514ce3";

    final firstSelectionRoute = Section(
        publicId: "",
        text:
            "Juntos se adentraron en el bosque, maravillados por las criaturas mágicas que los rodeaban. "
            "De pronto, se encontraron perdidos y sin rumbo. ¿Cómo deberían encontrar el camino correcto?",
        options: []);
    initSectionB.options.add(getOption(
        "Continuar", "Continuar", firstSelection.id, firstSelectionRoute.id));

    //Ruta BA
    final selectionRouteBA = Section(
        publicId: "",
        text: "Aunque se encuentran más perdidos que antes. "
            "Elena descubrió un sendero cubierto por maleza debido a su desuso que guia hacia una pequeña cabaña. ¿Qué deberían hacer?",
        options: []);

    selectionRouteBA.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_aventuras_de_elena_y_alan%2Fchapter_1%2Felena_alan_house.jpg?alt=media&token=d0c95f6e-61bd-47e9-9099-0750d050a15a";

    //Ruta Casa del sabio (BB)
    final startRouteBB = Section(
        publicId: "",
        text:
            "Encuentran a un anciano de barba blanca y aura misteriosa que camina a través del bosque."
            "Alan y Elena acuden al anciano en busca de ayuda, quién gustosamente les ayuda",
        options: []);
    startRouteBB.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_aventuras_de_elena_y_alan%2Fchapter_1%2Felena_alan_wiseman_in_the_forest.jpg?alt=media&token=1991e9ad-6944-4da9-9be7-fe372f7bbee2";

    final endOfSection = Section(
        publicId: "",
        text:
            "El sabio les reveló que una fuerza oscura amenazaba el reino y que sólo ellos, con su valentía y pureza de corazón, podrían detenerla. "
            "Los padres de Elena, preocupados por su desaparición buscaron cualquier rastro de su hija.",
        options: []);
    endOfSection.options.add(
        getOption("Continuar", "Continuar", startRouteBB.id, endOfChapter.id));

    startRouteBB.options.add(getOption(
        "Continuar", "Continuar", firstSelectionRoute.id, endOfSection.id));

    firstSelectionRoute.options = [
      getOption(
          "Opcion A",
          "Alan guía a Elena en la dirección donde recuerda en la que se encuentra el pueblo.",
          initSectionB.id,
          selectionRouteBA.id),
      getOption("Opcion B", "Escalan el árbol más alto en busca de ayuda.",
          initSectionB.id, startRouteBB.id),
    ];

    //Final Corto
    final initShortFinal = Section(
        publicId: "",
        text:
            "El sendero resultó conectarse con el camino principal entre la casa de Elena y el pueblo de Alan. Dónde se ven obligados a separarse al encontrarse con los padres de Elena que iban en su búsqueda.",
        options: []);
    final alternativeEndOfChapter = Section(
        publicId: "",
        text:
            "Aunque Elena se encontró un poco renuente a separarse, se sintió satisfecha con esta entretenida y corta aventura, por lo cual se despidió de Alan y volvió a casa con sus padres.",
        options: []);
    initShortFinal.options.add(getOption("Continuar", "Continuar",
        selectionRouteBA.id, alternativeEndOfChapter.id));
    alternativeEndOfChapter.options
        .add(getOption("Fin", "Fin", initShortFinal.id, ""));

    //Ruta alternativa
    final initRouteAlternative = Section(
        publicId: "",
        text:
            "Cuando Alan y Elena se encuentra en la cabaña tocan la puerta para comprobar si alguien se encuentra dentro. "
            "Afortunadamente, un hombre de barba blanca y aura misteriosa abre la puerta. "
            "Después de explicarle su situación se ofrece a guiarlos de vuelta al pueblo.",
        options: []);
    initRouteAlternative.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_aventuras_de_elena_y_alan%2Fchapter_1%2Felena_alan_house.jpg?alt=media&token=d0c95f6e-61bd-47e9-9099-0750d050a15a";
    initRouteAlternative.options.add(getOption(
        "Continuar", "Continuar", selectionRouteBA.id, endOfSection.id));
    selectionRouteBA.options = [
      getOption(
          "Final corto",
          "Siguen el sendero, en dirección contraria a la cabaña",
          firstSelectionRoute.id,
          initShortFinal.id),
      getOption("Ruta alternativa", "Caminan hacia la cabaña.",
          firstSelectionRoute.id, initRouteAlternative.id)
    ];

    return [
      initSectionB,
      firstSelectionRoute,
      selectionRouteBA,
      startRouteBB,
      endOfSection,
      initShortFinal,
      alternativeEndOfChapter,
      initRouteAlternative
    ];
  }

  List<Section> generateSecondChapterRoutes() {
    Section introduction = Section(
        text:
            "Después de días de caminata, Elena y Alan llegaron al corazón del bosque, donde una antigua criatura maligna había sido despertada. "
            "El sabio les advirtió del peligro, pero ellos estaban decididos a enfrentarlo."
            "Antes de la batalla Elena y Alan se decidieron cómo enfrentar a la criatura.",
        options: []);
    introduction.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_aventuras_de_elena_y_alan%2Fchapter_2%2Fintroduction.jpg?alt=media&token=13691a96-4ef2-4156-a979-288474981788";

    //Ruta A
    Section sectionARoute = Section(
        text:
            "Cuando Alan y Elena fueron a pedir ayuda, se encontraron con los padres de Elena, quienes les ayudaron a prepararse para la batalla. "
            "El sabio les entregó un talismán mágico, capaz de debilitar a la criatura oscura.",
        options: []);
    sectionARoute.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_aventuras_de_elena_y_alan%2Fchapter_2%2Fwiseman-and-talisman.jpg?alt=media&token=1598fb3e-d724-467b-a846-4037900c802b";
    //Ruta B
    Section sectionBRoute = Section(
        text:
            "Los padres de Elena les sorprendieron durante su planificación y ayudaron a los niños a prepararse para la batalla. "
            "El sabio les entregó un talismán mágico, capaz de debilitar a la criatura oscura.",
        options: []);
    sectionBRoute.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_aventuras_de_elena_y_alan%2Fchapter_2%2Fwiseman-and-talisman.jpg?alt=media&token=1598fb3e-d724-467b-a846-4037900c802b";

    introduction.options = [
      getOption(
          "Opcion A",
          "Pedir ayuda al pueblo para derrotar a la criatura.",
          "",
          sectionARoute.id),
      getOption(
          "Opcion B",
          "Calmar a la criatura y convencerla de volver a dormir.",
          "",
          sectionBRoute.id)
    ];

    Section secondSelectionSection = Section(
        text:
            "La batalla fue feroz, con hechizos y criaturas mágicas luchando de ambos bandos. ¿Cómo Alan y Elena deberían acercarse a la criatura?",
        options: []);
    secondSelectionSection.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_aventuras_de_elena_y_alan%2Fchapter_2%2Fblack-dragon-being-attacked.jpg?alt=media&token=364cce0f-d91e-4122-a4be-496c279ceb22";

    sectionARoute.options.add(getOption(
        "Continuar", "Continuar", introduction.id, secondSelectionSection.id));
    sectionBRoute.options.add(getOption(
        "Continuar", "Continuar", introduction.id, secondSelectionSection.id));

    //Ruta CA
    Section sectionCARoute = Section(
        text:
            "Elena y Alan, armados con su valentía y el talismán, intentaron acercarse pero las criaturas mágicos del bando enemigo no les dejaron las cosas fáciles, rompiendo talisman en consecuencia cuando estaban cerca de la criatura.",
        options: []);
    //Ruta CB
    Section sectionCBRoute = Section(
        text:
            "Elena y Alan, armados con su valentía y el talismán, lograron acercarse a la criatura maligna cuando ambos bandos estaba al borde del cansancio. Ningún bando se dió cuenta de sus acciones.",
        options: []);
    secondSelectionSection.options = [
      getOption("Opcion A", "Corren directamente hacia la criatura",
          sectionARoute.id, sectionCARoute.id),
      getOption(
          "Opcion B",
          "Rodean a la criatura y se acercan por su punto ciego.",
          sectionBRoute.id,
          sectionCBRoute.id)
    ];

    Section finalSection = Section(
        text:
            "En un momento crucial, el talismán se rompió, y parecía que todo estaba perdido. Pero Elena, recordando las enseñanzas del sabio, logró invocar un poder oculto dentro de sí misma, derrotando a la criatura oscura.",
        options: []);
    finalSection.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_aventuras_de_elena_y_alan%2Fchapter_2%2Fbroken-talisman.jpg?alt=media&token=1c0b286d-a567-453d-9041-6e0c1c2c498a";
    sectionCARoute.options.add(getOption(
        "Continuar", "Continuar", secondSelectionSection.id, finalSection.id));
    sectionCBRoute.options.add(getOption(
        "Continuar", "Continuar", secondSelectionSection.id, finalSection.id));
    Section endOfChapter = Section(
        text:
            "El reino fue salvado gracias al coraje de los niños, y los pueblos vecinos se unieron en celebración. Elena y Alan regresaron a casa como héroes, con una nueva apreciación por la magia y las aventuras que los esperaban.",
        options: []);
    finalSection.options
        .add(getOption("Continuar", "Continuar", "", endOfChapter.id));
    endOfChapter.options.add(getOption("Fin", "Fin", finalSection.id, ""));
    endOfChapter.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_aventuras_de_elena_y_alan%2Fchapter_2%2Fend-tale.jpg?alt=media&token=a0338aa0-f7bf-48fd-9743-f6177dd24606";
    return [
      introduction,
      sectionARoute,
      sectionBRoute,
      secondSelectionSection,
      sectionCARoute,
      sectionCBRoute,
      finalSection,
      endOfChapter
    ];
  }

  Options getOption(
      String id, String text, String previousSectionId, String nextSectionId) {
    Options option = Options(id: id, text: text);
    option.setNext = nextSectionId;
    option.setPrevious = previousSectionId;
    return option;
  }
}

import 'package:cuentos_pasantia/layers/domain/entities/tales/tales_exports.dart';
import 'package:cuentos_pasantia/layers/infraestructure/datasources/tales_datasource.dart';
import 'package:cuentos_pasantia/tales/mock_data.dart';

class MoreTales {
  void moreTales() async {
    final tale = createFirstTale();
    final datasource = TalesDataSource();
    Future.delayed(const Duration(microseconds: 100), () {
      datasource.uploadTale(tale);
    });
  }

  Tales createFirstTale() {
    final tale = Tales(
        title: "Las travesuras de Rufus",
        abstract:
            "En un pequeño pueblo rodeado de bosques, vivía Rufus, un zorro astuto y travieso cuyo mayor defecto era su incontrolable egoísmo y codicia. Famoso por sus robos nocturnos, Rufus se convertiría en la pesadilla de los granjeros locales al robarles gallinas, huevos, joyas y dinero sin que pudieran atraparlo. A pesar de las múltiples trampas, el ingenio del zorro le permitía burlar cada intento de captura. Finalmente, después de una racha legendaria de atracos, Rufus se retiró a una cueva en el bosque donde disfrutó de su botín como un temido y admirado ladrón de leyenda.",
        coverImage: null,
        ageLimit: 13,
        genders: [Gender.Aventura, Gender.Fantasia],
        premium: false);
    tale.setCoverUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Flas_travesuras_de_rufus.jpeg?alt=media&token=95618174-7280-46b2-84f4-504053317c78";
    tale.setChapters = [
      Chapter(
          id: 1,
          chapterTitle: "La imprudencia de Rufus",
          sections: generateSectionsTale())
    ];

    return tale;
  }

  List<Section> generateSectionsTale() {
    //First choice
    final initChapterSelection = Section(
        text:
            "En un pequeño pueblo rodeado de un frondoso e interminable bosque, vivía Rufus, un niño zorro astuto y travieso. Era famoso por su astucia y talento para escabullirse, pero su cualidad más destacada era...",
        options: []);
    initChapterSelection.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_travesuras_de_rufus%2Fchapter_1%2Frufus_in_the_forest.jpeg?alt=media&token=80f96126-24d2-4813-91a2-908853202339";

    final firstDescription = Section(
        text:
            "Si Rufus encontraba algo que no tenía, lo conseguía y si no podía conseguirlo de manera amable simplemente lo robaba.",
        options: []);
    firstDescription.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_travesuras_de_rufus%2Fchapter_1%2Frufus_with_bag_of_coins.jpeg?alt=media&token=fbff9ab7-8acf-46e4-978f-e2d8a9d0a7aa";
    final secondDescription = Section(
        text:
            "Si a Rufus le llamaba la atención un objeto lo conseguía a cómo de lugar sin importar las consecuencias.",
        options: []);
    secondDescription.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_travesuras_de_rufus%2Fchapter_1%2Frufus_with_bag_of_coins.jpeg?alt=media&token=fbff9ab7-8acf-46e4-978f-e2d8a9d0a7aa";

    initChapterSelection.options = [
      MockData.getOption(
          id: "A",
          text: "Su codicia",
          previousSectionId: "",
          nextSectionId: firstDescription.id),
      MockData.getOption(
          id: "B",
          text: "Su egoísmo",
          previousSectionId: "",
          nextSectionId: secondDescription.id),
    ];

    //Second choice
    final secondSelection = Section(
        text:
            "Un día, merodeando por los callejones. Rufus, de reojo, divisó una granja próspera llena de gallinas y gallos que cacareaban armoniosamente. Sus ojos brillaron con astucia y deseo de darse un banquete de carne. ¿Cómo debería proceder Rufus?",
        options: []);
    secondSelection.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_travesuras_de_rufus%2Fchapter_1%2Frufus_and_the_farm.jpeg?alt=media&token=ae3b9e5c-223d-4f32-aa37-7f670f59d546";

    firstDescription.options.add(MockData.getOption(
        id: "Continuar",
        text: "Continuar",
        previousSectionId: initChapterSelection.id,
        nextSectionId: secondSelection.id));

    secondDescription.options.add(MockData.getOption(
        id: "Continuar",
        text: "Continuar",
        previousSectionId: initChapterSelection.id,
        nextSectionId: secondSelection.id));

    final daySelected = Section(
        text:
            "Rufus pasó semanas estudiando el comportamiento del granjero. Después de armar un plan para alejar al granjero y escabullirse a en su granero decidió proceder.",
        options: []);

    final nightSelected = Section(
        text:
            "Cuando el sol se ocultó y la luna se mostraba tímidamente en el cielo rodeado de estrellas centelleantes. Rufus se escabulló sigilosamente hacia el gallinero, aprovechando la oscuridad de su entorno y con un oído avizor ante cualquier ruido. Ágilmente, logró abrir un pequeño agujero en la cerca y se deslizó hacia el interior. Sin embargo, sus esfuerzos fueron infructuosos cuando una de las gallinas sintió la presencia de un intruso y asustada despertó a sus hermanas, las cuales, en coro comenzaron a cacarear y aletear.",
        options: []);
    nightSelected.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_travesuras_de_rufus%2Fchapter_1%2Frufus_sneaking_barn_night.jpeg?alt=media&token=16b7e6e4-ba18-476e-a874-32d659c9015c";
    secondSelection.options = [
      MockData.getOption(
          id: "A",
          text: "Actuar de día",
          previousSectionId: "",
          nextSectionId: daySelected.id),
      MockData.getOption(
          id: "B",
          text: "Actuar de noche",
          previousSectionId: "",
          nextSectionId: nightSelected.id),
    ];

    // Day selected

    final daySelectionDescription = Section(
        text:
            "Parado bajo el ardiente sol, Rufus se paró de manera digna pero cautelosa y salió del bosque que colindaba con el granero. Apartó una roca que tapaba un agujero en la pared, el cual hizo mientrar vigilaba al granjero, y entró al granero como si de su casa se tratara.",
        options: []);
    daySelectionDescription.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_travesuras_de_rufus%2Fchapter_1%2Frufus_sneaking_barn_day.jpeg?alt=media&token=e271bd53-bb62-4baf-aa33-586e4de44223";

    daySelected.options.add(MockData.getOption(
        id: "Continuar",
        text: "Continuar",
        previousSectionId: secondSelection.id,
        nextSectionId: daySelectionDescription.id));

    final daySelectionOnExit = Section(text: """
Rufus con una mente tranquila, templada por la experiencia y su propio temperamento, actuó rápido como el viento para evitar que las gallinas hicieran demasiado ruido y alertaran algún oido indiscreto.
Una a una, Rufus metió en un saco a las gallinas más gordas. Satisfecho con su botín, se dispuso a escapar con una gran sonrisa en la cara. ¿Cómo debería irse Rufus?
        """, options: []);

    daySelectionOnExit.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_travesuras_de_rufus%2Fchapter_1%2Frufus_stealing_chickens_day.jpeg?alt=media&token=da626bf9-2815-420c-bb2e-c109dccb3042";

    daySelectionDescription.options.add(MockData.getOption(
        id: "Continuar",
        text: "Continuar",
        previousSectionId: daySelected.id,
        nextSectionId: daySelectionOnExit.id));

    // Night Selected
    final nightSelectedOnExit = Section(text: """
Pero Rufus, con una mente tranquila, templada por la experiencia y su propio temperamento, actuó rápido como el viento.
Una a una, Rufus metió en un saco a las gallinas más gordas. Satisfecho con su botín, se dispuso a escapar con una gran sonrisa en la cara.
¿Cómo debería irse Rufus?""", options: []);

    nightSelectedOnExit.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_travesuras_de_rufus%2Fchapter_1%2Frufus_stealing_chickens_night.jpeg?alt=media&token=2fc25ea1-81d2-4c14-97b6-9f783350a982";

    nightSelected.options.add(MockData.getOption(
        id: "Continuar",
        text: "Continuar",
        previousSectionId: secondSelection.id,
        nextSectionId: nightSelectedOnExit.id));

    // Exit by the door day and night

    final exitByTheDoor = Section(
        text:
            "Rufus sale orgullosamente por la puerta principal, cuando se encuentra al granero corriendo apresuradamente hacia el granero. Al ver al ladrón intenta perseguirlo pero desiste al ver que todos sus animales se están escapando.",
        options: []);

    daySelectionOnExit.options.add(MockData.getOption(
        id: "A",
        text: "Rufus sale por la puerta principal",
        previousSectionId: daySelectionDescription.id,
        nextSectionId: exitByTheDoor.id));

    nightSelectedOnExit.options.add(MockData.getOption(
        id: "B",
        text: "Rufus sale por la puerta principa;",
        previousSectionId: nightSelected.id,
        nextSectionId: exitByTheDoor.id));

    //Exit from where he come night and day

    final exitFromWhereCome = Section(text: """
Al salir Rufus se encuentra con el granjero.
Sin pensarlo dos veces, Rufus corrió a toda velocidad, con el saco de gallinas rebotando sobre su lomo. El granjero lo persiguió incansablemente, gritando “zorro no te los lleves” y agitando su bastón, pero Rufus era demasiado ágil, agotando su paciencia al granjero lanzó su bastón, pero este rebotó haciendo tropezar al granjero. Rufus que aprovechó la situación escapó del granjero.
""", options: []);

    daySelectionOnExit.options.add(MockData.getOption(
        id: "B",
        text: "Rufus sale por donde vino.",
        previousSectionId: daySelectionDescription.id,
        nextSectionId: exitFromWhereCome.id));

    nightSelectedOnExit.options.add(MockData.getOption(
        id: "A",
        text: "Rufus sale por donde vino.",
        previousSectionId: nightSelected.id,
        nextSectionId: exitFromWhereCome.id));

    //Exit from the door final
    final initFirstFinalDoor = Section(
        text:
            "Alertada la familia del granjero sale a recoger a los animales. Mientras Rufus ya lejos de la granja se esconde para darse un festín.",
        options: []);
    exitByTheDoor.options.add(MockData.getOption(
        id: "Continuar",
        text: "Continuar",
        previousSectionId: "",
        nextSectionId: initFirstFinalDoor.id));

    final doorFinalDescription = Section(
        text:
            "Al día siguiente Rufus decide partir al siguiente pueblo, dado que debido a su robo anterior la actitud hacia los zorros y los habitantes de los barrios bajos se ha vuelto intolerable.",
        options: []);
    initFirstFinalDoor.options.add(MockData.getOption(
        id: "Continuar",
        text: "Continuar",
        previousSectionId: exitByTheDoor.id,
        nextSectionId: doorFinalDescription.id));

    final doorConclusion = Section(
        text:
            "Con el tiempo, Rufus aprendió todo tipo de habilidades y se convirtió en el azote de cada pueblo que pasaba, dejándolos únicamente con la ropa que vestían. Escapando de los guardias que se encontraba en el camino y evitando zonas demasiado cercanas a la capital.",
        options: []);

    doorFinalDescription.options.add(MockData.getOption(
        id: "Continuar",
        text: "Continuar",
        previousSectionId: initFirstFinalDoor.id,
        nextSectionId: doorConclusion.id));

    final doorEndTale = Section(
        text:
            "Finalmente, después de muchos robos exitosos, Rufus decidió retirarse a una cueva cómoda en lo profundo del bosque. Allí, rodeado de su botín acumulado, vivió el resto de sus días como un zorro ladrón legendario, temido y admirado por igual en todo el país.",
        options: []);
    doorConclusion.options.add(MockData.getOption(
        id: "Continuar",
        text: "Continuar",
        previousSectionId: doorFinalDescription.id,
        nextSectionId: doorEndTale.id));
    doorEndTale.options.add(MockData.getOption(
        id: "Fin",
        text: "Fin",
        previousSectionId: doorConclusion.id,
        nextSectionId: "",
        isAEnd: true));

    // Exit from where he came
    final exitConclusion = Section(
        text:
            "Desde ese día, Rufus se convirtió en un verdadero azote para los granjeros ricos del pueblo. Cada noche, se escabullía en una granja diferente, al principio robó gallinas, huevos y cualquier otra cosa que pudiera llevarse, pero después empezó a entrar a sus casas robando joyas de mala calidad, dinero y semillas. Los granjeros intentaron todo tipo de trampas y artilugios para atraparlo, pero Rufus aprendía de cada robo y estudiaba a su próxima víctima con paciencia. Por lo cual, Rufus podía burlar con gran facilidad todo tipo de trampas.",
        options: []);
    exitFromWhereCome.options.add(MockData.getOption(
        id: "Continuar",
        text: "Continuar",
        previousSectionId: exitByTheDoor.id,
        nextSectionId: exitConclusion.id));

    final exitByDoorNextSelection = Section(
        text:
            "Lleno de si mismo, Rufus decide planear algo más grande. Habiendo asaltado prácticamente todas las casas del pueblo decide aventurarse en las zonas más ricas de la ciudad. Durante semanas observó escondido en los callejones a los transeúntes que caminaban pomposamente por las calles, con ojo avisor decide a su próxima víctima. Siguiendo a una joven dama acompañado de un caballero hasta su enorme mansión. Rufus, cautivado por la riqueza de este nuevo mundo, espera en las sombras a que se oculte el sol y caiga la noche. ¿Cómo debería proceder Rufus?",
        options: []);
    exitByDoorNextSelection.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_travesuras_de_rufus%2Fchapter_1%2Frufus_and_mansion.jpeg?alt=media&token=dff5c647-6bab-4fc7-acd0-ee6caa8b7b09";
    exitConclusion.options.add(MockData.getOption(
      id: "Continuar",
      text: "Continuar",
      previousSectionId: exitFromWhereCome.id,
      nextSectionId: exitByDoorNextSelection.id,
    ));

    final sneakBySurroundSelection = Section(
        text:
            "Habiendo entrado exitósamente en el terreno Rufus se esconde rápidamente atento a cualquier sonido. Sin darse cuenta de que esta siendo vigilado. ¿Qué debería hacer Rufus?",
        options: []);
    final sneakDirectly = Section(
        text:
            "Cuando Rufus escala la reja entra en una zona sin vigilancia. Envalentonado por su suerte continúa sin un plan en mente.",
        options: []);

    exitByDoorNextSelection.options = [
      MockData.getOption(
          id: "A",
          text:
              "Rufus rodea el lugar en busca de un punto por el cual escabullirse",
          previousSectionId: exitConclusion.id,
          nextSectionId: sneakBySurroundSelection.id),
      MockData.getOption(
          id: "B",
          text: "Rufus escala la reja y entra desde una esquina poco vigilada",
          previousSectionId: exitConclusion.id,
          nextSectionId: sneakDirectly.id),
    ];

    // Sneak options

    final waitToBegin = Section(
        text:
            "Cuando todas las luces y ruidos de la mansión amainan Rufus decide escabullirse por una ventana. Pero repentinamente una mano fría lo agarra firmemente del cuello previniendo cualquier resistencia mientras que otra lo golpea dejándolo inconsciente.",
        options: []);
    waitToBegin.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_travesuras_de_rufus%2Fchapter_1%2Frufus_captured.jpeg?alt=media&token=2a75fadc-aae4-4b94-837a-c10ee7fbdb73";

    //Here different paths are combined
    final directlyBegin = Section(
        text:
            "Rufus, habiendo sido alimentado en exceso por su orgullo y acostumbrado a la poca seguridad de las casas del pueblo, decide correr furtivamente hacia la mansión y escabullirse por la ventana. No obstante es descubierto por los sirvientes de la mansión provocando caos y alertando a los guardias. ¿Qué debería hacer Rufus?",
        options: []);

    sneakBySurroundSelection.options = [
      MockData.getOption(
          id: "A",
          text:
              "Rufus espera hasta que la actividad en la mansión pare por completo",
          previousSectionId: exitByDoorNextSelection.id,
          nextSectionId: waitToBegin.id),
      MockData.getOption(
          id: "B",
          text: "Rufus se adentra en la mansión.",
          previousSectionId: exitByDoorNextSelection.id,
          nextSectionId: directlyBegin.id),
    ];

    sneakDirectly.options.add(MockData.getOption(
        id: "Continuar",
        text: "Continuar",
        previousSectionId: exitByDoorNextSelection.id,
        nextSectionId: directlyBegin.id));

    //directlyBegin options

    final stealsSomethinAndRun = Section(
        text:
            "Rufus intenta agarrar las joyas en exposición en una mesa cerca suyo pero los sirvientes se interponen en su camino. Para cuando las joyas están a su alcance repentinamente una mano fría lo agarra firmemente del cuello previniendo cualquier resistencia mientras que otra lo golpea dejándolo inconsciente.",
        options: []);
    stealsSomethinAndRun.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_travesuras_de_rufus%2Fchapter_1%2Frufus_captured.jpeg?alt=media&token=2a75fadc-aae4-4b94-837a-c10ee7fbdb73";

    //Second Final
    final runAwayQuickly = Section(
        text:
            "Rufus, como si estuviera poseído obedece a sus instintos y corre dando todo lo que tiene, aunque intentan alcanzarlo. Rufus se crió huyendo y engañando a otros. Con esfuerzo y cubierto de sudor frío logró perderlos en los barrios bajos después de ser perseguido durante horas. Con la piel de gallina decide volver al pueblo y vivir una vida tranquila, prometiéndose a si mismo nunca volver a ponerse en peligro.",
        options: []);
    runAwayQuickly.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_travesuras_de_rufus%2Fchapter_1%2Frufus_working_farm_2.jpeg?alt=media&token=2a5800d1-e916-4f82-9021-1058b5c22e39";

    directlyBegin.options = [
      MockData.getOption(
          id: "A",
          text: "Arrebatar lo más valioso a su alcance y emprender la fuga.",
          previousSectionId: "",
          nextSectionId: stealsSomethinAndRun.id),
      MockData.getOption(
          id: "B",
          text: "Correr como alma que lleva el diablo.",
          previousSectionId: "",
          nextSectionId: runAwayQuickly.id),
    ];

    //Second final
    runAwayQuickly.options.add(MockData.getOption(
        id: "Fin",
        text: "Fin",
        previousSectionId: directlyBegin.id,
        nextSectionId: "",
        isAEnd: true));

    // Continue mansion Route
    final capturedIntroduction = Section(
        text:
            "Rufus despierta en una fría celda en la que afloraba un leve olor a podredumbre por el aire estancado. Frente a él, fuera de la celda, se encuentra con un hombre corpulento cuyo porte digno permite suponer que ocupa un cargo importante en la mansión.",
        options: []);

    waitToBegin.options.add(MockData.getOption(
        id: "Continuar",
        text: "Continuar",
        previousSectionId: sneakBySurroundSelection.id,
        nextSectionId: capturedIntroduction.id));
    stealsSomethinAndRun.options.add(MockData.getOption(
        id: "Continuar",
        text: "Continuar",
        previousSectionId: directlyBegin.id,
        nextSectionId: capturedIntroduction.id));

    //Captured Route

    final capturedRouteSelection = Section(
        text:
            "Aclarándose la garganta y adoptando un tono solemne Por el grave crimen de intentar robar y entrar sin autorización a la casa de un noble, la ley dicta que debería ser sentenciado a muerte. Sin embargo, gracias a la misericordia de la señora de esta casa, se le ha concedido el inusual privilegio de elegir su propia sentencia. ¿Cuál de las opciones que le ofreció el hombre debería escoger?",
        options: []);
    capturedIntroduction.options.add(MockData.getOption(
        id: "Continuar",
        text: "Continuar",
        previousSectionId: "",
        nextSectionId: capturedRouteSelection.id));

    // Punishment

    final punishmentBegin = Section(
        text:
            "Al escoger el castigo público, Rufus es llevado en burro por toda la ciudad bajo la mirada escrutante y reprochadora de sus habitantes. Llegaron a la plaza pública al mediodía donde fue atado durante horas hasta ser castigado.",
        options: []);

    final punishmentEnd = Section(
        text:
            "Tras el castigo, Rufus desairado y herido vuelve a su pueblo del cuál no volvió a salir viviendo en pacíficamente y enseñando a los más jóvenes sobre los peligros del mundo.",
        options: [
          MockData.getOption(
              id: "Fin",
              text: "Fin",
              previousSectionId: punishmentBegin.id,
              nextSectionId: "",
              isAEnd: true)
        ]);
    punishmentEnd.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_travesuras_de_rufus%2Fchapter_1%2Frufus_working_farm_1.jpeg?alt=media&token=59661222-93ab-4891-b6b4-33e9c2d4aede";

    punishmentBegin.options.add(MockData.getOption(
        id: "Continuar",
        text: "Continuar",
        previousSectionId: capturedRouteSelection.id,
        nextSectionId: punishmentEnd.id));

    // Pay with work

    final employmentBegin = Section(
        text:
            "Cuando Rufus eligió trabajar en la mansión el hombre se burló abiertamente y considerando que no aguantaría más de una semana lo contrató para realizar las tareas que nadie más quería hacer.",
        options: []);

    final employmentEnd = Section(
        text:
            "Con el paso del tiempo y con trabajo duro Rufus aprendió las dificultades de la vida y dejó de lado su pensamiento ingenuo. Ganándose el respeto y reconocimiento de los sirvientes de la mansión. Y llegando a considerarla como su hogar. 20 años después decidió quedarse para vivir sus días en paz enmendando sus crímenes pasados.",
        options: [
          MockData.getOption(
              id: "Fin",
              text: "Fin",
              previousSectionId: employmentBegin.id,
              nextSectionId: "",
              isAEnd: true)
        ]);
    employmentEnd.setImageUrl =
        "https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Flas_travesuras_de_rufus%2Fchapter_1%2Frufus_working_as_servant.jpeg?alt=media&token=e4f11ed9-fe11-4572-a53a-a7761fdd811b";

    employmentBegin.options.add(MockData.getOption(
        id: "Continuar",
        text: "Continuar",
        previousSectionId: capturedRouteSelection.id,
        nextSectionId: employmentEnd.id));

    capturedRouteSelection.options = [
      MockData.getOption(
          id: "A",
          text: "Ser castigado en la plaza pública",
          previousSectionId: capturedIntroduction.id,
          nextSectionId: punishmentBegin.id),
      MockData.getOption(
          id: "B",
          text: "Trabajar en la mansión durante 20 años como un sirviente.",
          previousSectionId: capturedIntroduction.id,
          nextSectionId: employmentBegin.id),
    ];

    return [
      initChapterSelection,
      firstDescription,
      secondDescription,
      secondSelection,
      daySelected,
      nightSelected,
      daySelectionDescription,
      daySelectionOnExit,
      nightSelectedOnExit,
      exitByTheDoor,
      exitFromWhereCome,
      initFirstFinalDoor,
      doorFinalDescription,
      doorConclusion,
      doorEndTale,
      exitConclusion,
      exitByDoorNextSelection,
      sneakBySurroundSelection,
      sneakDirectly,
      waitToBegin,
      directlyBegin,
      stealsSomethinAndRun,
      runAwayQuickly,
      capturedIntroduction,
      capturedRouteSelection,
      punishmentBegin,
      punishmentEnd,
      employmentBegin,
      employmentEnd
    ];
  }
}

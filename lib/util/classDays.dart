class ClassDays {
  List<String> classDaysAbrv = ["seg", "ter", "qua", "qui", "sex", "sab"];
  List<String> classDaysFull = [
    "Segunda Feira",
    "Terça Feira",
    "Quarta Feira",
    "Quinta Feira",
    "Sexta Feira",
    "Sábado"
  ];

  String convertDayAbrvToFull(String dayAbrv) {
    String dayFull = "";
    for (int i = 0; i < classDaysAbrv.length; i++) {
      if (classDaysAbrv[i] == dayAbrv) {
        return classDaysFull[i];
      }
    }
    return dayFull;
  }

  String convertDayFullToAbrv(String dayFull) {
    String dayAbrv = "";
    for (int i = 0; i < classDaysFull.length; i++) {
      if (classDaysFull[i] == dayFull) {
        return classDaysAbrv[i];
      }
    }
    return dayAbrv;
  }
}

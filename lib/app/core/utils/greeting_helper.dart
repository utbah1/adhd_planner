class GreetingHelper {

  GreetingHelper._();

  static String greeting() {

    final hour =
        DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return "Good Morning";
    }

    if (hour >= 12 && hour < 15) {
      return "Good Afternoon";
    }

    if (hour >= 15 && hour < 18) {
      return "Good Evening";
    }

    return "Good Night";
  }
}
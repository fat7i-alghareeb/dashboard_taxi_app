enum Flavor {
  stage,
  production,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.stage:
        return 'dashboardtaxi Stage';
      case Flavor.production:
        return 'dashboardtaxi';
    }
  }

}

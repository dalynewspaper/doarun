enum Flavor {
  DEV,
  BETA,
}

class F {
  static Flavor appFlavor;

  static String get title {
    switch (appFlavor) {
      case Flavor.DEV:
        return 'Doarun dev';
      case Flavor.BETA:
        return 'Doarun beta';
      default:
        return 'title';
    }
  }

}


class Utils {

  static String wapperResourcePath(String resourceName, {String root = 'assets', String path = 'images'}) {
    return '$root/$path/$resourceName';
  }

}
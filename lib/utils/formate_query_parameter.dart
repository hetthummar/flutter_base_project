class FormatQueryParameter {
  Map<String, dynamic> replaceSpace(Map<String, dynamic> queryParameters) {
    Map<String, String?> returnMap = {};

    queryParameters.forEach((String k, dynamic v) {
      String? newValue = v;
      if (newValue != null) {
        newValue = v.replaceAll(" ", "%20");
      }
      returnMap.putIfAbsent(k, () => newValue);
    });
    return returnMap;
  }
}

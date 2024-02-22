extension StringExt on String {
  bool equalsIgnoreCase(String other) {
    if (identical(this, other)) {
      return true;
    }
    return toLowerCase() == other.toLowerCase();
  }
}

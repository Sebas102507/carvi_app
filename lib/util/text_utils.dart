extension StringExtension on String {
  /// Check is a string is a valid url
  bool isValidUrl() {
    return isNotEmpty && Uri.parse(this).isAbsolute;
  }

  /// Check if a string is a valid email
  bool isEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }

  /// Check if a string is a valid phone
  bool isPhone() {
    return RegExp(r'^[0-9]*$').hasMatch(this);
  }

  /// Capitalizes the first character
  String capitalize() {
    if (this == '') return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Check contains without case sensitivity
  bool containsIgnoreCase(String secondString) {
    final original = this;
    return original.toLowerCase().contains(secondString.toLowerCase());
  }

  /// Removes diacritics (accents, dieresis,...)
  String withoutDiacritics() {
    const diacritics =
        'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    const nonDiacritics =
        'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

    return splitMapJoin('',
        onNonMatch: (char) => char.isNotEmpty && diacritics.contains(char)
            ? nonDiacritics[diacritics.indexOf(char)]
            : char);
  }
}

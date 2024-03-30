extension StringEX on String {
  String get removeSpecialCharacters => replaceAll(RegExp('[^A-Za-z0-9]'), '');

  String initialsName() {
    String result = "";
    List<String> words = split(" ");
    for (var element in words) {
      if (element.trim().isNotEmpty && result.length < 2) {
        result += element[0].trim();
      }
    }

    return result.trim().toUpperCase();
  }

  bool isNumeric() {
    if (isEmpty) return false;
    return double.tryParse(this) != null;
  }

  String capitalizeFirstLetter() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String capitalizeEachWord() {
    if (isEmpty) return this;
    List<String> words = split(' ');
    List<String> capitalizedWords = words.map((word) {
      if (word.isEmpty) return word;
      return "${word[0].toUpperCase()}${word.substring(1)}";
    }).toList();
    return capitalizedWords.join(' ');
  }
}

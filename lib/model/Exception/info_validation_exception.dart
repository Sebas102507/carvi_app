class InfoValidationException implements Exception{

  String message;

  InfoValidationException({
    required this.message
  });

  @override
  String toString() {
    return message;
  }

}
class BirthdayException implements Exception{

  String message;

  BirthdayException({
    required this.message
  });

  @override
  String toString() {
    return message;
  }

}
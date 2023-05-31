class WrongInputException implements Exception{

  String message;

  WrongInputException({
    required this.message
});

  @override
  String toString() {
    return message;
  }

}
class ExistingUserException implements Exception{

  String message;

  ExistingUserException({
    required this.message
  });

  @override
  String toString() {
    return message;
  }

}
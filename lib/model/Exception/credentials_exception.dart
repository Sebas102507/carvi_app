class CredentialsException implements Exception{

  String message;

  CredentialsException({
    required this.message
  });

  @override
  String toString() {
    return message;
  }

}
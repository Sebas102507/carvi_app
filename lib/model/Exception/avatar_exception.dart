class AvatarException implements Exception{

  String message;

  AvatarException({
    required this.message
  });

  @override
  String toString() {
    return message;
  }

}
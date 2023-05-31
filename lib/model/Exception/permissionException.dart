class PermissionException implements Exception{

  String message;

  PermissionException({
    required this.message
  });

  @override
  String toString() {
    return message;
  }

}
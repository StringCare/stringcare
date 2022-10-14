class NoConfigFoundException implements Exception {
  const NoConfigFoundException([this.message]);

  final String? message;

  @override
  String toString() {
    return message!;
  }
}

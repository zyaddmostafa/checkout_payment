abstract class Failure {
  final String errmessnage;

  Failure(this.errmessnage);
}

class ServerError extends Failure {
  ServerError(String errmessnage) : super(errmessnage);
}

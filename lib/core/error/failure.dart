abstract class Failure {
  final String errmessnage;

  Failure(this.errmessnage);
}

class ServerFailure extends Failure {
  ServerFailure({required String errmessnage}) : super(errmessnage);
}

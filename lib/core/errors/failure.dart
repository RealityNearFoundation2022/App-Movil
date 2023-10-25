import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(String string, {this.message});

  @override
  List<Object> get props => [message];
}

// Failures generales de la app
class ServerFailure extends Failure {
  const ServerFailure({message}) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure({message}) : super(message);
}

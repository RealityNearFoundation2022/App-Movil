import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure({this.message});

  @override
  List<Object> get props => [message];
}

// Failures generales de la app
class ServerFailure extends Failure {
  ServerFailure({message}) : super(message: message);
}

class CacheFailure extends Failure {
  CacheFailure({message}) : super(message: message);
}

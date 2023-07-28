import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class NetworkFailure extends Failure {}

class DataFormFailure extends Failure{
  final String message;

  DataFormFailure({required this.message});
}
import 'package:dartz/dartz.dart';
import 'package:reality_near/core/errors/exceptions.dart';
import 'package:reality_near/core/errors/failure.dart';
import 'package:reality_near/data/datasource/API/contacts_datasource.dart';
import 'package:reality_near/data/models/contactModel.dart';

class ContactRepository {
  final ContactRemoteDataSourceImpl contactRepo = ContactRemoteDataSourceImpl();

  Future<Either<Failure, bool>> addContact(String contactId) async {
    try {
      var response = await contactRepo.addContact(contactId);
      return response ? const Right(true) : const Left(ServerFailure(
        message: "Server Failure",
      ));
    } on ServerException {
      return const Left(ServerFailure(
        message: "Server Failure",
      ));
    }
  }

  Future<Either<Failure, bool>> acceptPendingContact(String contactId) async {
    try {
      var response = await contactRepo.acceptPendigRequest(contactId);
      return response ? const Right(true) : const Left(ServerFailure(
        message: "Server Failure",
      ));
    } on ServerException {
      return const Left(ServerFailure(
        message: "Server Failure",
      ));
    }
  }

  Future<Either<Failure, bool>> removeDeclineContact(String contactId) async {
    try {
      var response = await contactRepo.removeDeleteContacts(contactId);
      return response ? const Right(true) : const Left(ServerFailure(
        message: "Server Failure",
      ));
    } on ServerException {
      return const Left(ServerFailure(
        message: "Server Failure",
      ));
    }
  }

  Future<Either<Failure, List<ContactModel>>> getContacts() async {
    try {
      List<ContactModel> contacts = await contactRepo.getContacts();
      return Right(contacts);
    } on ServerException {
      return const Left(ServerFailure(
        message: "Server Failure",
      ));
    }
  }

  Future<Either<Failure, List<ContactModel>>> getPendingContacts() async {
    try {
      List<ContactModel> contacts = await contactRepo.getPendingContacts();
      return Right(contacts);
    } on ServerException {
      return const Left(ServerFailure(
        message: "Server Failure",
      ));
    }
  }
}

import 'package:driver_application/features/Profile/data/model/profits_response_model.dart';

abstract class ProfitsState {}

class ProfitsInitial extends ProfitsState {}

class ProfitsLoading extends ProfitsState {}

class ProfitsSuccess extends ProfitsState {
  final ProfitsResponseModel profitsModel;

  ProfitsSuccess(this.profitsModel);
}

class ProfitsFailure extends ProfitsState {
  final String errMessage;

  ProfitsFailure(this.errMessage);
}

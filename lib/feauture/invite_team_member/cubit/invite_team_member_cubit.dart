import 'package:ankh_project/domain/use_cases/markter_generate_code_use_case.dart';
import 'package:ankh_project/feauture/invite_team_member/cubit/invite_team_member_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../api_service/failure/error_handling.dart';

@injectable
class InviteTeamMemberCubit extends Cubit<InviteTeamMemberState> {
  final MarketerGenerateCodeUseCase marketerGenerateCodeUseCase;

  InviteTeamMemberCubit({
    required this.marketerGenerateCodeUseCase,
  }) : super(InviteTeamMemberInitial());

  Future<void> generateCodes(String token, int numberOfCodes) async {
    emit(InviteTeamMemberLoading());
    var either = await marketerGenerateCodeUseCase.execute(token, numberOfCodes);
    either.fold((error) {
      emit(InviteTeamMemberError(error: error));
    }, (response) {
      emit(InviteTeamMemberSuccess(
        generatedCodes: response,
        message: 'Codes generated successfully',
      ));
    });
  }
} 
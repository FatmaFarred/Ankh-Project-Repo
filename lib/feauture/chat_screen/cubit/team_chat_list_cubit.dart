import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../api_service/di/di.dart';
import '../../../../api_service/failure/error_handling.dart';
import '../../../../domain/entities/all_marketers_entity.dart';
import '../../../../domain/use_cases/get_team_member_use_case.dart';
import '../../authentication/user_controller/user_cubit.dart';
import '../team_chat_list_screen.dart';

part 'team_chat_list_states.dart';

@injectable
class TeamChatListCubit extends Cubit<TeamChatListState> {
  final GetTeamMemberUseCase getTeamMemberUseCase;

  TeamChatListCubit(this.getTeamMemberUseCase) : super(TeamChatListInitial());

  Future<void> loadTeamChats() async {
    emit(TeamChatListLoading());

    try {
      // Get current user
      final user = getIt<UserCubit>().state;

      if (user == null) {
        emit(TeamChatListFailure(errorMessage: "User not authenticated"));
        return;
      }

      // Determine the ID to use based on user role
      String? targetId;
      
      if (user.roles?.contains("LeaderMarketer") == true || 
          user.roles?.contains("Admin") == true) {
        // If user is team leader or admin, use their own ID
        targetId = user.id;
      } else if (user.teamLeaderId != null && user.teamLeaderId!.isNotEmpty) {
        // If user is marketer, use their team leader ID
        targetId = user.teamLeaderId;
      } else {
        // User has no team access
        emit(TeamChatListNoTeam());
        return;
      }

      // Get actual team members using the determined ID
      final either = await getTeamMemberUseCase.execute(targetId!);
      
      either.fold((failure) {
        emit(TeamChatListFailure(errorMessage: failure.errorMessage ?? "Failed to load team members"));
      }, (teamMembers) {
        if (teamMembers.isEmpty) {
          emit(TeamChatListEmpty());
        } else {
          // Convert team members to team chats
          final teamChats = _convertTeamMembersToTeamChats(teamMembers);
          emit(TeamChatListSuccess(teamChats: teamChats));
        }
      });
    } catch (e) {
      emit(TeamChatListFailure(errorMessage: e.toString()));
    }
  }

  List<TeamChat> _convertTeamMembersToTeamChats(List<AllMarketersEntity> teamMembers) {
    // Since we're already filtering by the correct team leader ID,
    // we can create a single team chat for all members
    if (teamMembers.isEmpty) {
      return [];
    }

    // Get the team leader (first member or the one with matching ID)
    final teamLeader = teamMembers.first;
    
    // Create a single team chat for this team
    final teamChat = TeamChat(
      id: teamLeader.teamLeader ?? teamLeader.id ?? "default_team_id",
      name: 'فريق ${teamLeader.code ?? "المسوقين"}',
      description: 'فريق التسويق',
      memberCount: teamMembers.length,
      messageCount: 0, // This would come from chat API
      lastMessage: null, // This would come from chat API
      lastMessageTime: null, // This would come from chat API
      teamMembers: teamMembers, // Store actual team members
    );

    return [teamChat];
  }
} 
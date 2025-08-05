part of 'team_chat_list_cubit.dart';

abstract class TeamChatListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TeamChatListInitial extends TeamChatListState {}

class TeamChatListLoading extends TeamChatListState {}

class TeamChatListSuccess extends TeamChatListState {
  final List<TeamChat> teamChats;

  TeamChatListSuccess({required this.teamChats});

  @override
  List<Object?> get props => [teamChats];
}

class TeamChatListEmpty extends TeamChatListState {}

class TeamChatListNoTeam extends TeamChatListState {}

class TeamChatListFailure extends TeamChatListState {
  final String errorMessage;

  TeamChatListFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
} 
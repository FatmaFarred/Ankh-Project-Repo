import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../api_service/failure/error_handling.dart';
import '../team_chat_list_screen.dart';

part 'team_chat_list_states.dart';

@injectable
class TeamChatListCubit extends Cubit<TeamChatListState> {
  TeamChatListCubit() : super(TeamChatListInitial());

  Future<void> loadTeamChats() async {
    emit(TeamChatListLoading());

    try {
      // Simulate API call - replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock data - replace with actual API response
      final teamChats = [
        TeamChat(
          id: '1',
          name: 'فريق التسويق الرئيسي',
          description: 'فريق التسويق الرئيسي للمنتجات والخدمات',
          memberCount: 8,
          messageCount: 156,
          lastMessage: 'تم إرسال التقرير الأسبوعي',
          lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        TeamChat(
          id: '2',
          name: 'فريق المبيعات',
          description: 'فريق المبيعات والعمليات التجارية',
          memberCount: 12,
          messageCount: 89,
          lastMessage: 'اجتماع غداً الساعة 10 صباحاً',
          lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
        ),
        TeamChat(
          id: '3',
          name: 'فريق الدعم الفني',
          description: 'فريق الدعم الفني وحل المشاكل',
          memberCount: 6,
          messageCount: 234,
          lastMessage: 'تم حل مشكلة العميل رقم 1234',
          lastMessageTime: DateTime.now().subtract(const Duration(minutes: 30)),
        ),
      ];

      if (teamChats.isEmpty) {
        emit(TeamChatListEmpty());
      } else {
        emit(TeamChatListSuccess(teamChats: teamChats));
      }
    } catch (e) {
      emit(TeamChatListFailure(errorMessage: e.toString()));
    }
  }
} 
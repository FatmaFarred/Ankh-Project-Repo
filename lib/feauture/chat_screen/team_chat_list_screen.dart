import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api_service/di/di.dart';
import '../../core/constants/color_manager.dart';
import '../../core/constants/assets_manager.dart';
import '../../l10n/app_localizations.dart';
import '../authentication/user_controller/user_cubit.dart';
import '../../domain/entities/all_marketers_entity.dart';
import '../home_screen/bottom_nav_bar.dart';
import 'chat_screen.dart';
import 'cubit/team_chat_list_cubit.dart';

class TeamChatListScreen extends StatefulWidget {
  static const String routeName = '/team_chat_list';
  final VoidCallback? onChatOpened;
  final VoidCallback? onNewMessage;
  
  const TeamChatListScreen({Key? key, this.onChatOpened, this.onNewMessage}) : super(key: key);

  @override
  _TeamChatListScreenState createState() => _TeamChatListScreenState();
}

class _TeamChatListScreenState extends State<TeamChatListScreen> {
  @override
  void initState() {
    super.initState();
    // Load team chats when screen initializes
    context.read<TeamChatListCubit>().loadTeamChats();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onChatOpened?.call();
    });
  }

  // Example: Call this when a new message arrives and the screen is not open
  void notifyNewMessage() {
    widget.onNewMessage?.call();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final user = context.watch<UserCubit>().state;
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          l10n.teamChat,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorManager.lightprimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () =>   Navigator.pushReplacementNamed(context, BottomNavBar.bottomNavBarRouteName),

        ),
      ),
      body: BlocBuilder<TeamChatListCubit, TeamChatListState>(
        builder: (context, state) {
          if (state is TeamChatListLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: ColorManager.lightprimary,
              ),
            );
          } else if (state is TeamChatListSuccess) {
            return _buildTeamChatsList(state.teamChats, user);
          } else if (state is TeamChatListEmpty) {
            return _buildEmptyState(l10n);
          } else if (state is TeamChatListNoTeam) {
            return _buildNoTeamState(l10n);
          } else if (state is TeamChatListFailure) {
            return _buildErrorState(state.errorMessage, l10n);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildTeamChatsList(List<TeamChat> teamChats, user) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<TeamChatListCubit>().loadTeamChats();
      },
      color: ColorManager.lightprimary,
      child: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: teamChats.length,
        itemBuilder: (context, index) {
          final teamChat = teamChats[index];
          return _buildTeamChatCard(teamChat, user);
        },
      ),
    );
  }

  Widget _buildTeamChatCard(TeamChat teamChat, user) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.w),
        leading: CircleAvatar(
          radius: 25.r,
          backgroundColor: ColorManager.lightprimary,
          child: Icon(
            Icons.group,
            color: Colors.white,
            size: 24.sp,
          ),
        ),
        title: Text(
          teamChat.name,
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: ColorManager.textColor,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4.h),
            Text(
              teamChat.description,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(
                  Icons.people,
                  size: 16.sp,
                  color: Colors.grey[500],
                ),
                SizedBox(width: 4.w),
                Text(
                  '${teamChat.memberCount} ${AppLocalizations.of(context)!.members}',
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: Colors.grey[500],
                  ),
                ),
                SizedBox(width: 16.w),
                Icon(
                  Icons.message,
                  size: 16.sp,
                  color: Colors.grey[500],
                ),
                SizedBox(width: 4.w),
                Text(
                  '${teamChat.messageCount} ${AppLocalizations.of(context)!.message}',
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey[400],
          size: 16.sp,
        ),
        onTap: () {
          _navigateToTeamChat(teamChat);
        },
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.group_outlined,
            size: 80.sp,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16.h),
          Text(
            l10n.noTeamChatsFound,
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            l10n.noTeamChatsDescription,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () {
              context.read<TeamChatListCubit>().loadTeamChats();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.lightprimary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(l10n.refresh),
          ),
        ],
      ),
    );
  }

  Widget _buildNoTeamState(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.group_remove,
            size: 80.sp,
            color: Colors.orange[400],
          ),
          SizedBox(height: 16.h),
          Text(
            l10n.noTeamToChat,
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.orange[600],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            l10n.noTeamToChatDescription,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, BottomNavBar.bottomNavBarRouteName);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.lightprimary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(l10n.goBack),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String errorMessage, AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80.sp,
            color: Colors.red[400],
          ),
          SizedBox(height: 16.h),
          Text(
            l10n.error,
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.red[600],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            errorMessage,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () {
              context.read<TeamChatListCubit>().loadTeamChats();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.lightprimary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(l10n.tryAgain),
          ),
        ],
      ),
    );
  }

  void _navigateToTeamChat(TeamChat teamChat) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeamChatScreen(),
      ),
    );
  }
}

// Team Chat Model
class TeamChat {
  final String id;
  final String name;
  final String description;
  final int memberCount;
  final int messageCount;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final bool isActive;
  final List<AllMarketersEntity>? teamMembers;

  TeamChat({
    required this.id,
    required this.name,
    required this.description,
    required this.memberCount,
    required this.messageCount,
    this.lastMessage,
    this.lastMessageTime,
    this.isActive = true,
    this.teamMembers,
  });

  factory TeamChat.fromJson(Map<String, dynamic> json) {
    return TeamChat(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      memberCount: json['memberCount'] ?? 0,
      messageCount: json['messageCount'] ?? 0,
      lastMessage: json['lastMessage'],
      lastMessageTime: json['lastMessageTime'] != null 
          ? DateTime.tryParse(json['lastMessageTime']) 
          : null,
      isActive: json['isActive'] ?? true,
      teamMembers: null, // This would be populated from API
    );
  }
} 
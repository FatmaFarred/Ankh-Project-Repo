// chat_screen.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api_service/api_constants.dart';
import '../../core/constants/color_manager.dart';
import '../../core/customized_widgets/shared_preferences .dart';
import '../../l10n/app_localizations.dart';
import '../authentication/user_controller/user_cubit.dart';
import 'team_chat_list_screen.dart';

class TeamChatScreen extends StatefulWidget {
  static const String routeName = '/team_chat';
  final TeamChat? teamChat;
  
  const TeamChatScreen({Key? key, this.teamChat}) : super(key: key);
  
  @override
  _TeamChatScreenState createState() => _TeamChatScreenState();
}

class _TeamChatScreenState extends State<TeamChatScreen> {
  final TextEditingController _roomController = TextEditingController(text: "78874d63-f8dc-497b-9b92-a6a0ec5bf01b");
  final TextEditingController _messageController = TextEditingController();
  String? token;
  String? name;
  String? userId;
  bool _isConnecting = false;
  bool _isConnected = false;
  String _statusText = "غير متصل";
  Color _statusColor = Colors.red;
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    await _loadUserData();
    _attemptAutoConnection();
  }

  Future<void> _loadUserData() async {
    final fetchedToken = await SharedPrefsManager.getData(key: 'user_token');
    final user = context.read<UserCubit>().state;
    final currentUserId = user?.id;
    final userRoles = user?.roles;
    final userName = user?.fullName ?? "مسوق";

    setState(() {
      token = fetchedToken;
      userId = currentUserId;
      name= userName ;
    });

    print("👤 User token: $token");
    print("👤 User ID: $userId");
    print("👤 User roles: $userRoles");

    // Check if user is a team leader
    final isTeamLeader = userRoles?.contains("LeaderMarketer") == true ||
                        userRoles?.contains("Admin") == true;

    if (isTeamLeader && currentUserId != null) {
      // Auto-fill room ID with team leader's ID
      _roomController.text = currentUserId;
      print("👑 User is team leader, auto-filled room ID: $currentUserId");
    }
  }

  void _attemptAutoConnection() {
    if (token != null && _roomController.text.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 500), () {
        _connect();
      });
    }
  }

  String _getUserRoleDisplay() {
    final user = context.read<UserCubit>().state;
    final userRoles = user?.roles;

    if (userRoles?.contains("LeaderMarketer") == true) {
      return "قائد الفريق";
    } else if (userRoles?.contains("Admin") == true) {
      return "مدير النظام";
    } else if (userRoles?.contains("Marketer") == true) {
      return "مسوق";
    } else {
      return "عضو";
    }
  }

  bool _isTeamLeader() {
    final user = context.read<UserCubit>().state;
    final userRoles = user?.roles;
    return userRoles?.contains("LeaderMarketer") == true ||
           userRoles?.contains("Admin") == true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
          "شات فريق العمل",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor:  ColorManager.lightprimary,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Connection Status Card
          _buildConnectionStatusCard(),
          
          // Chat Messages
          Expanded(
            child: _buildChatMessages(),
          ),
          
          // Message Input
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildConnectionStatusCard() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
        child: Column(
          children: [
          // Status Row
          Row(
            children: [
            Container(
                width: 12,
                height: 12,
              decoration: BoxDecoration(
                  color: _statusColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
              child: Text(
                _statusText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                    color: _statusColor,
                  ),
                ),
              ),
              if (_isConnecting)
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
              if (_isConnected) ...[
                SizedBox(width: 8),
                IconButton(
                  onPressed: _refreshMessages,
                  icon: Icon(Icons.refresh, color: Colors.blue),
                  tooltip: "تحديث الرسائل",
                ),
              ],
            ],
          ),
          
          SizedBox(height: 12),
          
          // User Info
          Row(
            children: [
              CircleAvatar(
                backgroundColor: ColorManager.lightprimary,
                child: Icon(Icons.person, color: Colors.white),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name??"",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          if (!_isConnected) ...[
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _roomController,
                    decoration: InputDecoration(
                      labelText: "معرف الفريق",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: Icon(Icons.group),
                    ),
                    enabled: !_isConnecting,
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _isConnecting ? null : _connect,
                    style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2196F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("اتصال"),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildChatMessages() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: _messages.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildMessageBubble(msg);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            "لا توجد رسائل بعد",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "ابدأ المحادثة مع فريقك",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final isSent = message.type == MessageType.sent;
    final isSystem = message.type == MessageType.system;
    final isError = message.type == MessageType.error;

    if (isSystem || isError) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isError ? Colors.red[50] : Colors.blue[50],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          message.message,
          style: TextStyle(
            color: isError ? Colors.red[700] : Colors.blue[700],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSent) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor:  ColorManager.lightprimary,
              child: Text(
                message.senderName?.substring(0, 1).toUpperCase() ?? "U",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isSent ?  ColorManager.lightprimary : Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isSent)
                    Text(
                      message.senderName ?? "عضو",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  SizedBox(height: 4),
                  Text(
                    message.message,
                    style: TextStyle(
                      color: isSent ? Colors.white : Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    _formatTime(message.timestamp),
                    style: TextStyle(
                      fontSize: 10,
                      color: isSent ? Colors.white70 : Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isSent) ...[
            SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, size: 16, color: Colors.grey[600]),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "اكتب رسالتك...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              enabled: _isConnected,
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: _isConnected ?  ColorManager.lightprimary: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: _isConnected ? _sendMessage : null,
              icon: Icon(
                Icons.send,
                color: Colors.white,
              ),
              ),
            ),
          ],
      ),
    );
  }

  String _formatTime(DateTime dt) {
    return "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
  }

  void _connect() async {
    final token = this.token;
    final room = _roomController.text.trim();

    if (token == null || room.isEmpty) {
      _showCustomErrorDialog("خطأ في البيانات", "الرجاء التأكد من توفر رمز التفويض ومعرف الفريق");
      return;
    }

    // Prevent multiple connection attempts
    if (_isConnecting || _isConnected) {
      return;
    }

    setState(() {
      _isConnecting = true;
      _statusText = "جاري الاتصال...";
      _statusColor = Colors.orange;
    });

    try {
      await ChatClient.instance.connect(
        token: token,
        room: room,
        onMessage: (msg) {
          if (mounted) {
      setState(() {
        _messages.add(msg);
      });
            _scrollToBottom();
          }
        },
        onSystemMessage: (text) {
          if (mounted) {
      setState(() {
        _messages.add(ChatMessage.system(text));
      });
            _scrollToBottom();
          }
        },
        onConnected: () {
          if (mounted) {
      setState(() {
        _isConnected = true;
              _isConnecting = false;
        _statusText = "متصل";
        _statusColor = Colors.green;
      });
          }
        },
        onDisconnected: (err) {
          if (mounted) {
      setState(() {
        _isConnected = false;
              _isConnecting = false;
        _statusText = "غير متصل";
        _statusColor = Colors.red;
        if (err != null) {
                _messages.add(ChatMessage.error("خطأ في الاتصال: $err"));
              }
            });
            _scrollToBottom();
          }
        },
      );
    } catch (e) {
      if (mounted) {
    setState(() {
      _isConnected = false;
          _isConnecting = false;
          _statusText = "فشل الاتصال";
          _statusColor = Colors.red;
          _messages.add(ChatMessage.error("خطأ في الاتصال: $e"));
        });

        String errorMessage = "فشل الاتصال بالخادم";
        if (e.toString().contains("Connection refused")) {
          errorMessage = "لا يمكن الاتصال بالخادم. تأكد من أن الخادم يعمل";
        } else if (e.toString().contains("timeout")) {
          errorMessage = "انتهت مهلة الاتصال. تحقق من اتصال الإنترنت";
        } else if (e.toString().contains("401") || e.toString().contains("403")) {
          errorMessage = "رمز التفويض غير صالح. يرجى إعادة تسجيل الدخول";
        }

        _showCustomErrorDialog("خطأ في الاتصال", errorMessage);
      }
    }
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    ChatClient.instance.sendMessage(message);
    _messageController.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showCustomErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(Icons.error, color: Colors.red),
            SizedBox(width: 8),
            Text(title),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("إلغاء"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _connect();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2196F3),
            ),
            child: Text("إعادة المحاولة"),
          ),
        ],
      ),
    );
  }

  void _disconnect() {
    setState(() {
      _isConnected = false;
      _isConnecting = false;
      _statusText = "غير متصل";
      _statusColor = Colors.red;
      _messages.clear();
    });
    
    ChatClient.instance.disconnect();
  }

  @override
  void dispose() {
    _roomController.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    
    // Clean up connection when screen is disposed
    ChatClient.instance.disconnect();
    
    super.dispose();
  }

  void _refreshMessages() {
    ChatClient.instance.loadRecentMessages();
  }
}

class ChatClient {
  static final ChatClient _instance = ChatClient._internal();
  factory ChatClient() => _instance;
  static ChatClient get instance => _instance;
  ChatClient._internal();

  HubConnection? _hubConnection;
  String? _currentRoom;
  String? _userId;
  bool _isLeader = false;
  bool _isReconnecting = false;
  bool _isConnected = false;
  bool _listenersSetup = false;

  // Configurable base URL - should be set based on environment
  static const String _baseUrl = String.fromEnvironment(
    'SIGNALR_URL',
    defaultValue: 'https://ankhapi.runasp.net/hubs/teamchat'
  );

  // Callbacks
  Function(ChatMessage)? onMessage;
  Function(String)? onSystemMessage;
  VoidCallback? onConnected;
  Function(String?)? onDisconnected;

  Future<void> connect({
    required String token,
    required String room,
    required Function(ChatMessage) onMessage,
    required Function(String) onSystemMessage,
    required VoidCallback onConnected,
    required Function(String?) onDisconnected,
  }) async {
    // Prevent multiple connections
    if (_isConnected || _isReconnecting) {
      return;
    }

    this.onMessage = onMessage;
    this.onSystemMessage = onSystemMessage;
    this.onConnected = onConnected;
    this.onDisconnected = onDisconnected;

    try {
      // Clean up any existing connection
      await _cleanupConnection();

      // Create new connection
    _hubConnection = HubConnectionBuilder()
        .withUrl(
        _baseUrl,
      HttpConnectionOptions(
        accessTokenFactory: () async => token,
          skipNegotiation: false,
          transport: HttpTransportType.webSockets,
      ),
    )
          .withAutomaticReconnect([0, 2000, 5000, 10000, 30000])
        .build();

      // Decode JWT to get user ID and role
    final claims = _parseJwt(token);
    _userId = claims['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'];
    final role = claims['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];
    _isLeader = role == "LeaderMarketer" || role == "Admin" ||
        (role is List && (role.contains("LeaderMarketer") || role.contains("Admin")));

      // Set up event listeners only once
      if (!_listenersSetup) {
        _setupEventListeners();
        _listenersSetup = true;
      }

      // Start connection
      await _hubConnection!.start();
      _isConnected = true;
      onSystemMessage?.call("تم الاتصال بالخادم بنجاح");

      _currentRoom = room;
      
      // Try to join team room (optional - may not exist on server yet)
      try {
      await _hubConnection!.invoke("JoinTeamRoom", args: [room]);
        //onSystemMessage?.call("انضم عضو الي الفريق");
      } catch (e) {
        onSystemMessage?.call("");
      }
      
      onConnected?.call();
      
      // Try to load recent messages after connection (optional)
      Future.delayed(Duration(seconds: 2), () {
        try {
          loadRecentMessages();
        } catch (e) {
          // Silent error
        }
      });
      
    } catch (e) {
      _isConnected = false;
      onSystemMessage?.call("خطأ في الاتصال: $e");
      onDisconnected?.call(e.toString());
      throw e;
    }
  }

  Future<void> _cleanupConnection() async {
    if (_hubConnection != null) {
      try {
        if (_currentRoom != null) {
          // Try to leave team room (optional - may not exist on server yet)
          try {
           // await _hubConnection!.invoke("LeaveTeamRoom", args: [_currentRoom!]);
          } catch (e) {
            // Silent error
          }
        }
        await _hubConnection!.stop();
      } catch (e) {
        // Silent error
      }
      _hubConnection = null;
      _isConnected = false;
      _currentRoom = null;
    }
  }

  void _setupEventListeners() {
    if (_hubConnection == null) return;

    // Remove any existing listeners to prevent duplicates
    _hubConnection!.off("ReceiveMessage");
    _hubConnection!.off("LoadRecentMessages");
    _hubConnection!.off("ReceiveSystemMessage");

    // Listen to messages
    _hubConnection!.on("ReceiveMessage", (args) {
      _onReceiveMessage(args);
    });
    
    _hubConnection!.on("LoadRecentMessages", (args) {
      _onLoadRecentMessages(args);
    });
    
    _hubConnection!.on("ReceiveSystemMessage", (args) {
      onSystemMessage?.call(args?[0] ?? "رسالة من النظام");
    });

    // Handle connection close
    _hubConnection!.onclose((error) {
      _isConnected = false;
      if (!_isReconnecting) {
        onDisconnected?.call(error?.toString() ?? "تم قطع الاتصال");
      }
    });

    // Handle reconnection
    _hubConnection!.onreconnecting((error) {
      _isReconnecting = true;
      _isConnected = false;
      onSystemMessage?.call("إعادة الاتصال...");
    });

    _hubConnection!.onreconnected((connectionId) {
      _isReconnecting = false;
      _isConnected = true;
      onSystemMessage?.call("تم إعادة الاتصال بنجاح");
      onConnected?.call();
    });
  }

  void _onReceiveMessage(List<Object?>? args) {
    if (args == null || args.length < 1) {
      return;
    }

    try {
    final data = args[0] as Map;
    final isMyMessage = data["senderId"] == _userId;
    final type = isMyMessage ? MessageType.sent : MessageType.received;

    final message = ChatMessage(
        message: data["message"] ?? "",
        senderName: data["senderName"] ?? "عضو",
        timestamp: DateTime.tryParse(data["sentAt"] ?? "") ?? DateTime.now(),
      type: type,
    );

    onMessage?.call(message);
    } catch (e) {
      onSystemMessage?.call("خطأ في معالجة الرسالة: $e");
      
      // Fallback: create a simple message from the raw data
      try {
        final fallbackMessage = ChatMessage(
          message: args.toString(),
          senderName: "خادم",
          timestamp: DateTime.now(),
          type: MessageType.received,
        );
        onMessage?.call(fallbackMessage);
      } catch (fallbackError) {
        // Silent fallback error
      }
    }
  }

  void _onLoadRecentMessages(List<Object?>? args) {
    if (args == null || args.isEmpty) {
      return;
    }
    
    try {
    final List messages = args[0] as List;
      
      if (messages.isNotEmpty) {
        onSystemMessage?.call("تم تحميل ${messages.length} رسالة سابقة");
      }
      
    messages.reversed.forEach((msg) {
        try {
      final data = msg as Map;
      final isMyMessage = data["senderId"] == _userId;
      final type = isMyMessage ? MessageType.sent : MessageType.received;

      final message = ChatMessage(
            message: data["message"] ?? "",
            senderName: data["senderName"] ?? "عضو",
            timestamp: DateTime.tryParse(data["sentAt"] ?? "") ?? DateTime.now(),
        type: type,
      );
          
      onMessage?.call(message);
        } catch (e) {
          // Silent error for individual message processing
        }
    });
    } catch (e) {
      onSystemMessage?.call("خطأ في تحميل الرسائل السابقة: $e");
    }
  }

  Future<void> sendMessage(String message) async {
    if (_hubConnection == null || _currentRoom == null || !_isConnected) {
      onSystemMessage?.call("غير متصل بالخادم");
      return;
    }
    
    try {
      await _hubConnection!.invoke("SendMessageToTeam", args: [_currentRoom!, message]);
    } catch (e) {
      onSystemMessage?.call("فشل في ارسال : محتوى غير مدعوم");
    }
  }

  Future<void> loadRecentMessages() async  {
    if (_hubConnection == null || _currentRoom == null || !_isConnected) {
      onSystemMessage?.call("غير متصل بالخادم أو لا يوجد فريق محدد");
      return;
    }

    try {
      // Try to invoke LoadRecentMessages method (optional - may not exist on server)
      await _hubConnection!.invoke("LoadRecentMessages", args: [_currentRoom!]);
      onSystemMessage?.call("تم طلب تحميل الرسائل السابقة");
    } catch (e) {
      // Don't show error message since messages are loaded via events
    }
  }

  Future<void> disconnect() async {
    _isConnected = false;
    _isReconnecting = false;
    _listenersSetup = false;
    
    await _cleanupConnection();
    
    // Clear callbacks
    onMessage = null;
    onSystemMessage = null;
    onConnected = null;
    onDisconnected = null;
  }

  // Simple JWT parser with better error handling
  Map<String, dynamic> _parseJwt(String token) {
    try {
    final parts = token.split(".");
      if (parts.length != 3) throw Exception("Invalid token format");

    final payload = parts[1];
    final normalized = base64Url.normalize(payload);
    final decoded = utf8.decode(base64Url.decode(normalized));
    return json.decode(decoded);
    } catch (e) {
      throw Exception("Failed to parse JWT token: $e");
    }
  }
}

// chat_message.dart
enum MessageType { sent, received, system, error }

class ChatMessage {
  final String message;
  final String? senderName;
  final DateTime timestamp;
  final MessageType type;

  ChatMessage({
    required this.message,
    this.senderName,
    required this.timestamp,
    required this.type,
  });

  factory ChatMessage.system(String text) {
    return ChatMessage(
      message: text,
      timestamp: DateTime.now(),
      type: MessageType.system,
    );
  }

  factory ChatMessage.error(String text) {
    return ChatMessage(
      message: text,
      timestamp: DateTime.now(),
      type: MessageType.error,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:ankh_project/core/constants/color_manager.dart';

class NotificationHistoryScreen extends StatefulWidget {
  static const String routeName = '/notification-history';

  @override
  _NotificationHistoryScreenState createState() => _NotificationHistoryScreenState();
}

class _NotificationHistoryScreenState extends State<NotificationHistoryScreen> {
  String selectedFilter = 'All';
  final TextEditingController _searchController = TextEditingController();
  
  // Mock data - in real app this would come from API
  final List<Map<String, dynamic>> notificationHistory = [
    {
      'id': '1',
      'title': 'رصيد المحفظة منخفض',
      'message': 'رصيد محفظتك منخفض. يرجى إعادة الشحن للاستمرار في قبول الفحوصات.',
      'recipient': 'أحمد محمد',
      'recipientType': 'Marketer',
      'status': 'sent',
      'timestamp': DateTime.now().subtract(Duration(hours: 2)),
    },
    {
      'id': '2',
      'title': 'تم تعيين فحص جديد',
      'message': 'تم تعيين فحص جديد لك. تحقق من جدولك الآن.',
      'recipient': 'فاطمة علي',
      'recipientType': 'Inspector',
      'status': 'sent',
      'timestamp': DateTime.now().subtract(Duration(hours: 5)),
    },
    {
      'id': '3',
      'title': 'تحديث مهم',
      'message': 'هناك تحديث مهم في التطبيق. يرجى التحقق من التحديثات الجديدة.',
      'recipient': 'محمد حسن',
      'recipientType': 'Marketer',
      'status': 'failed',
      'timestamp': DateTime.now().subtract(Duration(days: 1)),
    },
    {
      'id': '4',
      'title': 'تذكير بالفحص',
      'message': 'تذكير: لديك فحص مجدول اليوم. تأكد من الاستعداد.',
      'recipient': 'سارة أحمد',
      'recipientType': 'Inspector',
      'status': 'sent',
      'timestamp': DateTime.now().subtract(Duration(days: 2)),
    },
  ];

  List<Map<String, dynamic>> get filteredNotifications {
    List<Map<String, dynamic>> filtered = notificationHistory;
    
    // Filter by status
    if (selectedFilter != 'All') {
      filtered = filtered.where((notification) {
        if (selectedFilter == 'Sent') return notification['status'] == 'sent';
        if (selectedFilter == 'Failed') return notification['status'] == 'failed';
        if (selectedFilter == 'Marketers') return notification['recipientType'] == 'Marketer';
        if (selectedFilter == 'Inspectors') return notification['recipientType'] == 'Inspector';
        return true;
      }).toList();
    }
    
    // Filter by search
    if (_searchController.text.isNotEmpty) {
      final searchTerm = _searchController.text.toLowerCase();
      filtered = filtered.where((notification) {
        return notification['title'].toString().toLowerCase().contains(searchTerm) ||
               notification['message'].toString().toLowerCase().contains(searchTerm) ||
               notification['recipient'].toString().toLowerCase().contains(searchTerm);
      }).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('سجل الإشعارات'),
        backgroundColor: ColorManager.lightprimary,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Column(
        children: [
          // Search and Filter Section
          _buildSearchAndFilterSection(),
          
          // Statistics Cards
          _buildStatisticsSection(),
          
          // Notifications List
          Expanded(
            child: _buildNotificationsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilterSection() {
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
          // Search Bar
          TextField(
            controller: _searchController,
            onChanged: (value) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'البحث في الإشعارات...',
              prefixIcon: Icon(Icons.search, color: ColorManager.lightprimary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: ColorManager.lightprimary),
              ),
              filled: true,
              fillColor: Colors.grey[50],
            ),
          ),
          
          SizedBox(height: 16),
          
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('All', 'الكل'),
                SizedBox(width: 8),
                _buildFilterChip('Sent', 'مرسل'),
                SizedBox(width: 8),
                _buildFilterChip('Failed', 'فشل'),
                SizedBox(width: 8),
                _buildFilterChip('Marketers', 'مسوقين'),
                SizedBox(width: 8),
                _buildFilterChip('Inspectors', 'مفتشين'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String value, String label) {
    final isSelected = selectedFilter == value;
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          selectedFilter = value;
        });
      },
      backgroundColor: Colors.grey[200],
      selectedColor: ColorManager.lightprimary,
      checkmarkColor: Colors.white,
      side: BorderSide(
        color: isSelected ? ColorManager.lightprimary : Colors.grey[300]!,
      ),
    );
  }

  Widget _buildStatisticsSection() {
    final totalSent = notificationHistory.where((n) => n['status'] == 'sent').length;
    final totalFailed = notificationHistory.where((n) => n['status'] == 'failed').length;
    final totalMarketers = notificationHistory.where((n) => n['recipientType'] == 'Marketer').length;
    final totalInspectors = notificationHistory.where((n) => n['recipientType'] == 'Inspector').length;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'مرسل',
              totalSent.toString(),
              Icons.check_circle,
              Colors.green,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: _buildStatCard(
              'فشل',
              totalFailed.toString(),
              Icons.error,
              Colors.red,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: _buildStatCard(
              'مسوقين',
              totalMarketers.toString(),
              Icons.person,
              Colors.blue,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: _buildStatCard(
              'مفتشين',
              totalInspectors.toString(),
              Icons.visibility,
              Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList() {
    final notifications = filteredNotifications;
    
    if (notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none,
              size: 64,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              'لا توجد إشعارات',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'لم يتم العثور على إشعارات تطابق معايير البحث',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return _buildNotificationCard(notification);
      },
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    final isSent = notification['status'] == 'sent';
    final isMarketer = notification['recipientType'] == 'Marketer';
    
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isMarketer ? Colors.blue[100] : Colors.orange[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isMarketer ? 'مسوق' : 'مفتش',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isMarketer ? Colors.blue[700] : Colors.orange[700],
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isSent ? Colors.green[100] : Colors.red[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isSent ? Icons.check_circle : Icons.error,
                        size: 14,
                        color: isSent ? Colors.green[700] : Colors.red[700],
                      ),
                      SizedBox(width: 4),
                      Text(
                        isSent ? 'مرسل' : 'فشل',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isSent ? Colors.green[700] : Colors.red[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 12),
            
            // Title
            Text(
              notification['title'],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            
            SizedBox(height: 8),
            
            // Message
            Text(
              notification['message'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            SizedBox(height: 12),
            
            // Footer
            Row(
              children: [
                Icon(Icons.person, size: 16, color: Colors.grey[500]),
                SizedBox(width: 4),
                Text(
                  notification['recipient'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
                Spacer(),
                Icon(Icons.access_time, size: 16, color: Colors.grey[500]),
                SizedBox(width: 4),
                Text(
                  _formatTimestamp(notification['timestamp']),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inDays > 0) {
      return 'منذ ${difference.inDays} يوم';
    } else if (difference.inHours > 0) {
      return 'منذ ${difference.inHours} ساعة';
    } else if (difference.inMinutes > 0) {
      return 'منذ ${difference.inMinutes} دقيقة';
    } else {
      return 'الآن';
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
} 
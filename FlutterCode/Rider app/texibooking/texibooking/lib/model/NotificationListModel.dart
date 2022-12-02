class NotificationListModel {
  int? allUnreadCount;
  List<NotificationData>? notificationData;

  NotificationListModel({this.allUnreadCount, this.notificationData});

  factory NotificationListModel.fromJson(Map<String, dynamic> json) {
    return NotificationListModel(
      allUnreadCount: json['all_unread_count'],
      notificationData: json['notification_data'] != null ? (json['notification_data'] as List).map((i) => NotificationData.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['all_unread_count'] = this.allUnreadCount;
    if (this.notificationData != null) {
      data['notification_data'] = this.notificationData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  NotificationOrderData? data;
  String? createdAt;
  String? id;
  String? readAt;

  NotificationData({this.data, this.createdAt, this.id, this.readAt});

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      data: json['data'] != null ? NotificationOrderData.fromJson(json['data']) : null,
      createdAt: json['created_at'],
      id: json['id'],
      readAt: json['read_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['read_at'] = this.readAt;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class NotificationOrderData {
  int? id;
  String? message;
  String? subject;
  String? type;

  NotificationOrderData({this.id, this.message, this.subject, this.type});

  factory NotificationOrderData.fromJson(Map<String, dynamic> json) {
    return NotificationOrderData(
      id: json['id'],
      message: json['message'],
      subject: json['subject'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['subject'] = this.subject;
    data['type'] = this.type;
    return data;
  }
}

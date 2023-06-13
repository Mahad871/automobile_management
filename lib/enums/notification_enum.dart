enum NotificationType {
  message('message'),
  search('search'),
  offer('offer');

  const NotificationType(this.json);
  final String json;
}

class NotificationTypeConvertor {
  static NotificationType toEnum(String type) {
    switch (type) {
      case 'message':
        return NotificationType.message;
      case 'search':
        return NotificationType.search;
      case 'offer':
        return NotificationType.offer;
      default:
        return NotificationType.message;
    }
  }
}

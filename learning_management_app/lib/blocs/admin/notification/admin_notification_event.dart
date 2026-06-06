abstract class AdminNotificationEvent {
  const AdminNotificationEvent();
}

class AdminNotificationFetchAll extends AdminNotificationEvent {
  const AdminNotificationFetchAll();
}

class AdminNotificationCreate extends AdminNotificationEvent {
  final Map<String, dynamic> request;
  const AdminNotificationCreate(this.request);
}

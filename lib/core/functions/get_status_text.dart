String getStatusText(String status) {
  switch (status) {
    case 'accepted':
      return 'مقبول';
    case 'scheduled':
      return 'مجدول';
    case 'heading_to_pickup':
      return 'في الطريق إلى موقع التحميل';
    case 'in_transit':
      return 'جاري التوصيل';
    case 'completed':
      return 'مكتمل';
    case 'cancelled':
      return 'ملغي';
    case 'pending':
      return 'قيد الانتظار';
    default:
      return status;
  }
}

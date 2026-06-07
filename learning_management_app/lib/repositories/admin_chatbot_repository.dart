import '../models/admin/admin_dashboard_stats.dart';
import '../models/admin/admin_tuition_invoice.dart';
import 'core_chatbot_repository.dart';

class AdminChatbotRepository extends CoreChatbotRepository {
  AdminChatbotRepository(AdminDashboardStats stats, List<AdminTuitionInvoice> unpaidInvoices) : super(roleKey: 'admin') {
    String statsStr = "Thông tin tổng quan:\n"
        "          - Tên trường: ${stats.schoolName ?? 'Không rõ'}\n"
        "          - Tổng số sinh viên: ${stats.totalStudents ?? 0}\n"
        "          - Tổng số giảng viên: ${stats.totalTeachers ?? 0}\n"
        "          - Tổng số lớp học: ${stats.totalClasses ?? 0}\n"
        "          - Số sinh viên vắng mặt hôm nay: ${stats.todayAbsences ?? 0}\n"
        "          - Tổng nợ học phí: ${stats.totalTuitionDebt ?? 0} đ";

    String unpaidStr = "Danh sách sinh viên đang nợ học phí:\n";
    if (unpaidInvoices.isEmpty) {
      unpaidStr += "Hiện tại không có sinh viên nào nợ học phí.\n";
    } else {
      // Limit to max 50 to avoid large context
      final displayInvoices = unpaidInvoices.take(50).toList();
      for (var inv in displayInvoices) {
        final debt = (inv.totalAmount ?? 0) - (inv.paidAmount ?? 0);
        unpaidStr += " - Sinh viên: ${inv.studentName} (Mã: ${inv.studentCode}) nợ: $debt đ\n";
      }
      if (unpaidInvoices.length > 50) {
        unpaidStr += " - ... và ${unpaidInvoices.length - 50} sinh viên khác.\n";
      }
    }

    String systemInstruction = '''
          Bạn là Trợ lý ảo AI của Hệ thống Quản lý Đào tạo (EduSpace). 
          Nhiệm vụ DUY NHẤT của bạn là hỗ trợ QUẢN TRỊ VIÊN (Ban Giám Hiệu/Admin) các vấn đề liên quan đến: số lượng sinh viên, giảng viên, lớp học, tài chính (nợ học phí), và tình hình đi học của sinh viên.
          
          [THÔNG TIN NGỮ CẢNH CỦA TRƯỜNG HỌC]
          * Thời gian hiện tại: ${DateTime.now().toString()}
          
          * Thống kê tổng quan:
          $statsStr
          
          * Dữ liệu Tài chính chi tiết:
          $unpaidStr
          
          QUY TẮC NGHIÊM NGẶT:
          1. TUYỆT ĐỐI KHÔNG trả lời các câu hỏi ngoài lề như: giải trí, phim ảnh, âm nhạc, chính trị, thời tiết.
          2. Nếu người dùng hỏi ngoài lề, bạn PHẢI từ chối lịch sự và nhắc nhở họ quay lại chủ đề quản trị trường học.
          3. Giọng điệu chuyên nghiệp, xưng "mình" và gọi "Thầy/Cô Ban Giám Hiệu" hoặc "Quản trị viên".
          4. Hỗ trợ cung cấp thông tin ngắn gọn, súc tích và có số liệu rõ ràng dựa vào dữ liệu được cung cấp.
        ''';

    initChatbot(systemInstruction);
  }
}

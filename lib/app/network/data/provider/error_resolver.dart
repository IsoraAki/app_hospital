class ErrorResolver {
  static Map<int, String> errors = {
    //101: 'error_code_101'.tr,
// SYSTEM CODE:
    700: 'khóa hệ thống',
    701: 'bạn không có quyền sử dụng tính năng này',
    702: 'token sai hoặc hết hạn',
    703: 'không tìm thấy function này',
    704: 'Account bị lock liên hệ agent để biết thêm chi tiết',
    705: 'Hệ thống lỗi làm ơn làm lại',
    706: 'Thiếu agent code',
    707: 'Agent code không tồn tại',
    708: 'Agent hết hạn sử dụng',
    709: 'validate loi',
    710: 'không tồn tại',
//BOOKING CODE:
    800: 'thông tin người liên hệ không chính xác',
    801: 'số hiệu chuyên bay đi không tồn tại',
    802: 'chưa chọn điểm xuất phát',
    803: 'chưa chọn điểm đến của chuyến đi',
    804: 'chưa có thời gian đi chuyến đi',
    805: 'chưa có giờ đi của chuyến đi',
    806: 'ngày đến của chuyến đi không tồn tại',
    807: 'Thời gian đến cảu đến đi không tồn tại',
    808: 'Hãng máy bay chuyến đi không tồn tại',
    809: 'Place xuất phát của chuyến về không tồn tại',
    810: 'Place đến của chuyến về không tồn tại',
    811: 'Ngày xuất phát của chuyến về không tồn tại',
    812: 'Thời gian xuất phát của chuyến về không tồn tại',
    813: 'Ngày đến của chuyến về không tồn tại',
    814: 'Thời gian đến của chuyến vêf khôgn tồn tại',
    815: 'Mã máy bay của chuyến về không tồn tịa',
    816: 'Hang máy bay chuyến về không tồn tại',
    817: 'Airline code của cả booking không tồn tại',
    819: 'số người không đúng',
    820: 'tông giá vế sai',
    821: 'tông phí sai',
    822: 'booking không tồn tại',
    823: 'booking đã có người xử lí trước đó',
    824: 'booking id sai',
    826: 'bạn không được quyền sửa booking này',
    827: 'flight không tồn tại',
    828: 'tổng giá sai hãy làm lại',
    829: 'discount khong ton tai',
    830: 'discount đã hết lượt sử dụng',
    831: 'discount đã hết thời gian sử dụng',
    832: 'discount code da ton tai',
    833: 'booking giữ chỗ thất bại, bạn có muốn thực hiện lại',
    834: 'booking giữ chỗ thành công',
    835: 'booking đang tiến hành gửi',
    836: 'booking với loại thanh toán này cần phải đăgn nhập',
    837: 'số dư không đủ',
    842: 'check vé không đúng',
    840: 'không tìm thấy vé',
    //840: 'vé không du dieu kien de checkin',
    841: 'booking này chưa đủ điều kiện để giữ chõ',

    //booking car
    850: 'khoảng cách giửa 2 địa chỉ không đúng',
    //850: 'gía không đúng',
    851: 'booking không tồn tại',

    //pyament
    860: 'booking khong ton tai',
    861: 'phương thức thanh toán không chính xác',
    862: 'Tạo đường dẫn thanh toán thất bại',
    863: 'Thanh toan that bai',
    864: 'Thanh toan đã được thực hiện trước đó',
    865: 'Khồng thể thanh toán booking này',
    866: 'giá không đúng',
    867: 'Phuong thuc thanh toan khong duoc ho tro',
    868: 'Hiện tại không có ví trống, xin hay quay lại sau',
    900: 'Loại tiền thanh toán đã được chọn, không thể đổi tiền tệ khác',
    //hotel
    870: 'lỗi cấu hình dịch vụ hotel',
    871: 'số phòng và số người trong phòng không đúng',
    872: 'khách sạn không tồn tại',
    873: 'giá phòng không đúng',
    874: 'booking khong ton tai',
    875: 'request server lỗi',

    //combo

    880: 'tổng item gửi lên phải lớn hơn 2',
    881: 'booking flight không tồn tại',
    882: 'booking car không tồn tại',
    883: 'booking hotel không tồn tại',
    884: 'trang thai book khong duoc phep book online',
//USER CODE:
    600: 'username hoac pass sai',
    601: 'id gửi lên không đúng',
    602: 'first name or last name or email invalid',
    603: 'email invalid',
    604: 'password khong trung hop',
    605: 'email exist',
    606: 'pass cũ sai hoặc đăng nhập bằng tài khoản fb, google',
  };
  static String getCodeError(int code) {
    try {
      return errors[code] ?? code.toString();
    } catch (e) {
      return code.toString();
    }
  }
}

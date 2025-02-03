<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LichSuThanhToan.aspx.cs" Inherits="TTTT.LichSuThanhToan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

    <style>
        .btn-gap {
            margin-right: 30px;
        }
        .khung {
            margin-top: 40px;
        }
        .khung2 {
            margin-top: 60px; /* Tạo khoảng cách với navbar */
        }
        .khung3 {
            margin: 40px;
        }
        .khung4 {
            margin-bottom: 10px;
        }
        .khung5 {
            margin-left: 70px;
        }
        .khung6 {
            margin-bottom: 20px;
        }

        /* Thay đổi màu nền navbar */
        .navbar-light .navbar-nav .nav-link {
            color: #000; /* Màu chữ */
        }

        .navbar-light .navbar-nav .nav-link:hover {
            color: #000; /* Màu chữ khi hover */
        }

        .navbar-light .navbar-toggler {
            border-color: #000; /* Màu border của toggle */
        }

        .navbar-light .navbar-toggler-icon {
            background-color: #000; /* Màu của biểu tượng toggle */
        }

        .navbar-light {
            background-color: #F1F8E8 !important; /* Màu nền navbar */
        }

        .navbar-light .navbar-brand,
        .navbar-light .navbar-brand:hover,
        .navbar-light .navbar-brand:focus {
            color: #000; /* Màu chữ của brand */
        }

        .navbar-light .navbar-nav .active > .nav-link,
        .navbar-light .navbar-nav .nav-link.active,
        .navbar-light .navbar-nav .nav-link.show,
        .navbar-light .navbar-nav .show > .nav-link {
            color: #000; /* Màu chữ của item active */
            background-color: #A3C4A8; /* Màu nền của item active */
        }

        .navbar-light .navbar-nav .nav-link.disabled {
            color: rgba(0, 0, 0, 0.3); /* Màu chữ của item disabled */
        }
        .card-img-top {
            width: 100%; /* Chiều rộng sẽ bằng với chiều rộng của thẻ chứa (card) */
            height: 200px; /* Thiết lập chiều cao cố định cho hình ảnh */
            object-fit: cover; /* Đảm bảo hình ảnh được cắt và phóng to để vừa với khung hình mà không bị biến dạng */
        }

        .smallTextBox {
            width: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 8px;
            text-align: left;
        }

        .custom-text-color {
            color: white;
        }

        .auto-style1 {
            width: 90px;
        }
        .scrollable-card-body {
            max-height: 410px; /* Chiều cao cố định bạn mong muốn */
            overflow-y: auto; /* Cho phép cuộn dọc */
        }
        .scrollable-card-body2 {
            max-height: 445px; /* Chiều cao cố định bạn mong muốn */
            overflow-y: auto; /* Cho phép cuộn dọc */
        }
        #btnLogout {
            background-color: #DC3545; /* Màu đỏ */
            color: #FFF; /* Màu chữ trắng */
            border: 1px solid #DC3545; /* Viền đỏ */
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Đổ bóng */
        }

        #btnLogout:hover {
            background-color: #C82333; /* Màu đỏ nhạt khi hover */
            border-color: #C82333; /* Viền đỏ nhạt khi hover */
        }
    </style>
    <script>
        $(function () {
            $("#datepicker1").datepicker();
            $("#datepicker2").datepicker();
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container-fluid">
            <asp:ImageButton ID="btnHome" runat="server" ImageUrl="3127450.png" Width="40px" Height="40px"/>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto mb-2 mb-lg-0">
                    <li class="nav-item btn-gap">
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="HoaDon.aspx" CssClass="nav-link">HÓA ĐƠN</asp:HyperLink>
                    </li>
                    <li class="nav-item btn-gap">
                        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="Menu.aspx" CssClass="nav-link">MENU</asp:HyperLink>
                    </li>
                        <asp:Panel ID="QuanLyMenu" runat="server">
                            <li class="nav-item dropdown btn-gap">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    QUẢN LÝ
                                </a>
                                <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                                    <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="TaiKhoan.aspx" CssClass="dropdown-item">TÀI KHOẢN</asp:HyperLink>
                                    <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="DoanhThu.aspx" CssClass="dropdown-item">DOANH THU</asp:HyperLink>
                                    <asp:HyperLink ID="HyperLink5" runat="server" NavigateUrl="LichSuThanhToan.aspx" CssClass="dropdown-item">LỊCH SỬ THANH TOÁN</asp:HyperLink>
                                </div>
                            </li>
                        </asp:Panel>
                </ul>
                    <asp:Button ID="btnLogout" runat="server" Text="Đăng xuất" CssClass="btn btn-outline-danger ml-2" OnClick="btnLogout_Click" />
                </div>
            </div>
        </nav>

        <span class="container mt-3 khung">
            <span class="row khung3">

                <div class="col-sm-6">
                    <div class="card">
                            <div class="card-body">
                                <span>
                                    <asp:DropDownList ID="DropDownList1" CssClass="khung6" runat="server" Width="195px" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Value="1">Hóa đơn đã thanh toán</asp:ListItem>
                                        <asp:ListItem Value="2">Hóa đơn đã xóa</asp:ListItem>
                                    </asp:DropDownList>

                                    <!-- Chọn ngày -->
                                    <span class="khung5">
                                        <label for="datepicker1">Từ: </label>
                                        <input type="text" id="datepicker1" runat="server" class="auto-style1"/>
                                        <label for="datepicker2">đến: </label>
                                        <input type="text" id="datepicker2" runat="server" class="auto-style1"/>

                                        <asp:HiddenField ID="hiddenDate1" runat="server" />
                                        <asp:HiddenField ID="hiddenDate2" runat="server" />

                                        <asp:ImageButton ID="btnngay" runat="server" ImageUrl="funnel.svg" OnClick="btnngay_Click"/>
                                    </span>
                                </span>
                            <div class="scrollable-card-body">
                            <asp:ListView ID="ListView1" runat="server">
                                <LayoutTemplate>
                                    <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
                                </LayoutTemplate>
                                <ItemTemplate>
                                    <div class="card khung4">
                                        <div class="card-body">
                                            <table>
                                                <tr>
                                                    <td>Mã hóa đơn [<%# Eval("hd_id") %>]</td>
                                                    <td rowspan="2"><%# Eval("NgayThangNam") %></td>
                                                    <td rowspan="2"><%# Eval("ThoiGian") %></td>
                                                    <td rowspan="2">
                                                        <asp:ImageButton ID="ImageButton1" ImageUrl="three-dots.svg" runat="server" OnClick="ImageButton1_Click" CommandArgument='<%# Eval("hd_id") %>'/></td>
                                                </tr>
                                                <tr>
                                                    <td ><p class="badge badge-success mb-0"><%# Eval("hd_tongtien") %>.000đ</p></td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:ListView>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-sm-6">
                    <div class="card">
                        <div class="card-header" style="text-align: center">
                            <h6>Thông tin hóa đơn</h6>
                        </div>
                        <div class="card-body scrollable-card-body2">
                            <table>
                                <tr>
                                    <td>Mã hóa đơn</td>
                                    <td style="text-align: right";><asp:Label ID="txtMa" runat="server" Text=""></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>Thời gian lập</td>
                                    <td style="text-align: right";><asp:Label ID="txtTglap" runat="server" Text=""></asp:Label></td>

                                </tr>
                                <tr>
                                    <td>Thời gian thanh toán</td>
                                    <td style="text-align: right";><asp:Label ID="txtTgtt" runat="server" Text=""></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>Bàn</td>
                                    <td style="text-align: right";><asp:Label ID="txtBan" runat="server" Text=""></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>Người lập</td>
                                    <td style="text-align: right";><asp:Label ID="txtTendangnhap" runat="server" Text=""></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>Ghi chú</td>
                                </tr>
                                <tr>
                                    <td><asp:TextBox ID="txtMota" width="250px" Height="100px" runat="server" BorderColor="#CCCCCC" BorderWidth="1px" TextMode="MultiLine"></asp:TextBox></td>
                                </tr>
                            </table>
                            <hr />
                            <table>
                                <tr>
                                    <th>Món</th>
                                    <th>Giá</th>
                                    <th>Số lượng</th>
                                    <th style="text-align: right;">Tổng tiền</th>
                                </tr>
                                <tr>
                                    <td colspan="5" style="text-align: center;">
                                        <hr style="border-top: 1px solid #ccc; margin: 10px 0;" />
                                    </td>
                                </tr>
                                <asp:Repeater ID="Repeater1" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td style="padding: 8px;">
                                                <%# Eval("mon_ten") %>
                                            </td>
                                            <td style="text-align: center; padding: 8px;">
                                                <%# string.Format("{0:N0}", Eval("mon_gia")) %> .000đ
                                            </td>
                                            <td style="text-align: center; padding: 8px;">
                                                <%# Eval("TongSoLuong") %>
                                            </td>
                                            <td style="text-align: right; padding: 8px;">
                                                <%# string.Format("{0:N0}", Eval("tonggiatri")) %> .000đ
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <tr>
                                    <td colspan="4"><hr /></td>
                                </tr>
                                <tr>
                                    <td colspan="4" style="text-align: right; padding: 8px;">
                                        <h6>
                                            <asp:Label ID="tong_tien" runat="server" Text="Tổng: "></asp:Label>
                                        </h6>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </span>
        </span>

        <!-- Modal thông báo chưa chọn ngày-->
        <div class="modal fade" id="daterongModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg-custom2" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <p>Vui lòng chọn ngày để lọc hóa đơn</p>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">ĐÓNG</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>

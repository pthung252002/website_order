<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HoaDon.aspx.cs" Inherits="TTTT.HoaDon" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        .btn-gap {
            margin-right: 30px;
        }
        .khung {
            margin-top: 40px;
        }
        .khung3 {
            margin: 30px;
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

        .card-custom {
            height: 200px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Hiệu ứng đổ bóng */
        }
        .button-container {
            display: flex;
            justify-content: center;
            width: 100%;
        }
        .button-container .btn {
            margin: 0 5px;
            width: 100px; /* Cùng chiều ngang cho các nút */
            font-size: 14px; /* Điều chỉnh kích thước chữ */
        }
        .button-container .btn-thanh-toan, .button-container .btn-xoa {
            background-color: #55AD9B; /* Màu nền mới */
            color: #fff; /* Màu chữ mới cho nút */
            font-size: 12px; /* Điều chỉnh cỡ chữ của nút */
            border-color: #55AD9B; /* Thêm viền cho nút */
        }
        .card .card-body p {
            margin-bottom: 5px;
            color: #000; /* Màu chữ cho các đoạn văn bản */
        }
        .table-info {
            background-color: #F1F8E8; /* Màu nền mới cho phần thông tin bàn */
            padding: 10px; /* Thêm khoảng cách để đẹp hơn */
            border-radius: 5px; /* Bo góc để đẹp hơn */
            text-align: center; /* Canh giữa văn bản */
            width: 100%;
        }
        .image-button-container {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100%;
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


        <div class="container md-3 khung">
            <div class="row">
                <!-- Phần "Thêm mới hóa đơn" -->
                <div class="col-md-3">
                    <div class="card card-custom">
                        <div class="card-body image-button-container">
                            <asp:ImageButton ID="imgBtnThemMoi" runat="server" ImageUrl="plus-circle-12-128.png" OnClick="ThemHoaDonMoi_Click"/>
                        </div>
                    </div>
                    <br />
                </div>

                <!-- ListView -->
                <asp:ListView ID="ListView1" runat="server">
                    <LayoutTemplate>
                        <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
                    </LayoutTemplate>
                    <ItemTemplate>
                        <div class="col-md-3">
                            <div class="card card-custom">
                                <div class="card-body">
                                    <p class="table-info" style="font-size: 15px;">Bàn:  <%# Eval("kv_ten") %> - <%# Eval("ban_stt") %></p>
                                    <p style="font-size: 20px;" class="khung3" align="center"><%# Eval("hd_tongtien") %>.000đ</p>
                                    <hr />
                                    <div class="button-container">
                                        <asp:Button ID="ThanhToanHoaDon" runat="server" CssClass="btn btn-warning btn-thanh-toan" Text="THANH TOÁN" OnClick="ThanhToanHoaDon_Click" CommandArgument='<%# Eval("hd_id") %>' />
                                        <asp:Button runat="server" CssClass="btn btn-warning btn-xoa" Text="XEM" OnClick="XemHoaDon_Click" CommandArgument='<%# Eval("hd_id") %>' />
                                    </div>
                                </div>
                            </div>
                            <br />
                        </div>
                    </ItemTemplate>
                </asp:ListView>
            </div>
        </div>
    </form>
</body>
</html>

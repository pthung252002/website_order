<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="TTTT.Menu" %>
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
        .khung2 {
            margin-top: 60px; /* Tạo khoảng cách với navbar */
        }
        .khung3 {
            margin: 40px;
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
        .card-body p, .card-body h6, .card-body .badge {
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
        }
        .btn-mau {
            background-color: #55AD9B; /* Màu nền mới */
            color: #fff; /* Màu chữ mới cho nút */
            border-color: #55AD9B; /* Thêm viền cho nút */
        }
        .custom-badge {
            background-color: #D8EFD3; /* Màu nền tùy chỉnh */
            color: #55AD9B; /* Màu chữ */
            padding: 2px 6px; /* Giảm padding để vừa vặn chữ */
            border-radius: 0.25rem; /* Tùy chỉnh góc bo tròn */
            font-size: 1em; /* Cỡ chữ */
            line-height: 1.5; /* Chiều cao dòng để đảm bảo chữ không bị cắt */
            display: inline-block; /* Đảm bảo badge hiển thị đúng */
            text-align: center; /* Canh giữa chữ */
            white-space: nowrap; /* Đảm bảo badge không bị ngắt dòng */
        }
    </style>

    <script type="text/javascript">
    var typingTimer; // Timer identifier
    var doneTypingInterval = 600; // Time in ms (0.6 seconds)

    function doneTyping() {
        // Trigger the TextBox's change event
        __doPostBack('<%= txtTiemKiem.ClientID %>', '');
    }

    function setupTypingTimer() {
        var textBox = document.getElementById('<%= txtTiemKiem.ClientID %>');
        textBox.onkeyup = function () {
            clearTimeout(typingTimer);
            typingTimer = setTimeout(doneTyping, doneTypingInterval);
        };
        textBox.onkeydown = function () {
            clearTimeout(typingTimer);
        };
    }

    window.onload = setupTypingTimer;
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

        <!-- Tìm kiếm và thêm món mới -->
        <div class="container khung2">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <span class="mb-3">
                        <asp:TextBox ID="txtTiemKiem" runat="server" Height="35px" Width="240px" Placeholder="Nhập tên món..." AutoPostBack="True" OnTextChanged="txtTimKiem_TextChanged"></asp:TextBox>
                        <asp:DropDownList ID="DropDownList1" CssClass="khung6" runat="server" Width="130px" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="true" Height="35px">
                            <asp:ListItem Value="0">tất cả</asp:ListItem>
                            <asp:ListItem Value="1">Cà phê</asp:ListItem>
                            <asp:ListItem Value="2">trà</asp:ListItem>
                            <asp:ListItem Value="3">Đá xay</asp:ListItem>
                            <asp:ListItem Value="4">Nước đóng chai</asp:ListItem>
                        </asp:DropDownList>
                    </span>
                </div>
                <div class="col-md-6">
                    <div class="d-flex flex-wrap align-items-center justify-content-end gap-2 mb-3">
                        <div>
                            <asp:Button ID="themtk" runat="server" CssClass="btn btn-primary" Text="Thêm món mới" OnClick="ThemMon_Click"/>
                        </div>
                    </div>
                </div>
            </div>
            <hr />
        </div>

        <!-- Menu -->
        <div class="container md-3 khung">
            <div class="row">
                <asp:ListView ID="ListViewMenu" runat="server" OnItemDataBound="ListViewMenu_ItemDataBound">
                    <LayoutTemplate>
                        <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <div class="col-sm-3">
                        <div class="card">
                            <asp:Image ID="hinh" runat="server" CssClass="card-img-top" />
                                <div class="card-body">
                                    <h6 class="card-title custom-badge mb-0"><%# Eval("mon_ten") %></h6>
                                    <p><%# Eval("lm_ten") %></p>
                                    <p><%# Eval("mon_gia") %>.000đ</p>
                                    <div class="text-center">
                                        <asp:Button runat="server" CssClass="btn btn-success btn-mau" Text="CHỈNH SỬA" OnClick="XemMon_Click" CommandArgument='<%# Eval("mon_id") %>' />
                                    </div>
                                </div>
                        </div>
                        <br />
                        </div>
                    </ItemTemplate>
                </asp:ListView>
            </div>
        </div>

        <!-- Modal thông báo không thể thực hiện -->
        <div class="modal fade" id="chucnangModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg-custom2" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <p>Bạn không có quyền thực hiện hành động này!!</p>
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

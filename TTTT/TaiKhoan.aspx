<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TaiKhoan.aspx.cs" Inherits="TTTT.TaiKhoan" %>

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
            margin-top: 90px;
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

        .listview-item {
            background-color: #f8f9fa;
            color: #343a40;
            margin-bottom: 10px; /* Adding space between items */
            border-bottom: 1px solid #dee2e6; /* Adding a border for separation */
        }
        .listview-item:nth-child(even) {
            background-color: #e9ecef;
        }
        .listview-item:hover {
            background-color: #dee2e6;
        }
        .badge-success {
            background-color: #28a745;
        }
        /* CSS for the table border */
        .table {
            border: 1px solid #dee2e6;
            border-collapse: collapse;
        }
        .table th, .table td {
            border: 1px solid #dee2e6;
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

        <!-- Phần "Danh sách tài khoản" -->
        <div class="container khung2">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <div class="mb-3">
                        <h5 class="card-title">Danh sách tài khoản</h5>
                        <asp:DropDownList ID="DropDownList1" CssClass="khung6" runat="server" Width="195px" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem Value="1">Hoạt động</asp:ListItem>
                            <asp:ListItem Value="0">Bị khóa</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="d-flex flex-wrap align-items-center justify-content-end gap-2 mb-3">
                        <div>
                            <asp:Button ID="themtk" runat="server" CssClass="btn btn-primary" Text="Tạo tài khoản mới" OnClick="ThemTaiKhoan_Click"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="">
                        <div class="table-responsive">
                            <table class="table project-list-table table-nowrap align-middle table-borderless">
                                <thead>
                                    <tr>
                                        <th scope="col">Tên người dùng</th>
                                        <th scope="col">Chức vụ</th>
                                        <th scope="col">Tên đăng nhập</th>
                                        <th scope="col">Số điện thoại</th>
                                        <th scope="col" style="width: 200px;">Chức năng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:ListView ID="ListView1" runat="server" OnItemDataBound="ListView1_ItemDataBound">
                                        <LayoutTemplate>
                                            <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
                                        </LayoutTemplate>
                                        <ItemTemplate>
                                            <!-- Các phần tử trong mỗi hàng của ListView -->
                                            <tr class="listview-item">
                                                <td><p class="text-body"><%# Eval("tk_tennguoidung") %></p></td>
                                                <td><span class='<%# IsAdmin2(Eval("ltk_ten")) ? "badge badge-success mb-0" : "badge badge-primary mb-0" %>'><%# Eval("ltk_ten") %></span></td>
                                                <td><%# Eval("tk_tendangnhap") %></td>
                                                <td><%# Eval("tk_sdt") %></td>
                                                <td>
                                                    <ul class="list-inline mb-0">
                                                        <li class="list-inline-item">
                                                            <asp:ImageButton ID="chinhsuatk" runat="server" ImageUrl="pencil-square.svg" OnClick="ChinhSuaTaiKhoan_Click" CommandArgument='<%# Eval("tk_tendangnhap") %>' Visible='<%# CanEdit(Eval("tk_tendangnhap").ToString()) %>'/>
                                                        </li>
                                                        <li class="list-inline-item">
                                                            <asp:ImageButton ID="xoataikhoan" runat="server" ImageUrl="lock.svg" OnClick="XoaTaiKhoan_Click" CommandArgument='<%# Eval("tk_tendangnhap") %>' Visible='<%# CanNotDelete(Eval("tk_tendangnhap").ToString()) %>'/>
                                                        </li>
                                                        <li class="list-inline-item">
                                                            <asp:ImageButton ID="huyxoataikhoan" runat="server" ImageUrl="unlock.svg" OnClick="Un_XoaTaiKhoan_Click" CommandArgument='<%# Eval("tk_tendangnhap") %>' Visible='<%# CanNotDelete(Eval("tk_tendangnhap").ToString()) %>'/>
                                                        </li>
                                                    </ul>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:ListView>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
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

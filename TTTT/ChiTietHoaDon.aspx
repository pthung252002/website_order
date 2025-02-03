<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChiTietHoaDon.aspx.cs" Inherits="TTTT.ChiTietHoaDon" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Chi tiết Hóa Đơn</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <style>
        .btn-gap {
            margin-right: 10px;
        }

        .khung {
            margin-top: 40px;
        }

        .smallTextBox {
            width: 30px;
            height: 20px;
            font-size: 12px;
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 8px;
            text-align: left;
        }

        .table-container {
            width: 100%; /* Chiều ngang của div */
            overflow-x: auto; /* Cho phép cuộn nếu nội dung quá rộng */
        }

        .custom-table {
            width: 100%; /* Chiều ngang của table */
            table-layout: fixed; /* Chiều ngang cố định */
            border-collapse: collapse; /* Gộp các đường biên */
        }

        .column1 {
            width: 85%; /* Chiều ngang của cột 1 */
        }

        .column2 {
            width: 15%; /* Chiều ngang của cột 2 */
        }

        /* CSS cho modal rộng hơn */
        .modal-lg-custom {
            max-width: 100%; /* Tăng chiều ngang modal lên 80% của màn hình */
        }
        .modal-lg-custom2 {
            max-width: 30%; /* Tăng chiều ngang modal lên 80% của màn hình */
        }
        .modal-lg-custom3 {
            max-width: 30%; /* Tăng chiều ngang modal lên 80% của màn hình */
        }

        .tret,
        .lau {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between; /* Phân chia khoảng trống đều giữa các phần tử */
        }

        .col-ban {
            flex: 0 0 calc(20% - 4px); /* 20% với khoảng cách 2px giữa các phần tử */
            margin: 2px;
        }

        .separator {
            border-top: 1px solid #ccc; /* Màu và định dạng đường kẻ */
            margin: 10px 0; /* Khoảng cách trên và dưới đường kẻ */
            width: 100%; /* Độ rộng của đường kẻ */
        }

        /* Màu nền cho các phần tử có ban_trangthai = 0 */
        .listViewItem[data-trangthai="0"] {
            background-color: #28a745; /* Màu xanh lá */
        }

        /* Màu nền cho các phần tử có ban_trangthai = 1 */
        .listViewItem[data-trangthai="1"] {
            background-color: #dc3545; /* Màu đỏ */
        }

        /* Custom styling for radio buttons in the modal */
        .modal-body .form-group {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        
        .form-check-input {
            margin-right: 10px;
        }
        .scrollable-card-body {
            max-height: 500px; /* Chiều cao cố định bạn mong muốn */
            overflow-y: auto; /* Cho phép cuộn dọc */
            overflow-x: hidden;
        }
        .scrollable-card-body2 {
            max-height: 370px; /* Chiều cao cố định bạn mong muốn */
            overflow-y: auto; /* Cho phép cuộn dọc */
            overflow-x: hidden;
        }
        body {
        overflow-x: hidden; /* Ẩn thanh cuộn ngang trên toàn trang */
        }
        .btn-mau {
            background-color: #55AD9B; /* Màu nền mới */
            color: #fff; /* Màu chữ mới cho nút */
            border-color: #55AD9B; /* Thêm viền cho nút */
        }
        .quantity-container {
            display: flex;
            align-items: center;
            justify-content: center;
        }
        /* CSS cho ImageButton */
        .btn-action {
            margin-right: 40px; /* Khoảng cách 10px giữa các ImageButton */
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
        <span class="container mt-3 khung">
            <span class="row">
                <div class="col-sm-7">

                    <!-- thanh tìm kiếm và nút xóa hóa đơn-->
                    <div class="container khung2">
                        <div class="row align-items-center">
                            <div class="col-md-12">
                                <div class="d-flex align-items-center justify-content-between">
                                    <span class="mb-3">
                                        <asp:TextBox ID="txtTiemKiem" runat="server" Height="35px" Width="240px" Placeholder="Nhập tên món..." AutoPostBack="True" OnTextChanged="txtTimKiem_TextChanged"></asp:TextBox>
                                    </span>
                                    <span class="mb-3">
                                    </span>
                                </div>
                            </div>
                        </div>
                        <hr />
                    </div>

                    <!-- Menu -->
                    <div class="scrollable-card-body">
                    <asp:ListView ID="ListView1" runat="server">
                        <LayoutTemplate>
                                <div class="row">
                                    <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                                </div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <div class="col-sm-4">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 align="center" class="card-title"><%# Eval("mon_ten") %></h5>
                                        <p align="center"><%# Eval("mon_gia") %>.000đ</p>
                                        <div class="d-grid gap-2 col-6 mx-auto">
                                            <asp:Button runat="server" CssClass="btn btn-success" Text="THÊM" OnClick="ThemCTHD_Click" CommandArgument='<%# Eval("mon_id") %>' />
                                        </div>
                                    </div>
                                </div>
                                <br />
                            </div>
                        </ItemTemplate>
                    </asp:ListView>
                    </div>
                </div>

                <!-- Hóa đơn -->
                <div class="col-sm-5">
                    <div class="card">
                        <div class="card-body">
                            <div class="table-container">
                                <table class="custom-table">
                                    <tr>
                                        <td class="column1">
                                            <asp:Literal ID="Literal1" runat="server">Bàn: </asp:Literal><asp:Literal ID="ban_stt" runat="server"></asp:Literal>
                                        </td>
                                        <td class="column2" id="ban">
                                            <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="table.svg" OnClick="ImageButton1_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <hr />
                            <div class="scrollable-card-body2">
                            <table>
                                <tr>
                                    <th>Món</th>
                                    <th>Giá</th>
                                    <th>Số lượng</th>
                                </tr>
                                <asp:Repeater ID="Repeater1" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td><p text-size="12px"><%# Eval("mon_ten") %></p></td>
                                            <td><p text-size="12px"><%# Eval("mon_gia") %>.000đ</p></td>
                                            <td class="d-flex align-items-center justify-content-center">

                                                <!-- tăng sl +1 -->
                                                <asp:ImageButton ID="btnTangSL" runat="server" ImageUrl="plus-square.svg" OnClick="ThemCTHD_Click2" CommandArgument='<%# Eval("mon_id") %>'/>
                                                
                                                <!-- số lượng -->
                                                <asp:TextBox ID="txtSL" runat="server" Text='<%# Eval("soluong") %>' CssClass="smallTextBox" ReadOnly="True"></asp:TextBox>
                                                
                                                <!-- giảm sl -1 -->
                                                <asp:ImageButton ID="btnGiamSL" runat="server" ImageUrl="dash-square.svg" CssClass="btn-action" OnClick="GiamCTHD_Click" CommandArgument='<%# Eval("mon_id") %>'/>
                                                
                                                <!-- xóa chi tiết -->
                                                <asp:ImageButton ID="btnXoaChitietHoaDon" runat="server" ImageUrl="trash.svg" width="20px" Height="20px" OnClick="XoaChiTietHoaDon" CommandArgument='<%# Eval("mon_id") %>'/>
                                            </td>
                                            <asp:HiddenField ID="idmon" runat="server" Value='<%# Eval("mon_id") %>' />
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </table>
                            </div>
                            <hr />
                            <div style="text-align: center;">
                                <h5 class="card-title"><asp:Literal ID="tong_tien" runat="server"></asp:Literal></h5>
                            </div>
                            <span class="d-flex justify-content-center">
                                <span style="margin-bottom: 3px; text-align: center;">
                                    <asp:Button ID="btnXong" runat="server" CssClass="btn btn-warning btn-mau btn-gap" Text="XONG" style="width: 150px" OnClick="XONG_Click" />
                                </span>
                                <span style="margin-bottom: 3px; text-align: center;">
                                    <asp:Button ID="btnXoahd" runat="server" CssClass="btn btn-warning btn-mau" Text="XÓA" style="width: 150px" OnClick="XoaHD_Click" />
                                </span>
                            </span>
                        </div>
                    </div>
                </div>
            </span>
        </span>

        <!-- Modal -->
        <div class="modal fade" id="banModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg-custom" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Danh sách bàn</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                    </div>
                    <div class="modal-body">
                        <span class="container">
                            <span class="row">
                                </span>
                                <span class="row">
                                    <span class="col tret">
                                        <h5>Trệt</h5>
                                        <hr class="separator">
                                        <asp:ListView ID="ListView2" runat="server">
                                            <LayoutTemplate>
                                                <asp:PlaceHolder runat="server" ID="itemPlaceholder"/>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <div class="col-ban">
                                                    <div class="card">
                                                        <div class="card-body text-center listViewItem" data-trangthai='<%# Eval("ban_trangthai") %>'>
                                                            <div class="table-item">
                                                                <p style="font-size: 30px; color: white;"> <%# Eval("ban_stt") %></p>
                                                                <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="check2-square.svg" Onclick="ChonBan_Click" CommandArgument='<%# Eval("ban_stt") %>'/>                                                        
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:ListView>
                                    </span>

                                    <span class="col lau">
                                        <h5>Lầu</h5>
                                        <hr class="separator">
                                        <asp:ListView ID="ListView3" runat="server">
                                            <LayoutTemplate>
                                                <asp:PlaceHolder runat="server" ID="itemPlaceholder"/>
                                            </LayoutTemplate>
                                            <ItemTemplate>
                                                <div class="col-ban">
                                                    <div class="card">
                                                        <div class="card-body text-center listViewItem" data-trangthai='<%# Eval("ban_trangthai") %>'>
                                                            <div class="table-item">
                                                                <p style="font-size: 30px; color: white;"> <%# Eval("ban_stt") %></p>
                                                                <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="check2-square.svg" Onclick="ChonBan_Click" CommandArgument='<%# Eval("ban_stt") %>'/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:ListView>
                                    </span>
                                </span>
                            </span>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                        </div>
                    </div>
                </div>
            </div>

        <!-- Modal Xóa Hóa Đơn -->
        <div class="modal fade" id="xoaModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg-custom2" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel_xoa">Xóa hóa đơn</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <asp:TextBox ID="txtLyDoXoa" runat="server" TextMode="MultiLine" CssClass="form-control" Rows="4" Placeholder="Nhập lý do xóa..."></asp:TextBox>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnXacNhan" runat="server" CssClass="btn btn-danger" Text="XÓA" OnClick="XoaHoaDon_Click"/>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">HỦY</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal thông báo chưa nhập bàn -->
        <div class="modal fade" id="chuanhapbanModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg-custom2" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <p>Bạn chưa chọn bàn!!</p>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">ĐÓNG</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal thông báo hóa đơn rỗng -->
        <div class="modal fade" id="hoadonrongModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg-custom2" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <p>Hóa đơn rỗng, bạn có muốn Hủy việc tạo hóa đơn?</p>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="Button1" runat="server" CssClass="btn btn-danger" Text="HỦY" OnClick="btnXoa_Click"/>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">ĐÓNG</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>

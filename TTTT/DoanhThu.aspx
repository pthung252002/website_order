<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DoanhThu.aspx.cs" Inherits="TTTT.DoanhThu" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Doanh thu</title>
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
        .khung2 {
            margin-top: 60px; /* Tạo khoảng cách với navbar */
        }
        .khung3 {
            margin-left: 5px; /* Tạo khoảng cách với navbar */
        }
        .khung4 {
            margin-bottom: 8px; /* Tạo khoảng cách với navbar */
        }
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
        .chart-container-wrapper {
            display: flex;
            justify-content: center;
            margin-top: 30px; /* Khoảng cách từ phần trên cùng của trang xuống phần chứa chart */
        }
        .chart-container {
            border: 1px solid #ccc; /* Đường viền mỏng với màu xám nhạt */
            border-radius: 10px; /* Bo góc các biểu đồ */
            box-shadow: 0 6px 10px rgba(0, 0, 0, 0.1); /* Hiệu ứng đổ bóng */
            width: 1200px; /* Đặt chiều rộng mong muốn */
            padding: 20px; /* Khoảng cách bên trong phần chứa chart */
            margin: 0 auto; /* Căn giữa theo chiều ngang */
            max-width: 100%; /* Đặt chiều rộng tối đa là 100% của phần tử cha */
        }
        h4 {
            text-align: center; /* Căn giữa tiêu đề */
            margin-bottom: 20px; /* Khoảng cách với phần nội dung */
        }
        .auto-style2 {
            width: 100px;
        }
        .date-filter {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px; /* Khoảng cách giữa các phần tử */
            margin-bottom: 20px; /* Khoảng cách dưới cùng */
        }
        .date-filter .left {
            font-size: 1.25em; /* Tăng kích thước chữ */
            font-weight: bold;
            flex: 1; /* Đẩy phần này sang trái */
        }
        .date-filter .right {
            display: flex;
            align-items: center;
            gap: 10px; /* Khoảng cách giữa các phần tử */
        }
        table {
            width: 100%;
            border-collapse: collapse;
            text-align: center;
            margin-bottom: 20px;
        }
        th, td {
            padding: 10px;
        }
        th {
            background-color: #f2f2f2;
        }
        hr {
            margin: 10px 0;
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
            // Thiết lập datepicker với định dạng dd/mm/yy
            $("#datepicker1").datepicker({
                dateFormat: "dd/mm/yy",
                onSelect: function (dateText) {
                    $("#<%= hiddenDate1.ClientID %>").val(dateText);
            }
        });
            $("#datepicker2").datepicker({
                dateFormat: "dd/mm/yy",
                onSelect: function (dateText) {
                    $("#<%= hiddenDate2.ClientID %>").val(dateText);
            }
        });

        // Thiết lập giá trị mặc định là ngày hiện tại
        var today = new Date();
        var day = ('0' + today.getDate()).slice(-2);
        var month = ('0' + (today.getMonth() + 1)).slice(-2);
        var year = today.getFullYear();
        var formattedDate = day + '/' + month + '/' + year;

        $("#datepicker1").val(formattedDate);
        $("#datepicker2").val(formattedDate);

        // Đặt giá trị của HiddenField
        $("#<%= hiddenDate1.ClientID %>").val(formattedDate);
            $("#<%= hiddenDate2.ClientID %>").val(formattedDate);
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

        <!-- 
        <div class="container khung2">
            <div class="row align-items-center">
                <div class="col-md-6"></div>
                <div class="col-md-6">
                    <div class="d-flex flex-wrap align-items-center justify-content-end gap-2 mb-3">
                        <div>
                            <asp:Button ID="btnxuatBaocao" runat="server" CssClass="btn btn-primary" Text="Xuất báo cáo" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        -->

        <div class="container-fluid">
            <div class="row justify-content-center chart-container-wrapper">
                <div class="col-lg-8">
                    <div class="chart-container">
                        <div class="khung4" style="text-align: center;">
                            Doanh thu: <% Response.Write(DateTime.Now.ToString("dd/MM/yyyy")); %>
                        </div>
                        <table>
                            <tr>
                                <th>Món</th>
                                <th>Giá</th>
                                <th>Số lượng</th>
                                <th style="text-align: right;">Tổng tiền</th>
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
                                        <td colspan="4" style="text-align: center;">
                                            <hr style="border-top: 1px solid #ccc; margin: 10px 0;" />
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="3" style="text-align: right; padding: 8px;">
                                            <h5>Tổng:</h5>
                                        </td>
                                        <td style="text-align: right; padding: 8px;">
                                            <h5>
                                                <asp:Label ID="tong_tien" runat="server" Text=""></asp:Label>
                                            </h5>
                                        </td>
                                    </tr>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row justify-content-center chart-container-wrapper">
                <div class="col-lg-8">
                    <div class="chart-container">
                        <div class="date-filter">
                            <span class="left">
                                <label for="datepicker">Doanh thu theo ngày</label>
                            </span>
                            <span class="right">
                                <label for="datepicker1">Từ: </label>
                                <input type="text" id="datepicker1" runat="server" class="auto-style2" />
                                <label for="datepicker2">đến: </label>
                                <input type="text" id="datepicker2" runat="server" class="auto-style2" />

                                <asp:HiddenField ID="hiddenDate1" runat="server" />
                                <asp:HiddenField ID="hiddenDate2" runat="server" />

                                <asp:ImageButton ID="btnngay" runat="server" ImageUrl="funnel.svg" OnClick="btnngay_Click"/>
                            </span>
                        </div>
                        <asp:Chart ID="Chart1" Width="800px" Height="400px" runat="server">
                            <Series>
                                <asp:Series Name="Series1" ChartType="Column" XValueMember="ngay" YValueMembers="tongtien"></asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1">
                                    <AxisX Title="Ngày" Interval="1">
                                        <MajorGrid Enabled="False" />
                                    </AxisX>
                                    <AxisY Title="Nghìn VNĐ">
                                        <MajorGrid Enabled="False" />
                                    </AxisY>
                                </asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>
                    </div>
                </div>
            </div>

            <div class="row justify-content-center chart-container-wrapper">
                <div class="col-lg-8">
                    <div class="chart-container">
                        <div class="date-filter">
                            <span class="left">
                                <label for="datepicker">Doanh thu theo tháng</label>
                            </span>
                        </div>
                        <asp:Chart ID="Chart2" Width="800px" Height="400px" runat="server">
                            <Series>
                                <asp:Series Name="Series1" ChartType="Column" XValueMember="thang_nam" YValueMembers="tongtien"></asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea2">
                                    <AxisX Title="Tháng" Interval="1">
                                        <MajorGrid Enabled="False" />
                                    </AxisX>
                                    <AxisY Title="Nghìn VNĐ">
                                        <MajorGrid Enabled="False" />
                                    </AxisY>
                                </asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>

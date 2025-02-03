<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ThongTinTaiKhoan.aspx.cs" Inherits="TTTT.ThongTinTaiKhoan" %>

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
            margin-right: 10px;
        }
        .khung {
            margin-top: 40px;
        }
        .khung2 {
            margin-top: 20px; /* Điều chỉnh khoảng cách từ phần tử trên xuống */
        }
        .khung3 {
            margin: 20px; /* Điều chỉnh khoảng cách xung quanh các phần tử */
        }
        .khung4 {
            margin-bottom: 30px; /* Điều chỉnh khoảng cách xung quanh các phần tử */
        }
        .khung5 {
            margin-bottom: 20px; /* Điều chỉnh khoảng cách xung quanh các phần tử */
        }
        .background-image {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('background_lavender.jpeg');
            background-size: cover;
            background-position: center;
            filter: blur(5px); /* Điều chỉnh độ nhòe ở đây */
            z-index: -1;
        }
        .overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.4); /* Màu đen với độ mờ */
            z-index: 0;
        }
        .custom-card {
            background-color: #E5E483;
            border-radius: 1rem;
            color: #fff;
            position: relative;
            z-index: 1;
        }
        .custom-card .form-label {
            color: #fff;
        }
        .vh-100 {
            height: 100vh;
            position: relative;
            overflow: hidden;
        }
        .custom-button {
            background-color: #F1F5A8;
            color: #B2B377;
            border: none;
            font-size: 1.25rem; /* Để giữ kích thước chữ lớn */
            padding: 0.5rem 2rem; /* Để giữ padding lớn */
            border-radius: 0.5rem; /* Góc bo tròn */
            transition: background-color 0.3s ease;
        }
        .custom-button:hover {
            background-color: #e2e79a; /* Màu nền khi hover */
        }
        .form-group-custom {
            width: 100%; /* Chỉnh độ rộng của div chứa textbox */
        }
        .button-container .btn-luu, .button-container .btn-huy {
            background-color: #55AD9B; /* Đổi màu nền cho các nút lưu và hủy */
            color: #fff; /* Đổi màu chữ cho các nút lưu và hủy */
            font-size: 15px; /* Điều chỉnh kích thước chữ của các nút */
            border-color: #55AD9B; /* Đổi màu viền cho các nút */
        }
        .auto-style1 {
            display: block;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
            color: #495057;
            background-clip: padding-box;
            border-radius: .25rem;
            transition: none;
            border: 1px solid #ced4da;
            margin-right: 20px;
            margin-bottom: 20px;
            background-color: #fff;
        }
        .auto-style1 input[type="checkbox"] {
            margin-right: 5px; /* Khoảng cách giữa ô checkbox và chữ bên phải */
            margin-left: 5px; /* Khoảng cách giữa ô checkbox và biên trái */
        }

        .auto-style1 label {
            margin-left: 5px; /* Khoảng cách giữa chữ và ô checkbox */
        }
    </style>
    <script type="text/javascript">
        function toggleCheckBoxLists() {
            var ddl = document.getElementById('<%= DropDownList1.ClientID %>');
            var value = ddl.options[ddl.selectedIndex].value;
            var chkBoxList1 = document.getElementById('<%= CheckBoxList1.ClientID %>');
            var chkBoxList2 = document.getElementById('<%= CheckBoxList2.ClientID %>');

            var label1 = document.getElementById('<%= Label1.ClientID %>');
            var label2 = document.getElementById('<%= Label2.ClientID %>');

            if (value == "1") {
                chkBoxList1.style.display = 'block';
                chkBoxList2.style.display = 'block';

                label1.style.display = 'block';
                label2.style.display = 'block';

            } else {
                chkBoxList1.style.display = 'none';
                chkBoxList2.style.display = 'none';

                label1.style.display = 'none';
                label2.style.display = 'none';
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="min-vh-100 d-flex align-items-center justify-content-center" style="background-color: #95D2B3;">
            <div class="bg-white rounded-lg shadow p-5 w-100 container-custom-height" style="max-width: 32rem;">
                <h5 class="text-center font-weight-bold mb-4">THÔNG TIN TÀI KHOẢN</h5>
                <div class="khung">
                    <div class="khung5">
                        <asp:Label ID="txttdn" runat="server" CssClass="text-secondary" Text="Tài khoản: "></asp:Label>
                        <asp:Label ID="txtTendangnhap" runat="server" Text=""></asp:Label>
                    </div>
                    <div>
                        <asp:Label ID="Label6" runat="server" CssClass="text-secondary" Text="Mật khẩu"></asp:Label>
                        <asp:TextBox ID="txtMatkhau" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="(*)" ControlToValidate="txtMatkhau">Mật khẩu không được để trống</asp:RequiredFieldValidator>
                    </div>
                    <div>
                        <asp:Label ID="Label3" runat="server" CssClass="text-secondary" Text="Tên người dùng"></asp:Label>
                        <asp:TextBox ID="txtTennguoidung" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="(*)" ControlToValidate="txtTennguoidung">Tên người dùng không được để trống</asp:RequiredFieldValidator>
                    </div>
                    <div>
                        <asp:Label ID="Label4" runat="server" CssClass="text-secondary" Text="Số điện thoại"></asp:Label>
                        <asp:TextBox ID="txtSdt" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="(*)" ControlToValidate="txtSdt">Số điện thoại không được để trống</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="(*)" ControlToValidate="txtSdt" ValidationExpression="^(0|\+84)\d{9,10}$">Số điện thoại không hợp lệ</asp:RegularExpressionValidator>
                    </div>
                    <div class="khung4">
                        <asp:Label ID="Label5" runat="server" CssClass="text-secondary" Text="Chức vụ"></asp:Label>
                        <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control" Width="187px"></asp:DropDownList>
                    </div>
                    <div class="d-flex">
                        <div>
                            <asp:Label ID="Label1" runat="server" CssClass="text-secondary" Text="Tài khoản"></asp:Label>
                            <asp:CheckBoxList ID="CheckBoxList1" runat="server" CssClass="auto-style1" Width="195px" Height="100px">
                                <asp:ListItem Text="Thêm" Value="30"></asp:ListItem>
                                <asp:ListItem Text="Sửa" Value="21"></asp:ListItem>
                                <asp:ListItem Text="Xóa" Value="6"></asp:ListItem>
                            </asp:CheckBoxList>
                        </div>
                        <div>
                            <asp:Label ID="Label2" runat="server" CssClass="text-secondary" Text="Món"></asp:Label>
                            <asp:CheckBoxList ID="CheckBoxList2" runat="server" CssClass="auto-style1" Width="195px" Height="100px">
                                <asp:ListItem Text="Thêm" Value="30"></asp:ListItem>
                                <asp:ListItem Text="Sửa" Value="21"></asp:ListItem>
                                <asp:ListItem Text="Xóa" Value="6"></asp:ListItem>
                            </asp:CheckBoxList>
                        </div>
                    </div>
                    <div class="d-flex justify-content-center button-container khung">
                        <asp:Button ID="luu" runat="server" CssClass="btn btn-luu btn-warning text-white mr-2" Text="LƯU" OnClick="Luu_Click"/>
                        <asp:Button ID="huy" runat="server" CssClass="btn btn-huy btn-warning text-white mr-2" Text="HỦY" OnClick="Huy_Click" CausesValidation="false"/>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>

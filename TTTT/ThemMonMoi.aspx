<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ThemMonMoi.aspx.cs" Inherits="TTTT.ThemMonMoi" %>

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
            background-color: #fff;
        }
        .file-upload-wrapper {
            position: relative;
            overflow: hidden;
            display: inline-block;
            width: auto; /* Điều chỉnh chiều rộng của wrapper */
        }
        .file-upload-wrapper input[type=file] {
            font-size: 100px;
            position: absolute;
            left: 0;
            top: 0;
            opacity: 0;
        }
        .btn-file-upload {
            width: 100%; /* Đảm bảo nút có kích thước 100% chiều rộng của wrapper */
            padding: .375rem .75rem;
            font-size: 0.875rem; /* Điều chỉnh kích thước font của nút */
            line-height: 1.5;
            background-color: #fff;
            background-clip: padding-box;
            border: 1px solid #ced4da;
            border-radius: .25rem;
            transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
            white-space: nowrap; /* Ngăn chặn text bị ngắt dòng */
            overflow: hidden; /* Đảm bảo văn bản không tràn ra ngoài nút */
            text-overflow: ellipsis; /* Hiển thị dấu ba chấm khi văn bản quá dài */
        }
        .auto-style2 {
            position: relative;
            overflow: hidden;
            display: inline-block;
            height: 39px;
            left: 0px;
            top: 6px;
        }
        /* Thêm viền cho hình ảnh */
        .image-border {
            border: 2px solid #000; /* Đổi màu và độ dày của viền nếu cần */
            padding: 5px; /* Thêm khoảng cách giữa viền và hình ảnh nếu cần */
            border-radius: 10px; /* Thêm bo tròn các góc viền */
        }
        .button-container .btn-luu, .button-container .btn-huy {
            background-color: #55AD9B; /* Màu nền mới */
            color: #fff; /* Màu chữ mới cho nút */
            font-size: 15px; /* Điều chỉnh cỡ chữ của nút */
            border-color: #55AD9B; /* Thêm viền cho nút */
        }
    </style>
    <script type="text/javascript">
        function previewImage() {
            var fileUpload = document.getElementById('<%= FileUpload1.ClientID %>');
            var hinh = document.getElementById('<%= hinh.ClientID %>');

            if (fileUpload.files && fileUpload.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    hinh.src = e.target.result;
                }

                reader.readAsDataURL(fileUpload.files[0]);
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="min-vh-100 d-flex align-items-center justify-content-center" style="background-color: #95D2B3;">
            <div class="bg-white rounded-lg shadow p-5 w-100 h-90" style="max-width: 35rem;">
            <h5 class="text-center font-weight-bold mb-4">THÔNG TIN MÓN</h5>
                <div class="d-flex flex-column align-items-center">
                    <div class="form-group khung">
                        <asp:Image ID="hinh" runat="server" CssClass="image-border" Height="150px" Width="170px" />
                    </div>
                    <div class="form-group">
                        <div class="auto-style2">
                            <asp:FileUpload ID="FileUpload1" runat="server" CssClass="d-none" onchange="previewImage()"/>
                            <button type="button" class="btn btn-outline-secondary btn-file-upload" onclick="document.getElementById('<%=FileUpload1.ClientID %>').click();" style="margin-bottom: 0">Chọn ảnh</button>
                            <asp:Label ID="Label3" runat="server" CssClass="ml-2" Text=""></asp:Label>
                        </div>
                    </div>
                </div>
                <div></div>

                <div class="form-group">
                    <asp:Label ID="Label2" runat="server" CssClass="text-secondary" Text="Tên món"></asp:Label>
                    <asp:TextBox ID="txtTenmon" runat="server" CssClass="auto-style1 form-control" Width="465px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="(*)" ControlToValidate="txtTenmon">Tên món không được để trống</asp:RequiredFieldValidator>
                </div>
                <div class="form-group">
                    <asp:Label ID="Label1" runat="server" CssClass="text-secondary" Text="Giá"></asp:Label>
                    <asp:TextBox ID="txtGia" runat="server" CssClass="auto-style1 form-control" Width="465px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="(*)" ControlToValidate="txtGia">Giá món không được để trống</asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="RangeValidator" MaximumValue="99" MinimumValue="1" Text="Giá phải lớn hơn 0đ" ControlToValidate="txtGia"></asp:RangeValidator>                    
                </div>
                <div class="form-group">
                    <asp:Label ID="Label4" runat="server" CssClass="text-secondary" Text="Từ viết tắt"></asp:Label>
                    <asp:TextBox ID="txtViettat" runat="server" CssClass="auto-style1 form-control" Width="465px"></asp:TextBox>
                </div>
                <div class="form-group">
                    <asp:Label ID="Label5" runat="server" CssClass="text-secondary" Text="Loại món"></asp:Label>
                    <asp:DropDownList ID="DropDownList1" runat="server" CssClass="auto-style1 form-control" Width="253px"></asp:DropDownList>
                </div>
                <div class="d-flex justify-content-center khung button-container">
                    <asp:Button ID="luu" runat="server" CssClass="btn btn-luu btn-warning text-white mr-2" Text="LƯU" OnClick="Luu_Click"/>
                    <asp:Button ID="huy" runat="server" CssClass="btn btn-luu btn-warning text-white mr-2" Text="HỦY" OnClick="Huy_Click" CausesValidation="false"/>
                </div>
            </div>
        </div>
    </form>
</body>
</html>

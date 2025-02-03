<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="TTTT.DangNhap" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <style>
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
            background-color: #95D2B3; /* Màu nền mới của custom-card */
            border-radius: 1rem;
            color: #fff;
            position: relative;
            z-index: 1;
        }
        .custom-card .form-label {
            color: #fff; /* Màu chữ cho nhãn form */
        }
        .vh-100 {
            height: 100vh;
            position: relative;
            overflow: hidden;
        }
        .custom-button {
            background-color: #ffffff;
            color: #95D2B3; /* Màu chữ mới cho nút */
            border: none;
            font-size: 1.25rem; /* Để giữ kích thước chữ lớn */
            padding: 0.5rem 2rem; /* Để giữ padding lớn */
            border-radius: 0.5rem; /* Góc bo tròn */
            transition: background-color 0.3s ease;
        }
        .custom-button:hover {
            background-color: #e2e79a; /* Màu nền khi hover */
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <section class="vh-100">
            <div class="background-image"></div>
            <div class="overlay"></div>
            <div class="container py-5 h-120">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-12 col-md-8 col-lg-6 col-xl-5">
                        <div class="card custom-card">
                            <div class="card-body p-5 text-center">
                                <div class="mb-md-5 mt-md-4 pb-5">
                                    <h2 class="fw-bold mb-2 text-uppercase">LAVENDER COFFEE</h2>
                                    <p class="text-white-50 mb-5">Vui lòng nhập vào tên đăng nhập và mật khẩu</p>

                                    <div class="form-group form-white mb-4 text-left">
                                        <label class="form-label" for="typeEmailX">Tên đăng nhập</label>
                                        <asp:TextBox ID="txttendangnhap" runat="server" CssClass="form-control form-control-lg"/>
                                     </div>

                                     <div class="form-group form-white mb-4 text-left">
                                        <label class="form-label" for="TextBox1">Mật khẩu</label>
                                        <asp:TextBox ID="txtmatkhau" runat="server" CssClass="form-control form-control-lg" TextMode="Password" />
                                     </div>
                                     <asp:Button ID="btndangnhap" runat="server" Text="Đăng nhập" CssClass="custom-button" OnClick="btndangnhap_Click" />
                                    
                                    <div style="text-align: center;">
                                        <asp:Label ID="lblThongBao" runat="server" Text=" "></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </form>
</body>
</html>


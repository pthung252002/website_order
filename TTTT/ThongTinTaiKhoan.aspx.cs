using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TTTT
{
    public partial class ThongTinTaiKhoan : System.Web.UI.Page
    {
        public string tendangnhap;
        public clsTaiKhoan clstaikhoan;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                tendangnhap = Request.QueryString["tk_tendangnhap"].ToString();
                clstaikhoan = layThongTinTaiKhoan(tendangnhap);
                BindDropDown();

                txtTendangnhap.Text = clstaikhoan.tendangnhap;
                txtMatkhau.Text = clstaikhoan.matkhau;
                txtTennguoidung.Text = clstaikhoan.tennguoidung;
                txtSdt.Text = clstaikhoan.sdt;
                DropDownList1.SelectedValue = clstaikhoan.ltk_id.ToString();

                if (tendangnhap == "admin")
                {
                    DropDownList1.Visible = false;
                    Label5.Visible = false; // Ẩn cả label của DropDownList

                    CheckBoxList1.Visible = false;
                    Label1.Visible = false;

                    CheckBoxList2.Visible = false;
                    Label2.Visible = false;
                }
                else
                {
                    DropDownList1.SelectedValue = clstaikhoan.ltk_id.ToString();
                }

                // Xác định checkbox trong CheckboxList1 dựa trên giá trị của clstaikhoan.Qtk
                UpdateCheckBoxList_tk(clstaikhoan.Qtk);
                UpdateCheckBoxList_mon(clstaikhoan.Qmon);
            }

            // Thêm script gọi hàm JavaScript toggleCheckBoxLists() khi trang tải
            ClientScript.RegisterStartupScript(this.GetType(), "toggleCheckBoxLists", "toggleCheckBoxLists();", true);
            DropDownList1.Attributes.Add("onchange", "toggleCheckBoxLists()");
        }


        private clsTaiKhoan layThongTinTaiKhoan(string tendangnhap)
        {
            clsTaiKhoan clsTK = new clsTaiKhoan();
            clsDatabase.OpenConnection();

            SqlCommand com = new SqlCommand("EXEC thongtin_tk @tk_tendangnhap", clsDatabase.con);

            com.Parameters.AddWithValue("@tk_tendangnhap", tendangnhap);

            SqlDataReader reader = com.ExecuteReader();

            if (reader.Read())
            {
                clsTK.tendangnhap = reader["tk_tendangnhap"].ToString();
                clsTK.matkhau = reader["tk_matkau"].ToString();
                clsTK.tennguoidung = reader["tk_tennguoidung"].ToString();
                clsTK.sdt = reader["tk_sdt"].ToString();
                clsTK.Qtk = int.Parse(reader["tk_Qtk"].ToString());
                clsTK.Qmon = int.Parse(reader["tk_Qmon"].ToString());
                clsTK.ltk_id = int.Parse(reader["ltk_id"].ToString());
            }

            clsDatabase.CloseConnection();
            return clsTK;
        }

        private void BindDropDown()
        {
            clsDatabase.OpenConnection();
            SqlCommand com = new SqlCommand("SELECT * FROM loaitaikhoan", clsDatabase.con);

            SqlDataReader reader = com.ExecuteReader();
            DropDownList1.DataSource = reader;
            DropDownList1.DataTextField = "ltk_ten";
            DropDownList1.DataValueField = "ltk_id";
            DropDownList1.DataBind();

            clsDatabase.CloseConnection();
        }

        protected void Luu_Click(object sender, EventArgs e)
        {
            string currentUser = Session["tendangnhap"] as string;
            clsDatabase.OpenConnection();

            SqlCommand com = new SqlCommand("EXEC chinhsua_taikhoan @tk_tendangnhap, @tk_matkhau, @tk_tennguoidung"
                            + ", @tk_sdt, @tk_Qtk, @tk_Qmon, @ltk_id", clsDatabase.con);

            SqlParameter p = new SqlParameter("@tk_tendangnhap", SqlDbType.VarChar);
            SqlParameter p2 = new SqlParameter("@tk_matkhau", SqlDbType.VarChar);
            SqlParameter p3 = new SqlParameter("@tk_tennguoidung", SqlDbType.NVarChar);
            SqlParameter p4 = new SqlParameter("@tk_sdt", SqlDbType.VarChar);
            SqlParameter p5 = new SqlParameter("@ltk_id", SqlDbType.Int);
            SqlParameter p6 = new SqlParameter("@tk_Qtk", SqlDbType.Int);
            SqlParameter p7 = new SqlParameter("@tk_Qmon", SqlDbType.Int);

            p.Value = txtTendangnhap.Text;
            p2.Value = txtMatkhau.Text;
            p3.Value = txtTennguoidung.Text;
            p4.Value = txtSdt.Text;
            p5.Value = int.Parse(DropDownList1.SelectedValue.ToString());
            p6.Value = tinh_Qtk();
            p7.Value = tinh_Qmon();

            com.Parameters.Add(p);
            com.Parameters.Add(p2);
            com.Parameters.Add(p3);
            com.Parameters.Add(p4);
            com.Parameters.Add(p5);
            com.Parameters.Add(p6);
            com.Parameters.Add(p7);

            SqlDataReader reader = com.ExecuteReader();

            if (reader.Read())
            {
                if (int.Parse(reader["ltk_id"].ToString()) == 1)
                {
                    clsDatabase.CloseConnection();

                    Response.Redirect("TaiKhoan.aspx");
                }
                else if (int.Parse(reader["ltk_id"].ToString()) == 2 && currentUser == "admin")
                {
                    clsDatabase.CloseConnection();

                    Response.Redirect("TaiKhoan.aspx");
                }
                else
                {
                    Session.Clear();
                    Session.Abandon();
                    clsDatabase.CloseConnection();

                    // Hiển thị thông báo
                    Response.Write("<script>alert('Vui lòng đăng nhập lại!');</script>");
                    Response.Flush(); // Đảm bảo thông báo được gửi tới trình duyệt

                    // Chuyển hướng về trang đăng nhập
                    ClientScript.RegisterStartupScript(this.GetType(), "redirect", "window.location.href = 'DangNhap.aspx';", true);
                }
            }
        }

        public int tinh_Qtk()
        {
            int qtk = 0;
            int countChecked = 0;

            foreach (ListItem item in CheckBoxList1.Items)
            {
                if (item.Selected)
                {
                    qtk += int.Parse(item.Value);
                    countChecked++;
                }
            }

            if (countChecked == 0)
            {
                qtk = 0;
            }
            return qtk;
        }

        public int tinh_Qmon()
        {
            int qmon = 0;
            int countChecked = 0;

            foreach (ListItem item in CheckBoxList2.Items)
            {
                if (item.Selected && float.TryParse(item.Value, out float itemValue))
                {
                    qmon += int.Parse(item.Value);
                    countChecked++;
                }
            }

            if (countChecked == 0)
            {
                qmon = 0;
            }
            return qmon;
        }

        private void UpdateCheckBoxList_tk(int qtkValue)
        {
            foreach (ListItem item in CheckBoxList1.Items)
            {
                int value = int.Parse(item.Value);
                // Kiểm tra nếu giá trị của checkbox nằm trong phạm vi của qtkValue, thì check vào đó
                if (qtkValue >= value)
                {
                    item.Selected = true;
                    qtkValue -= value;
                }
                // Nếu qtkValue đã không còn giá trị nào để check, thoát vòng lặp
                if (qtkValue <= 0)
                    break;
            }
        }

        private void UpdateCheckBoxList_mon(int qmonValue)
        {
            foreach (ListItem item in CheckBoxList2.Items)
            {
                int value = int.Parse(item.Value);
                // Kiểm tra nếu giá trị của checkbox nằm trong phạm vi của qtkValue, thì check vào đó
                if (qmonValue >= value)
                {
                    item.Selected = true;
                    qmonValue -= value;
                }
                // Nếu qtkValue đã không còn giá trị nào để check, thoát vòng lặp
                if (qmonValue <= 0)
                    break;
            }
        }

        protected void Huy_Click(object sender, EventArgs e)
        {
            Response.Redirect("TaiKhoan.aspx");
        }
    }
}

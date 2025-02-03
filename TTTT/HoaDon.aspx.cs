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
    public partial class HoaDon : System.Web.UI.Page
    {
        SqlDataAdapter adapter;
        DataTable datatable;

        string hd_id_moi;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ltk_id"] == null || Convert.ToInt32(Session["ltk_id"]) != 1)
            {
                // Ẩn phần quản lý nếu ltk_id khác 1
                QuanLyMenu.Visible = false;
            }

            if (!IsPostBack)
            {
                BindListView();
            }
        }

        private void BindListView()
        {
            datatable = new DataTable();
            clsDatabase.OpenConnection();

            SqlCommand com = new SqlCommand("EXEC indanhsach;", clsDatabase.con);
            adapter = new SqlDataAdapter(com);

            adapter.Fill(datatable);
            ListView1.DataSource = datatable;
            ListView1.DataBind();

            clsDatabase.CloseConnection();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Xóa thông tin phiên làm việc của người dùng
            Session.Clear();
            Session.Abandon();

            // Chuyển hướng về trang đăng nhập
            Response.Redirect("DangNhap.aspx");
        }

        protected void ThemHoaDonMoi_Click(object sender, ImageClickEventArgs e)
        {
            clsDatabase.OpenConnection();
            SqlCommand com = new SqlCommand("EXEC them_hd @tendangnhap", clsDatabase.con);
            com.Parameters.AddWithValue("@tendangnhap", Session["tendangnhap"]);

            SqlDataReader reader = com.ExecuteReader();

            if (reader.Read())
            {
                hd_id_moi = reader["hd_id_moi"].ToString();
            }

            // Thực hiện chuyển hướng đến trang ChinhSuaHoaDon.aspx
            Response.Redirect("ChiTietHoaDon.aspx?hd_id=" + hd_id_moi);
        }

        protected void ThanhToanHoaDon_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int hd_id = int.Parse(btn.CommandArgument);
            clsDatabase.OpenConnection();

            SqlCommand com = new SqlCommand("EXEC thanhtoan @hd_id", clsDatabase.con);

            SqlParameter p = new SqlParameter("@hd_id", SqlDbType.Int);
            p.Value = hd_id;
            com.Parameters.Add(p);

            com.ExecuteReader();
            clsDatabase.CloseConnection();

            BindListView();

        }


        protected void XemHoaDon_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string hd_id = btn.CommandArgument;

            // Chuyển hướng sang trang ChinhSuaHoaDon.aspx và truyền giá trị hd_id qua URL
            Response.Redirect("ChiTietHoaDon.aspx?hd_id=" + hd_id);
        }

        protected void XoaHoaDon_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int hd_id = int.Parse(btn.CommandArgument);

            clsDatabase.OpenConnection();
            SqlCommand com = new SqlCommand("EXEC xoa_hd @hd_id;", clsDatabase.con);
            com.Parameters.AddWithValue("@hd_id", hd_id);

            com.ExecuteNonQuery();

            clsDatabase.CloseConnection();
            BindListView();
        }


    }
}
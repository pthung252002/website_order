using DocumentFormat.OpenXml.Office2010.Excel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TTTT
{
    public partial class LichSuThanhToan : System.Web.UI.Page
    {
        SqlDataAdapter adapter;
        SqlDataAdapter adapter1;
        SqlDataAdapter adapter2;
        SqlDataAdapter adapter_mon;

        DataTable datatable;
        DataTable datatable1;
        DataTable datatable2;
        DataTable datatable_mon;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ltk_id"] == null || Convert.ToInt32(Session["ltk_id"]) != 1)
            {
                // Ẩn phần quản lý nếu ltk_id khác 1
                QuanLyMenu.Visible = false;
            }

            if (!IsPostBack)
            {
                DropDownList1.SelectedValue = "1";
                BindListView(1);
            }
        }

        private void BindListView(int hd_trangthai)
        {
            datatable = new DataTable();
            clsDatabase.OpenConnection();

            SqlCommand com = new SqlCommand("indanhsach_hd_trangthai @hd_trangthai ", clsDatabase.con);
            SqlParameter p = new SqlParameter("@hd_trangthai", SqlDbType.Int);
            p.Value = hd_trangthai;
            com.Parameters.Add(p);

            adapter = new SqlDataAdapter(com);

            adapter.Fill(datatable);
            ListView1.DataSource = datatable;
            ListView1.DataBind();

            clsDatabase.CloseConnection();
        }

        private void BindReapter(int hd_id)
        {
            datatable_mon = new DataTable();
            clsDatabase.OpenConnection();

            SqlCommand com = new SqlCommand("EXEC in_ct_thongtin_hd @hd_id", clsDatabase.con);
            SqlParameter p = new SqlParameter("@hd_id", SqlDbType.Int);
            p.Value = hd_id;
            com.Parameters.Add(p);
            adapter_mon = new SqlDataAdapter(com);

            adapter_mon.Fill(datatable_mon);
            Repeater1.DataSource = datatable_mon;
            Repeater1.DataBind();

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

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindListView(int.Parse(DropDownList1.SelectedValue.ToString()));
        }

        protected void btnngay_Click(object sender, ImageClickEventArgs e)
        {
            // Kiểm tra xem datepicker1 và datepicker2 đã được điền gì chưa
            if (!string.IsNullOrEmpty(datepicker1.Value) && !string.IsNullOrEmpty(datepicker2.Value))
            {
                DateTime date1;
                DateTime date2;

                // Thử parse các giá trị của datepicker
                bool isDate1Valid = DateTime.TryParse(datepicker1.Value, out date1);
                bool isDate2Valid = DateTime.TryParse(datepicker2.Value, out date2);

                if (isDate1Valid && isDate2Valid)
                {
                    datatable1 = new DataTable();
                    clsDatabase.OpenConnection();

                    SqlCommand com = new SqlCommand("EXEC indanhsach_hd_trangthai_ngay @hd_trangthai, @date1, @date2;", clsDatabase.con);

                    SqlParameter p1 = new SqlParameter("@date1", SqlDbType.Date);
                    SqlParameter p2 = new SqlParameter("@date2", SqlDbType.Date);
                    SqlParameter p3 = new SqlParameter("@hd_trangthai", SqlDbType.Int);

                    p1.Value = date1;
                    p2.Value = date2;
                    p3.Value = int.Parse(DropDownList1.SelectedValue.ToString());

                    com.Parameters.Add(p1);
                    com.Parameters.Add(p2);
                    com.Parameters.Add(p3);

                    adapter1 = new SqlDataAdapter(com);
                    adapter1.Fill(datatable1);

                    ListView1.DataSource = datatable1;
                    ListView1.DataBind();

                    clsDatabase.CloseConnection();
                }
                else
                {
                    // Nếu không parse được ngày, hiển thị modal lỗi
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#daterongModal').modal('show');", true);
                }
            }
            else
            {
                // Nếu datepicker1 hoặc datepicker2 bị bỏ trống, hiển thị modal lỗi
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#daterongModal').modal('show');", true);
            }
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton btn = (ImageButton)sender;
            int hd_id = int.Parse(btn.CommandArgument); // Lấy giá trị của thuộc tính CommandArgument

            datatable2 = new DataTable();
            clsDatabase.OpenConnection();

            SqlCommand com = new SqlCommand("EXEC in_thongtin_hd @hd_id;", clsDatabase.con);
            SqlParameter p = new SqlParameter("@hd_id", SqlDbType.Int);
            p.Value = hd_id;
            com.Parameters.Add(p);

            SqlDataReader reader = com.ExecuteReader();

            if (reader.Read())
            {
                txtMa.Text = reader["hd_id"].ToString();
                txtTglap.Text = reader["hd_thoigianlap"].ToString();
                txtTgtt.Text = reader["hd_thoigianthanhtoan"].ToString();

                if (int.Parse(reader["ban_stt"].ToString()) <= 10)
                {
                    txtBan.Text = " Trệt - " + reader["ban_stt"].ToString();
                }
                else
                {
                    txtBan.Text = " Lầu - " + reader["ban_stt"].ToString();
                }

                txtTendangnhap.Text = reader["tk_tennguoidung"].ToString();
                txtMota.Text = reader["hd_mota"].ToString();
                tong_tien.Text = "Tổng: " + reader["hd_tongtien"].ToString() + ".000đ";
            }

            //bind reapter
            BindReapter(hd_id);

            clsDatabase.CloseConnection();
        }
    }
}

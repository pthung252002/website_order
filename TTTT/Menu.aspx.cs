using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DocumentFormat.OpenXml.Wordprocessing;

namespace TTTT
{
    public partial class Menu : System.Web.UI.Page
    {
        DataTable datatable;
        SqlDataAdapter adapter;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ltk_id"] == null || Convert.ToInt32(Session["ltk_id"]) != 1)
            {
                // Ẩn phần quản lý nếu ltk_id khác 1
                QuanLyMenu.Visible = false;
            }

            if (!IsPostBack)
            {
                BindListView(0);
                DropDownList1.SelectedIndex = 0;
            }
        }

        private void BindListView(int lm_id)
        {
            datatable = new DataTable();
            clsDatabase.OpenConnection();

            SqlCommand com = new SqlCommand("EXEC indanhsach_mon @lm_id;", clsDatabase.con);
            SqlParameter p = new SqlParameter("@lm_id", SqlDbType.Int);
            p.Value = lm_id;
            com.Parameters.Add(p);

            adapter = new SqlDataAdapter(com);

            adapter.Fill(datatable);
            ListViewMenu.DataSource = datatable;
            ListViewMenu.DataBind();

            clsDatabase.CloseConnection();
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindListView(int.Parse(DropDownList1.SelectedValue.ToString()));
        }

        protected void ListViewMenu_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                DataRowView rowView = (DataRowView)e.Item.DataItem;
                Image hinh = (Image)e.Item.FindControl("hinh");

                if (rowView["mon_hinh"] != DBNull.Value)
                {
                    byte[] imageData = (byte[])rowView["mon_hinh"];
                    string base64String = Convert.ToBase64String(imageData, 0, imageData.Length);
                    hinh.ImageUrl = "data:image/png;base64," + base64String;
                }
                else
                {
                    // Xử lý nếu không có hình ảnh trong cơ sở dữ liệu
                    hinh.ImageUrl = "blank-img.jpg"; // Đặt URL mặc định hoặc ảnh rỗng
                }
            }
        }
        protected void ThemMon_Click(object sender, EventArgs e)
        {
            int ltk_id = int.Parse(Session["ltk_id"].ToString());
            string tk_Qmon = Session["tk_Qmon"].ToString();
            if ((tk_Qmon == "30" || tk_Qmon == "36" || tk_Qmon == "51" || tk_Qmon == "57") && ltk_id == 1)
            {
                Response.Redirect("ThemMonMoi.aspx");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#chucnangModal').modal('show');", true);
            }
        }

        protected void XemMon_Click(object sender, EventArgs e)
        {
            string mon_id = ((Button)sender).CommandArgument;
            int ltk_id = int.Parse(Session["ltk_id"].ToString());
            string tk_Qmon = Session["tk_Qmon"].ToString();
            if ((tk_Qmon == "21" || tk_Qmon == "27" || tk_Qmon == "51" || tk_Qmon == "57") && ltk_id == 1)
            {
                Response.Redirect("ThongTinMon.aspx?mon_id=" + mon_id);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#chucnangModal').modal('show');", true);
            }
        }

        protected void txtTimKiem_TextChanged(object sender, EventArgs e)
        {
            string query;

            if (txtTiemKiem.Text == "")
            {
                query = "EXEC indanhsach_mon 0";
            }
            else
            {
                query = "EXEC timkiem_mon @mon_ten";
            }

            DataTable datatable = new DataTable();
            clsDatabase.OpenConnection();

            SqlCommand com = new SqlCommand(query, clsDatabase.con);
            com.Parameters.AddWithValue("@mon_ten", txtTiemKiem.Text);

            SqlDataAdapter adapter = new SqlDataAdapter(com);
            adapter.Fill(datatable);

            ListViewMenu.DataSource = datatable;
            ListViewMenu.DataBind();

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

    }
}
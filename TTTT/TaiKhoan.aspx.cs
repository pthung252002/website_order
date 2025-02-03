using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services.Description;

namespace TTTT
{
    public partial class TaiKhoan : System.Web.UI.Page
    {
        SqlDataAdapter adapter;
        DataTable datatable;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ltk_id"] == null || Convert.ToInt32(Session["ltk_id"]) != 1)
            {
                // Ẩn phần quản lý nếu ltk_id khác 1
                QuanLyMenu.Visible = false;
            }

            if (!IsPostBack)
            {
                BindListView(1);
            }
        }

        private void BindListView(int tk_trangthai)
        {
            datatable = new DataTable();
            clsDatabase.OpenConnection();

            SqlCommand com = new SqlCommand("EXEC indanhsach_taikhoan @tk_trangthai;", clsDatabase.con);
            SqlParameter p = new SqlParameter("@tk_trangthai", SqlDbType.Int);
            p.Value = tk_trangthai;
            com.Parameters.Add(p);

            adapter = new SqlDataAdapter(com);

            adapter.Fill(datatable);
            ListView1.DataSource = datatable;
            ListView1.DataBind();

            clsDatabase.CloseConnection();
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindListView(int.Parse(DropDownList1.SelectedValue.ToString()));
        }

        protected bool IsAdmin2(object ltk_ten)
        {
            if (ltk_ten != null && ltk_ten.ToString() == "Quản lý")
            {
                return true;
            }
            return false;
        }

        protected bool IsAdmin3(string tendangnhap)
        {
            if (tendangnhap == "admin")
            {
                return true;
            }
            return false;
        }

        protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                DataRowView drv = (DataRowView)e.Item.DataItem;
                string tk_tendangnhap = drv["tk_tendangnhap"].ToString();
                int tk_trangthai = Convert.ToInt32(drv["tk_trangthai"]);

                ImageButton chinhsuatk = (ImageButton)e.Item.FindControl("chinhsuatk");
                ImageButton xoataikhoan = (ImageButton)e.Item.FindControl("xoataikhoan");
                ImageButton huyxoataikhoan = (ImageButton)e.Item.FindControl("huyxoataikhoan");

                // Hiển thị chinhsuatk cho mọi tk_tendangnhap
                chinhsuatk.Visible = true;

                // Quyết định hiển thị xoataikhoan hoặc huyxoataikhoan dựa vào tk_trangthai
                if (tk_trangthai == 1)
                {
                    xoataikhoan.Visible = true;
                    huyxoataikhoan.Visible = false;
                }
                else if (tk_trangthai == 0)
                {
                    xoataikhoan.Visible = false;
                    huyxoataikhoan.Visible = true;
                }

                // Ẩn xoataikhoan và huyxoataikhoan nếu tk_tendangnhap là "admin"
                if (tk_tendangnhap == "admin")
                {
                    xoataikhoan.Visible = false;
                    huyxoataikhoan.Visible = false;
                    // Hiển thị chinhsuatk nếu Session["tk_tendangnhap"] cũng là "admin"
                    if ((Session["tk_tendangnhap"] as string) == "admin")
                    {
                        chinhsuatk.Visible = true;
                    }
                }
            }
        }



        protected bool CanEdit(string tk_tendangnhap)
        {
            string currentUser = Session["tendangnhap"] as string;
            if (tk_tendangnhap == "admin")
            {
                return currentUser == "admin";
            }
            return true; // Hiển thị cho tất cả các tài khoản khác
        }

        protected bool CanNotDelete(string tk_tendangnhap)
        {
            string currentUser = Session["tendangnhap"] as string;

            // Thực hiện các điều kiện để xác định có hiển thị ImageButton xoataikhoan và huxoataikhoan hay không
            if (tk_tendangnhap == "admin")
            {
                return false; // Không hiển thị nếu là admin
            }
            else if (currentUser == tk_tendangnhap)
            {
                return false; // Không hiển thị nếu là người dùng hiện tại
            }
            else
            {
                return true; // Hiển thị cho tất cả các tài khoản khác
            }
        }

        protected void ThemTaiKhoan_Click(object sender, EventArgs e)
        {
            string tk_Qtk = Session["tk_Qtk"].ToString();
            if (tk_Qtk == "30" || tk_Qtk == "36" || tk_Qtk == "51" || tk_Qtk == "57")
            {
                Response.Redirect("TaiKhoanMoi.aspx");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#chucnangModal').modal('show');", true);
            }
        }


        protected void XoaTaiKhoan_Click(object sender, EventArgs e)
        {
            string currentUser = Session["tendangnhap"] as string;

            ImageButton btn = (ImageButton)sender;
            string tk_tendangnhap = btn.CommandArgument;

            string tk_Qtk = Session["tk_Qtk"].ToString();

            if (tk_Qtk == "6" || tk_Qtk == "27" || tk_Qtk == "36" || tk_Qtk == "57")
            {
                clsDatabase.OpenConnection();

                SqlCommand com = new SqlCommand("EXEC xoa_taikhoan @tk_tendangnhap", clsDatabase.con);
                com.Parameters.AddWithValue("@tk_tendangnhap", tk_tendangnhap);

                if (currentUser == tk_tendangnhap)
                {
                    com.ExecuteNonQuery();
                    // Xóa thông tin phiên làm việc của người dùng
                    Session.Clear();
                    Session.Abandon();

                    // Hiển thị thông báo
                    Response.Write("<script>alert('Vui lòng đăng nhập lại!');</script>");
                    Response.Flush(); // Đảm bảo thông báo được gửi tới trình duyệt

                    // Chuyển hướng về trang đăng nhập
                    ClientScript.RegisterStartupScript(this.GetType(), "redirect", "window.location.href = 'DangNhap.aspx';", true);

                    clsDatabase.CloseConnection();
                }
                else
                {
                    com.ExecuteNonQuery();

                    clsDatabase.CloseConnection();
                    BindListView(1);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#chucnangModal').modal('show');", true);
            }
        }

        protected void Un_XoaTaiKhoan_Click(object sender, EventArgs e)
        {
            string currentUser = Session["tendangnhap"] as string;

            ImageButton btn = (ImageButton)sender;
            string tk_tendangnhap = btn.CommandArgument;

            string tk_Qtk = Session["tk_Qtk"].ToString();
            if (tk_Qtk == "21" || tk_Qtk == "27" || tk_Qtk == "51" || tk_Qtk == "57")
            {
                clsDatabase.OpenConnection();

                SqlCommand com = new SqlCommand("EXEC un_xoa_taikhoan @tk_tendangnhap", clsDatabase.con);
                com.Parameters.AddWithValue("@tk_tendangnhap", tk_tendangnhap);
                com.ExecuteNonQuery();

                clsDatabase.CloseConnection();
                BindListView(0);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#chucnangModal').modal('show');", true);
            }
        }

        protected void ChinhSuaTaiKhoan_Click(object sender, EventArgs e)
        {
            ImageButton btn = (ImageButton)sender;
            string tk_tendangnhap = btn.CommandArgument;

            string tk_Qtk = Session["tk_Qtk"].ToString();
            if (tk_Qtk == "21" || tk_Qtk == "27" || tk_Qtk == "51" || tk_Qtk == "57")
            {
                Response.Redirect("ThongTinTaiKhoan.aspx?tk_tendangnhap=" + tk_tendangnhap);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#chucnangModal').modal('show');", true);
            }
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
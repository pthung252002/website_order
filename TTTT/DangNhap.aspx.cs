using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TTTT
{
    public partial class DangNhap : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btndangnhap_Click(object sender, EventArgs e)
        {
            string tenDangNhap = txttendangnhap.Text;
            string matKhau = txtmatkhau.Text;

            if (clsDatabase.OpenConnection())
            {
                SqlCommand cmd = new SqlCommand("SELECT tk_matkau, tk_tennguoidung, tk_Qtk, tk_Qmon, tk_trangthai, ltk_id FROM TaiKhoan WHERE tk_tendangnhap = @TenDangNhap", clsDatabase.con);
                cmd.Parameters.AddWithValue("@TenDangNhap", tenDangNhap);

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    string matKhauDb = reader["tk_matkau"].ToString();
                    int tk_Qtk = Convert.ToInt32(reader["tk_Qtk"]);
                    int tk_Qmon = Convert.ToInt32(reader["tk_Qmon"]);
                    int ltkId = Convert.ToInt32(reader["ltk_id"]);
                    int tk_trangthai = Convert.ToInt32(reader["tk_trangthai"]);

                    if (matKhauDb == matKhau)
                    {
                        if (tk_trangthai == 1)
                        {
                            Session["tendangnhap"] = tenDangNhap;
                            Session["ltk_id"] = ltkId;
                            Session["tk_Qtk"] = tk_Qtk;
                            Session["tk_Qmon"] = tk_Qmon;
                            Response.Redirect("HoaDon.aspx");
                        }
                        else
                        {
                            lblThongBao.Text = "Tài khoản đã bị khóa!";
                        }
                    }
                    else
                    {
                        lblThongBao.Text = "Sai mật khẩu!";
                    }
                }
                else
                {
                    lblThongBao.Text = "Tài khoản không tồn tại!";
                }

                reader.Close();
                clsDatabase.CloseConnection();
            }
            else
            {
                lblThongBao.Text = "Không thể kết nối đến cơ sở dữ liệu";
            }
        }
    }
}
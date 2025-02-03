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
    public partial class TaiKhoanMoi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDropDown();
            }
            txtTendangnhap.Focus();
            ClientScript.RegisterStartupScript(this.GetType(), "toggleCheckBoxLists", "toggleCheckBoxLists();", true);
            DropDownList1.Attributes.Add("onchange", "toggleCheckBoxLists()");
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

        protected void Tao_Click(object sender, EventArgs e)
        {
            clsDatabase.OpenConnection();

            SqlCommand com = new SqlCommand("SELECT tk_tendangnhap FROM taikhoan WHERE tk_tendangnhap = @tk_tendangnhap", clsDatabase.con);

            SqlParameter p = new SqlParameter("@tk_tendangnhap", SqlDbType.VarChar);
            p.Value = txtTendangnhap.Text;
            com.Parameters.Add(p);

            SqlDataReader reader = com.ExecuteReader();

            if (reader.Read())
            {
                reader.Close();
                txtThongbao.Text = "Tài Khoản đã tồn tại";
                txtTendangnhap.Text = "";
                txtTendangnhap.Focus();
            }
            else
            {
                reader.Close();

                SqlCommand com2 = new SqlCommand("EXEC tao_taikhoan @tk_tendangnhap, @tk_matkhau, @tk_tennguoidung, @tk_sdt, @tk_Qtk, @tk_Qmon, @ltk_id", clsDatabase.con);

                SqlParameter p1 = new SqlParameter("@tk_tendangnhap", SqlDbType.VarChar);
                SqlParameter p2 = new SqlParameter("@tk_matkhau", SqlDbType.VarChar);
                SqlParameter p3 = new SqlParameter("@tk_tennguoidung", SqlDbType.NVarChar);
                SqlParameter p4 = new SqlParameter("@tk_sdt", SqlDbType.VarChar);
                SqlParameter p5 = new SqlParameter("@ltk_id", SqlDbType.Int);
                SqlParameter p6 = new SqlParameter("@tk_Qtk", SqlDbType.Int);
                SqlParameter p7 = new SqlParameter("@tk_Qmon", SqlDbType.Int);

                p1.Value = txtTendangnhap.Text;
                p2.Value = txtMatkhau.Text;
                p3.Value = txtTennguoidung.Text;
                p4.Value = txtSdt.Text;
                p5.Value = int.Parse(DropDownList1.SelectedValue.ToString());
                p6.Value = tinh_Qtk();
                p7.Value = tinh_Qmon();

                com2.Parameters.Add(p1);
                com2.Parameters.Add(p2);
                com2.Parameters.Add(p3);
                com2.Parameters.Add(p4);
                com2.Parameters.Add(p5);
                com2.Parameters.Add(p6);
                com2.Parameters.Add(p7);


                com2.ExecuteNonQuery();
                clsDatabase.CloseConnection();

                Response.Redirect("TaiKhoan.aspx");
            }
            clsDatabase.CloseConnection();
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
                if (item.Selected)
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

        protected void Huy_Click(object sender, EventArgs e)
        {
            Response.Redirect("TaiKhoan.aspx");
        }

    }
}
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TTTT
{
    public partial class ThemMonMoi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDropDown();
                hinh.ImageUrl = "blank-img.jpg";
            }
        }

        private void BindDropDown()
        {
            clsDatabase.OpenConnection();
            SqlCommand com = new SqlCommand("SELECT * FROM loaimon", clsDatabase.con);

            SqlDataReader reader = com.ExecuteReader();
            DropDownList1.DataSource = reader;
            DropDownList1.DataTextField = "lm_ten";
            DropDownList1.DataValueField = "lm_id";
            DropDownList1.DataBind();

            clsDatabase.CloseConnection();
        }

        protected void Luu_Click(object sender, EventArgs e)
        {

            clsDatabase.OpenConnection();

            SqlCommand com = new SqlCommand("EXEC them_mon @mon_ten, @mon_gia, @mon_viettat, @lm_id, @mon_hinh", clsDatabase.con);

            SqlParameter p2 = new SqlParameter("@mon_ten", SqlDbType.NVarChar);
            SqlParameter p3 = new SqlParameter("@mon_gia", SqlDbType.Float);
            SqlParameter p4 = new SqlParameter("@mon_viettat", SqlDbType.NVarChar);
            SqlParameter p5 = new SqlParameter("@lm_id", SqlDbType.Int);
            SqlParameter p6 = new SqlParameter("@mon_hinh", SqlDbType.VarBinary);

            p2.Value = txtTenmon.Text;
            p3.Value = (int)float.Parse(txtGia.Text);
            p4.Value = txtViettat.Text;
            p5.Value = int.Parse(DropDownList1.SelectedValue.ToString());

            if (FileUpload1.HasFile)
            {
                byte[] fileData = FileUpload1.FileBytes;

                p6.Value = fileData;
            }
            else
            {
                // Nếu không có tệp hình ảnh, sử dụng ảnh mặc định
                string defaultImagePath = Server.MapPath("blank-img.jpg");
                byte[] defaultImageData = File.ReadAllBytes(defaultImagePath);
                p6.Value = defaultImageData;
            }

            com.Parameters.Add(p2);
            com.Parameters.Add(p3);
            com.Parameters.Add(p4);
            com.Parameters.Add(p5);
            com.Parameters.Add(p6);

            com.ExecuteNonQuery();

            clsDatabase.CloseConnection();

            Session.Remove("mon_hinh");
            Response.Redirect("Menu.aspx");
        }

        protected void Huy_Click(object sender, EventArgs e)
        {
            Response.Redirect("Menu.aspx");
        }
    }
}
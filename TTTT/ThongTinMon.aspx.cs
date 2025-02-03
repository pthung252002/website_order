using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TTTT
{
    public partial class ThongTinMon : System.Web.UI.Page
    {
        int mon_id_moi;
        public int mon_id;
        public clsMon clsmon;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                mon_id = int.Parse(Request.QueryString["mon_id"].ToString());
                BindDropDown();

                layThongTinMon(mon_id);
            }
        }

        private void layThongTinMon(int mon_id)
        {
            clsDatabase.OpenConnection();

            SqlCommand com = new SqlCommand("EXEC thongtin_mon @mon_id", clsDatabase.con);

            com.Parameters.AddWithValue("@mon_id", mon_id);

            SqlDataReader reader = com.ExecuteReader();

            if (reader.Read())
            {
                txtTenmon.Text = reader["mon_ten"].ToString();
                txtGia.Text = reader["mon_gia"].ToString();
                txtViettat.Text = reader["mon_viettat"].ToString();

                DropDownList1.SelectedValue = reader["lm_id"].ToString();

                if (reader["mon_hinh"] == DBNull.Value)
                {
                    hinh.ImageUrl = "blank-img.jpg";
                }
                else
                {
                    byte[] imageData = (byte[])reader["mon_hinh"];
                    string base64String = Convert.ToBase64String(imageData, 0, imageData.Length);
                    hinh.ImageUrl = "data:image/png;base64," + base64String;

                    Session["mon_hinh"] = imageData;
                }
            }
            reader.Close();
            clsDatabase.CloseConnection();
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
            mon_id = int.Parse(Request.QueryString["mon_id"].ToString());

            clsDatabase.OpenConnection();

            SqlCommand com = new SqlCommand("EXEC chinhsua_mon @mon_id, @mon_ten, @mon_gia, @mon_viettat, @lm_id, @mon_hinh", clsDatabase.con);

            SqlParameter p = new SqlParameter("@mon_id", SqlDbType.Int);
            SqlParameter p2 = new SqlParameter("@mon_ten", SqlDbType.NVarChar);
            SqlParameter p3 = new SqlParameter("@mon_gia", SqlDbType.Float);
            SqlParameter p4 = new SqlParameter("@mon_viettat", SqlDbType.NVarChar);
            SqlParameter p5 = new SqlParameter("@lm_id", SqlDbType.Int);
            SqlParameter p6 = new SqlParameter("@mon_hinh", SqlDbType.VarBinary);

            p.Value = mon_id;
            p2.Value = txtTenmon.Text;
            p3.Value = (int)float.Parse(txtGia.Text);
            p4.Value = txtViettat.Text;
            p5.Value = int.Parse(DropDownList1.SelectedValue.ToString());

            if (FileUpload1.HasFile)
            {
                string fileName = Path.GetFileName(FileUpload1.FileName);
                string contentType = FileUpload1.PostedFile.ContentType;
                byte[] fileData = FileUpload1.FileBytes;

                p6.Value = fileData;
            }
            else if (Session["mon_hinh"] != null)
            {
                // Nếu không có tệp hình ảnh mới, sử dụng dữ liệu hình ảnh từ Session
                byte[] imageData = (byte[])Session["mon_hinh"];
                p6.Value = imageData;
            }
            else
            {
                // Nếu không có tệp hình ảnh và Session["mon_hinh"] = null, sử dụng ảnh mặc định
                string defaultImagePath = Server.MapPath("blank-img.jpg");
                byte[] defaultImageData = File.ReadAllBytes(defaultImagePath);
                p6.Value = defaultImageData;
            }

            com.Parameters.Add(p);
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

        protected void Xoa_Click(object sender, EventArgs e)
        {
            mon_id = int.Parse(Request.QueryString["mon_id"].ToString());
            string tk_Qmon = Session["tk_Qmon"].ToString();
            if (tk_Qmon == "6" || tk_Qmon == "27" || tk_Qmon == "36" || tk_Qmon == "57")
            {
                clsDatabase.OpenConnection();
                SqlCommand com = new SqlCommand("EXEC xoa_mon @mon_id", clsDatabase.con);

                SqlParameter p = new SqlParameter("@mon_id", SqlDbType.Int);
                p.Value = mon_id;
                com.Parameters.Add(p);
                com.ExecuteNonQuery();
                clsDatabase.CloseConnection();

                Session.Remove("mon_hinh");
                Response.Redirect("Menu.aspx");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#chucnangModal').modal('show');", true);
            }
        }

        protected void Huy_Click(object sender, EventArgs e)
        {
            Session.Remove("mon_hinh");
            Response.Redirect("Menu.aspx");
        }

    }
}
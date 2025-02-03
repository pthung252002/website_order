using System;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;

namespace TTTT
{
    public partial class DanhSachBan : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Response.ContentType = "text/html";
                StringBuilder html = new StringBuilder();

                if (clsDatabase.OpenConnection())
                {
                    // Chỉ lấy ra ban_stt
                    string query = "SELECT ban_stt FROM Ban";
                    SqlCommand cmd = new SqlCommand(query, clsDatabase.con);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        string banStt = reader["ban_stt"].ToString();
                        html.Append($"<div class='ban-item' data-ban-id='{banStt}'>{banStt}</div>");
                    }

                    reader.Close();
                    clsDatabase.CloseConnection();
                }

                Response.Write(html.ToString());
                Response.End();
            }
        }
    }
}
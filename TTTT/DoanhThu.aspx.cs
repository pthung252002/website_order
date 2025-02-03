using System.Data.SqlClient;
using System.Data;
using System.Web.UI;
using System;

using System.IO;
using ClosedXML.Excel;
using System.Web.UI.WebControls;
using System.Web.UI.DataVisualization.Charting;

namespace TTTT
{
    public partial class DoanhThu : System.Web.UI.Page
    {
        DataTable datatable_mon;
        SqlDataAdapter adapter_mon;

        DataTable datatable_ngay;
        SqlDataAdapter adapter_ngay;

        DataTable datatable_thang;
        SqlDataAdapter adapter_thang;

        DataTable datatable_ngay2;
        SqlDataAdapter adapter_ngay2;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ltk_id"] == null || Convert.ToInt32(Session["ltk_id"]) != 1)
            {
                // Ẩn phần quản lý nếu ltk_id khác 1
                QuanLyMenu.Visible = false;
            }

            if (!IsPostBack)
            {
                BindReapter();
                clsDatabase.OpenConnection();
                SqlCommand com = new SqlCommand("EXEC doanhthu_trong_ngay", clsDatabase.con);
                SqlDataReader reader = com.ExecuteReader();

                if (reader.Read())
                {
                    if (reader["TongTien"] != DBNull.Value)
                    {
                        tong_tien.Text = reader["TongTien"].ToString() + ".000đ";
                    }
                    else
                    tong_tien.Text = "0đ";
                }
                clsDatabase.CloseConnection();

                BindChartData_ngay();
                BindChartData_thang();
            }
        }

        private void BindReapter()
        {
            datatable_mon = new DataTable();
            clsDatabase.OpenConnection();

            SqlCommand com = new SqlCommand("EXEC tongsoluong_theo_mon", clsDatabase.con);
            adapter_mon = new SqlDataAdapter(com);

            adapter_mon.Fill(datatable_mon);
            Repeater1.DataSource = datatable_mon;
            Repeater1.DataBind();

            clsDatabase.CloseConnection();
        }

        private void BindChartData_ngay()
        {
            datatable_ngay = new DataTable();
            clsDatabase.OpenConnection();

            SqlCommand com = new SqlCommand("EXEC doanhthu_ngay;", clsDatabase.con);
            adapter_ngay = new SqlDataAdapter(com);

            adapter_ngay.Fill(datatable_ngay);
            Chart1.DataSource = datatable_ngay;
            Chart1.DataBind();

            clsDatabase.CloseConnection();
        }

        private void BindChartData_thang()
        {
            datatable_thang = new DataTable();
            clsDatabase.OpenConnection();

            SqlCommand com = new SqlCommand("EXEC doanhthu_thang;", clsDatabase.con);
            adapter_thang = new SqlDataAdapter(com);

            adapter_thang.Fill(datatable_thang);
            Chart2.DataSource = datatable_thang;
            Chart2.DataBind();

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

        protected void btnngay_Click(object sender, ImageClickEventArgs e)
        {
            string date1Value = hiddenDate1.Value;
            string date2Value = hiddenDate2.Value;

            DateTime date1 = DateTime.ParseExact(date1Value, "dd/MM/yyyy", null);
            DateTime date2 = DateTime.ParseExact(date2Value, "dd/MM/yyyy", null);

            datatable_ngay2 = new DataTable();
            clsDatabase.OpenConnection();

            SqlCommand com = new SqlCommand("EXEC doanhthu_trong_khoang @date1, @date2;", clsDatabase.con);

            SqlParameter p1 = new SqlParameter("@date1", SqlDbType.Date);
            SqlParameter p2 = new SqlParameter("@date2", SqlDbType.Date);

            p1.Value = date1;
            p2.Value = date2;

            com.Parameters.Add(p1);
            com.Parameters.Add(p2);

            adapter_ngay2 = new SqlDataAdapter(com);
            adapter_ngay2.Fill(datatable_ngay2);

            // Xóa dữ liệu cũ của Chart1 và cập nhật dữ liệu mới
            Chart1.Series["Series1"].Points.Clear();
            Chart1.DataSource = datatable_ngay2;
            Chart1.DataBind();

            clsDatabase.CloseConnection();

            BindChartData_thang();

            // Cập nhật lại giá trị cho datepicker1 và datepicker2
            DateTime selectedDate1 = DateTime.ParseExact(date1Value, "dd/MM/yyyy", null);
            DateTime selectedDate2 = DateTime.ParseExact(date2Value, "dd/MM/yyyy", null);

            hiddenDate1.Value = selectedDate1.ToString("dd/MM/yyyy");
            hiddenDate2.Value = selectedDate2.ToString("dd/MM/yyyy");

            // Cập nhật giá trị cho các control datepicker
            ScriptManager.RegisterStartupScript(this, GetType(), "UpdateDatePickers", "updateDatePickers('" + selectedDate1.ToString("dd/MM/yyyy") + "', '" + selectedDate2.ToString("dd/MM/yyyy") + "');", true);
        }

        //Xuất báo cáo


    }
}

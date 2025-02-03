using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace TTTT
{
    public partial class ChiTietHoaDon : System.Web.UI.Page
    {
        public clsHoaDon hoaDon;

        public int hd_id;

        SqlDataAdapter adapter1;
        SqlDataAdapter adapter2;
        SqlDataAdapter adapter3;
        SqlDataAdapter adapter4;

        DataTable datatable1;
        DataTable datatable2;
        DataTable datatable3;
        DataTable datatable4;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindListView();

                hd_id = int.Parse(Request.QueryString["hd_id"]);

                hoaDon = new clsHoaDon();
                hoaDon = LayThongTinHoaDon(hd_id);

                ban_stt.Text = hoaDon.ban_stt;
                tong_tien.Text = "TỔNG: " + hoaDon.hd_tongtien + ".000 đồng";

                BindRepeater(hd_id);
            }
        }

        private void BindListView()
        {
            datatable1 = new DataTable();
            clsDatabase.OpenConnection();

            SqlCommand com = new SqlCommand("SELECT * FROM mon", clsDatabase.con);
            adapter1 = new SqlDataAdapter(com);

            adapter1.Fill(datatable1);
            ListView1.DataSource = datatable1;
            ListView1.DataBind();

            clsDatabase.CloseConnection();
        }

        private void BindRepeater(int id)
        {
            datatable2 = new DataTable();
            clsDatabase.OpenConnection();

            SqlCommand com = new SqlCommand("SELECT cthd.mon_id, m.mon_ten, m.mon_gia, cthd.soluong FROM chitiethoadon cthd " +
                                            "INNER JOIN mon m ON m.mon_id = cthd.mon_id WHERE hd_id = @id", clsDatabase.con);

            SqlParameter p = new SqlParameter("@id", SqlDbType.Int);
            p.Value = id;
            com.Parameters.Add(p);

            adapter2 = new SqlDataAdapter(com);

            adapter2.Fill(datatable2);
            Repeater1.DataSource = datatable2;
            Repeater1.DataBind();

            clsDatabase.CloseConnection();
        }

        private void LoadBanData()
        {
            datatable3 = new DataTable();
            datatable4 = new DataTable();

            clsDatabase.OpenConnection();

            SqlCommand com = new SqlCommand("SELECT ban_stt, ban_trangthai, b.kv_id FROM ban b " +
                                        "INNER JOIN khuvuc kv on b.kv_id=kv.kv_id WHERE b.kv_id = 1", clsDatabase.con);

            adapter3 = new SqlDataAdapter(com);
            adapter3.Fill(datatable3);

            SqlCommand com2 = new SqlCommand("SELECT ban_stt, ban_trangthai, b.kv_id FROM ban b " +
                            "INNER JOIN khuvuc kv on b.kv_id=kv.kv_id WHERE b.kv_id = 2", clsDatabase.con);

            adapter4 = new SqlDataAdapter(com2);
            adapter4.Fill(datatable4);

            ListView2.DataSource = datatable3;
            ListView2.DataBind();

            ListView3.DataSource = datatable4;
            ListView3.DataBind();

            clsDatabase.CloseConnection();
        }


        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            LoadBanData();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#banModal').modal('show');", true);
        }

        public clsHoaDon LayThongTinHoaDon(int id)
        {
            clsHoaDon hoaDon = new clsHoaDon(); // Sửa thành hoaDon để khớp với tên biến đã khai báo

            clsDatabase.OpenConnection();
            SqlCommand com = new SqlCommand("SELECT hd_id, hd_tongtien, ban_stt, hd_tongtien FROM hoadon WHERE hd_id = @id", clsDatabase.con);

            SqlParameter p = new SqlParameter("@id", SqlDbType.Int);
            p.Value = id;
            com.Parameters.Add(p);

            SqlDataReader reader = com.ExecuteReader();

            if (reader.Read())
            {
                hoaDon.hd_id = int.Parse(reader["hd_id"].ToString());
                if (reader["ban_stt"] == DBNull.Value) // Sửa thành DBNull.Value để kiểm tra giá trị null
                {
                    hoaDon.ban_stt = "";
                }
                else
                {
                    if (int.Parse(reader["ban_stt"].ToString()) <= 10)
                    {
                        hoaDon.ban_stt = " Trệt - " + reader["ban_stt"].ToString();
                    }
                    else
                    {
                        hoaDon.ban_stt = " Lầu - " + reader["ban_stt"].ToString();
                    }   
                }

                if (reader["hd_tongtien"] == DBNull.Value) // Sửa thành DBNull.Value để kiểm tra giá trị null
                {
                    hoaDon.hd_tongtien = 0;
                }
                else
                {
                    hoaDon.hd_tongtien = (int)float.Parse(reader["hd_tongtien"].ToString());
                }
            }

            clsDatabase.CloseConnection();
            return hoaDon;
        }

        protected void ChonBan_Click(object sender, EventArgs e)
        {
            ImageButton btn = (ImageButton)sender;
            int banStt = int.Parse(btn.CommandArgument); // Lấy giá trị của thuộc tính CommandArgument

            hd_id = int.Parse(Request.QueryString["hd_id"]);

            clsDatabase.OpenConnection();

            SqlCommand com = new SqlCommand("SELECT ban_trangthai FROM ban WHERE ban_stt = @ban_stt", clsDatabase.con);

            SqlParameter p = new SqlParameter("@ban_stt", SqlDbType.Int);
            p.Value = banStt;
            com.Parameters.Add(p);

            SqlDataReader reader = com.ExecuteReader();


            if (reader.Read())
            {
                if (int.Parse(reader["ban_trangthai"].ToString()) == 0) // Sửa thành DBNull.Value để kiểm tra giá trị null
                {
                    reader.Close();
                    SqlCommand com2 = new SqlCommand("EXEC UpdateBanStt @hd_id, @ban_stt", clsDatabase.con);


                    SqlParameter p2 = new SqlParameter("@hd_id", SqlDbType.Int);
                    p2.Value = hd_id;

                    SqlParameter p3 = new SqlParameter("@ban_stt", SqlDbType.Int);
                    p3.Value = banStt;

                    com2.Parameters.Add(p2);
                    com2.Parameters.Add(p3);

                    com2.ExecuteNonQuery();
                    if(banStt <= 10)
                    {
                        ban_stt.Text = "Trệt - " + banStt.ToString();
                    }
                    else
                    {
                        ban_stt.Text = "Lầu - " + banStt.ToString();
                    }
                    
                }
                else
                {
                    //Hiển thị ra thông báo khi bàn đã có người ngồi
                    reader.Close();
                    string message = "Bàn " + banStt.ToString() + " Đang có người ngồi";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + message + "');", true);
                }
            }
            clsDatabase.CloseConnection();
        }


        protected void ThemCTHD_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int monId = int.Parse(btn.CommandArgument); // Lấy giá trị của thuộc tính CommandArgument

            hd_id = int.Parse(Request.QueryString["hd_id"]);

            clsDatabase.OpenConnection();
            SqlCommand com = new SqlCommand("EXEC Proc_KiemTraMon @hd_id, @mon_id", clsDatabase.con);

            SqlParameter p = new SqlParameter("@hd_id", SqlDbType.Int);
            SqlParameter p2 = new SqlParameter("@mon_id", SqlDbType.Int);

            p.Value = hd_id;
            p2.Value = monId;

            com.Parameters.Add(p);
            com.Parameters.Add(p2);

            com.ExecuteNonQuery();

            hoaDon = new clsHoaDon();
            hoaDon = LayThongTinHoaDon(hd_id);
            tong_tien.Text = "TỔNG: " + hoaDon.hd_tongtien + ".000 đồng";

            BindRepeater(hd_id);

            clsDatabase.CloseConnection();
        }

        protected void ThemCTHD_Click2(object sender, EventArgs e)
        {
            ImageButton btn = (ImageButton)sender;
            int monId = int.Parse(btn.CommandArgument); // Lấy giá trị của thuộc tính CommandArgument

            hd_id = int.Parse(Request.QueryString["hd_id"]);

            clsDatabase.OpenConnection();
            SqlCommand com = new SqlCommand("EXEC tang_sl_1 @hd_id, @mon_id", clsDatabase.con);

            SqlParameter p = new SqlParameter("@hd_id", SqlDbType.Int);
            SqlParameter p2 = new SqlParameter("@mon_id", SqlDbType.Int);

            p.Value = hd_id;
            p2.Value = monId;

            com.Parameters.Add(p);
            com.Parameters.Add(p2);

            com.ExecuteNonQuery();

            hoaDon = new clsHoaDon();
            hoaDon = LayThongTinHoaDon(hd_id);
            tong_tien.Text = "TỔNG: " + hoaDon.hd_tongtien + ".000 đồng";

            BindRepeater(hd_id);

            clsDatabase.CloseConnection();
        }

        protected void GiamCTHD_Click(object sender, EventArgs e)
        {
            ImageButton btn = (ImageButton)sender;
            int monId = int.Parse(btn.CommandArgument); // Lấy giá trị của thuộc tính CommandArgument

            hd_id = int.Parse(Request.QueryString["hd_id"]);

            clsDatabase.OpenConnection();
            SqlCommand com = new SqlCommand("EXEC giam_sl_1 @hd_id, @mon_id", clsDatabase.con);

            SqlParameter p = new SqlParameter("@hd_id", SqlDbType.Int);
            SqlParameter p2 = new SqlParameter("@mon_id", SqlDbType.Int);

            p.Value = hd_id;
            p2.Value = monId;

            com.Parameters.Add(p);
            com.Parameters.Add(p2);

            com.ExecuteNonQuery();

            hoaDon = new clsHoaDon();
            hoaDon = LayThongTinHoaDon(hd_id);
            tong_tien.Text = "TỔNG: " + hoaDon.hd_tongtien + ".000 đồng";

            BindRepeater(hd_id);

            clsDatabase.CloseConnection();
        }

        protected void CAPNHAT_Click(object sender, EventArgs e)
        {
            hd_id = int.Parse(Request.QueryString["hd_id"]);

            foreach (RepeaterItem item in Repeater1.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    TextBox txtSL = (TextBox)item.FindControl("txtSL");
                    HiddenField idmon = (HiddenField)item.FindControl("idmon");

                    int monId = int.Parse(idmon.Value);
                    int newSL = int.Parse(txtSL.Text);

                    CapNhatSL(hd_id, monId, newSL);

                }
            }
            hoaDon = new clsHoaDon();
            hoaDon = LayThongTinHoaDon(hd_id);
            tong_tien.Text = "TỔNG: " + hoaDon.hd_tongtien + ".000 đồng";
        }


        private void CapNhatSL(int hdId, int monId, int newSL)
        {


            clsDatabase.OpenConnection();
            SqlCommand com = new SqlCommand("EXEC capnhat_soluong @hd_id, @mon_id, @sl", clsDatabase.con);

            com.Parameters.AddWithValue("@hd_id", hd_id);
            com.Parameters.AddWithValue("@mon_id", monId);
            com.Parameters.AddWithValue("@sl", newSL);

            com.ExecuteNonQuery();

            clsDatabase.CloseConnection();

        }

        protected void XoaChiTietHoaDon(object sender, EventArgs e)
        {
            ImageButton btnXoa = (ImageButton)sender;
            int monId = int.Parse(btnXoa.CommandArgument);

            hd_id = int.Parse(Request.QueryString["hd_id"]);

            XoaChiTiet(hd_id, monId);

        }

        private void XoaChiTiet(int hdId, int monId)
        {
            clsDatabase.OpenConnection();
            SqlCommand com = new SqlCommand("EXEC xoa_cthd @hd_id, @mon_id", clsDatabase.con);

            SqlParameter p = new SqlParameter("@mon_id", SqlDbType.Int);
            SqlParameter p2 = new SqlParameter("@hd_id", SqlDbType.Int);

            p.Value = monId;
            p2.Value = hdId;

            com.Parameters.Add(p);
            com.Parameters.Add(p2);

            com.ExecuteNonQuery();

            BindRepeater(hd_id);

            hoaDon = new clsHoaDon();
            hoaDon = LayThongTinHoaDon(hd_id);
            tong_tien.Text = "TỔNG: " + hoaDon.hd_tongtien + ".000 đồng";

            clsDatabase.CloseConnection();
        }

        protected void XONG_Click(object sender, EventArgs e)
        {
            int hd_id = int.Parse(Request.QueryString["hd_id"]);

            clsDatabase.OpenConnection();
            SqlCommand com = new SqlCommand("SELECT mon_id FROM chitiethoadon WHERE hd_id = @hd_id", clsDatabase.con);
            SqlParameter p = new SqlParameter("@hd_id", SqlDbType.Int);
            p.Value = hd_id;
            com.Parameters.Add(p);

            SqlDataReader reader = com.ExecuteReader();

            if (string.IsNullOrEmpty(ban_stt.Text) && !reader.Read())
            {
                reader.Close();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#hoadonrongModal').modal('show');", true);
            }
            else
            {
                if (string.IsNullOrEmpty(ban_stt.Text))
                {
                    reader.Close();
                    LoadBanData();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#banModal').modal('show');", true);
                }
                else
                {
                    // Đã có giá trị ban_stt.Text, kiểm tra tiếp reader
                    if (reader.Read())
                    {
                        if (reader.IsDBNull(reader.GetOrdinal("mon_id")))
                        {
                            reader.Close();
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#hoadonrongModal').modal('show');", true);
                        }
                        else
                        {
                            reader.Close();
                            clsDatabase.CloseConnection();
                            Response.Redirect("HoaDon.aspx");
                        }
                    }
                    else
                    {
                        // Không có dòng dữ liệu nào trả về từ reader
                        reader.Close();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#hoadonrongModal').modal('show');", true);
                    }
                }
            }

            clsDatabase.CloseConnection();
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

            ListView1.DataSource = datatable;
            ListView1.DataBind();

            clsDatabase.CloseConnection();
        }

        protected void XoaHD_Click(object sender, EventArgs e)
        {
            hd_id = int.Parse(Request.QueryString["hd_id"]);

            clsDatabase.OpenConnection();
            SqlCommand com = new SqlCommand("SELECT mon_id FROM chitiethoadon WHERE hd_id = @hd_id", clsDatabase.con);
            SqlParameter p = new SqlParameter("@hd_id", SqlDbType.Int);
            p.Value = hd_id;
            com.Parameters.Add(p);

            SqlDataReader reader = com.ExecuteReader();

            if (reader.Read())
            {
                reader.Close();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#xoaModal').modal('show');", true);
            }
            else
            {
                reader.Close();
                SqlCommand com2 = new SqlCommand("EXEC xoa_hd2 @hd_id2", clsDatabase.con);
                SqlParameter p2 = new SqlParameter("@hd_id2", SqlDbType.Int);
                p2.Value = hd_id;
                com2.Parameters.Add(p2);
                com2.ExecuteNonQuery();
                clsDatabase.CloseConnection();

                Response.Redirect("HoaDon.aspx");
            }
            clsDatabase.CloseConnection();
        }

        protected void btnXoa_Click(object sender, EventArgs e)
        {
            hd_id = int.Parse(Request.QueryString["hd_id"]);

            clsDatabase.OpenConnection();
            SqlCommand com = new SqlCommand("SELECT mon_id FROM chitiethoadon WHERE hd_id = @hd_id", clsDatabase.con);
            SqlParameter p = new SqlParameter("@hd_id", SqlDbType.Int);
            p.Value = hd_id;
            com.Parameters.Add(p);

            SqlDataReader reader = com.ExecuteReader();

            if (reader.Read())
            {
                reader.Close();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$('#xoaModal').modal('show');", true);
            }
            else
            {
                reader.Close();
                SqlCommand com2 = new SqlCommand("EXEC xoa_hd2 @hd_id2", clsDatabase.con);
                SqlParameter p2 = new SqlParameter("@hd_id2", SqlDbType.Int);
                p2.Value = hd_id;
                com2.Parameters.Add(p2);
                com2.ExecuteNonQuery();
                clsDatabase.CloseConnection();

                Response.Redirect("HoaDon.aspx");
            }
            clsDatabase.CloseConnection();
        }

        protected void XoaHoaDon_Click(object sender, EventArgs e)
        {
            
            hd_id = int.Parse(Request.QueryString["hd_id"]);

            clsDatabase.OpenConnection();
            SqlCommand com = new SqlCommand("xoa_hd @hd_id, @hd_mota", clsDatabase.con);

            SqlParameter p = new SqlParameter("@hd_id", SqlDbType.Int);
            SqlParameter p2 = new SqlParameter("@hd_mota", SqlDbType.NVarChar);

            p.Value = hd_id;
            p2.Value = txtLyDoXoa.Text;

            com.Parameters.Add(p);
            com.Parameters.Add(p2);
            com.ExecuteNonQuery();

            clsDatabase.CloseConnection();

            Response.Redirect("HoaDon.aspx");
        }
    }
}
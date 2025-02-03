using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace TTTT
{
    public class clsDatabase
    {
        public static SqlConnection con;

        // Mở kết nối
        public static bool OpenConnection()
        {
            try
            {
                con = new SqlConnection("Server=DESKTOP-1N52PR3\\SQLEXPRESS;Database=TTTT;Trusted_Connection=True");
                con.Open();
            }
            catch (Exception)
            {
                return false;
            }
            return true;
        }

        // Đóng kết nối
        public static bool CloseConnection()
        {
            try
            {
                if (con != null && con.State == System.Data.ConnectionState.Open)
                {
                    con.Close();
                }
            }
            catch (Exception)
            {
                return false;
            }
            return true;
        }

        // Lấy danh sách bàn
        public static List<Ban> GetDanhSachBan()
        {
            List<Ban> danhSachBan = new List<Ban>();
            try
            {
                if (OpenConnection())
                {
                    SqlCommand cmd = new SqlCommand("SELECT ban_stt, kv_id, ban_trangthai FROM Ban", con);
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        Ban ban = new Ban
                        {
                            BanStt = reader.GetInt32(0),
                            KvId = reader.GetInt32(1),
                            BanTrangThai = reader.GetByte(2)
                        };
                        danhSachBan.Add(ban);
                    }
                    reader.Close();
                    CloseConnection();
                }
            }
            catch (Exception ex)
            {
                // Xử lý ngoại lệ
            }
            return danhSachBan;
        }


        public static DataTable LayDanhSachBan()
        {
            DataTable dt = new DataTable();
            if (OpenConnection())
            {
                string query = "SELECT ban_stt AS BanStt, kv_id AS KvId, ban_trangthai AS BanTrangThai FROM Ban";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
                CloseConnection();
            }
            return dt;
        }
    }

    // Lớp Ban để ánh xạ dữ liệu
    public class Ban
    {
        public int BanStt { get; set; }
        public int KvId { get; set; }
        public byte BanTrangThai { get; set; }
    }

}

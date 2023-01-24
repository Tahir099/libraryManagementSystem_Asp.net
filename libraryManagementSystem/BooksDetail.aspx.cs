using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

namespace libraryManagementSystem
{
    public partial class BooksDetail : System.Web.UI.Page
    {
        SqlConnection con;
        String a;
        int b;
        protected void Page_Load(object sender, EventArgs e)
        {
            a = Request.QueryString["id"];
            b = int.Parse(Session["user_id"].ToString());
            con = new SqlConnection(ConfigurationManager.ConnectionStrings["Myconnection"].ConnectionString);
            getDetail();
        }
        protected void getDetail()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("getBookDetails", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", int.Parse(a));
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            con.Close();
            foreach(DataRow row in dt.Rows)
            {
                byte[] byt = (byte[])row["imagedata"];
                String s = Convert.ToBase64String(byt);
                Label1.Text = row["bookname"].ToString();
                Label2.Text = row["author"].ToString();
                Image1.ImageUrl = "data:Image/png;base64," + s;

            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("insertRecord", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@userId", b);
            cmd.Parameters.AddWithValue("@bookId", int.Parse(a));
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            con.Close();
        }
    }
}

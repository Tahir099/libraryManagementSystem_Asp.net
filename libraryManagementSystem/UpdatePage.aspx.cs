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
    public partial class WebForm4 : System.Web.UI.Page
    {
        SqlConnection con;
        static byte[] a = null;
        protected  void Page_Load(object sender, EventArgs e)
        {
            con = new SqlConnection(ConfigurationManager.ConnectionStrings["Myconnection"].ConnectionString);
            if (!IsPostBack)
            {
                getData();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("updateBook", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", int.Parse(Session["SelectedBook"].ToString()));
            cmd.Parameters.AddWithValue("@author", TextBox2.Text);
            cmd.Parameters.AddWithValue("@bookName", TextBox1.Text);
            cmd.Parameters.AddWithValue("@image", a);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            con.Close();
        }
        public void getData()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("selectBookForUpdate", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", int.Parse(Session["SelectedBook"].ToString()));
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            con.Close();
            foreach (DataRow row in dt.Rows)
            {
                byte[] byt = (byte[])row["imagedata"];
                String s = Convert.ToBase64String(byt);
                TextBox1.Text = row["bookname"].ToString();
                TextBox2.Text = row["author"].ToString();
                Image1.ImageUrl = "data:Image/png;base64," + s;
                a = byt;
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            HttpPostedFile postedFile = FileUpload1.PostedFile;
            String filename = Path.GetFileName(postedFile.FileName);
            String fileExtention = Path.GetExtension(filename);
            int filesize = postedFile.ContentLength;
            if (fileExtention.ToLower() == ".jpg" || fileExtention.ToLower() == ".bmp" ||
                fileExtention.ToLower() == ".gif" || fileExtention.ToLower() == ".png" || fileExtention.ToLower() == ".jpeg")
            {
                string con = ConfigurationManager.ConnectionStrings["Myconnection"].ConnectionString;
                Stream stream = postedFile.InputStream;
                BinaryReader binaryReader = new BinaryReader(stream);
                Byte[] bytes = binaryReader.ReadBytes((int)stream.Length);
                a = bytes;
            }
            Image1.ImageUrl = "data:Image/png;base64," + Convert.ToBase64String(a);
        }
    }
}
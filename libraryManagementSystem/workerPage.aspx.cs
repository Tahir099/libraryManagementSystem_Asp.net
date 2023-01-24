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
    public partial class workerPage : System.Web.UI.Page
    {
        SqlConnection con;
        

        protected void Page_Load(object sender, EventArgs e)
        {
            con = new SqlConnection(ConfigurationManager.ConnectionStrings["Myconnection"].ConnectionString);
            if (!IsPostBack)
            {
                Label3.Visible = false;
                FillGridView();
            }
        }
        protected void FillGridView()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("getAllBooks", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            con.Close();
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void deleteBtn(object sender, EventArgs e)
        {
            int rowindex = ((GridViewRow)(sender as Control).NamingContainer).RowIndex;
            int bookId = Convert.ToInt32(GridView1.Rows[rowindex].Cells[2].Text);
            con.Open();
            SqlCommand cmd = new SqlCommand("deleteBookFromBooks", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", bookId);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            con.Close();
            FillGridView();
        }
        protected void UpdateBtn(Object sender , EventArgs e)
        {
            int rowindex = ((GridViewRow)(sender as Control).NamingContainer).RowIndex;
            int bookId = Convert.ToInt32(GridView1.Rows[rowindex].Cells[2].Text);
            Session["SelectedBook"] = bookId;
            Response.Redirect("UpdatePage.aspx");
        }
        protected void Button1_Click(object sender, EventArgs e)
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
                using (SqlConnection con_ = new SqlConnection(con))
                {
                    SqlCommand cmd = new SqlCommand("spUploadImage", con_);
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlParameter param = new SqlParameter
                    {
                        ParameterName = @"author",
                        Value = Convert.ToString(TextBox1.Text)
                    };
                    cmd.Parameters.Add(param);
                    SqlParameter param2 = new SqlParameter
                    {
                        ParameterName = @"bookname",
                        Value = Convert.ToString(TextBox2.Text)
                    };
                    cmd.Parameters.Add(param2);
                    SqlParameter param3 = new SqlParameter
                    {
                        ParameterName = @"imageData",
                        Value = bytes
                };
                    cmd.Parameters.Add(param3);
                    con_.Open();
                    cmd.ExecuteNonQuery();
                    con_.Close();
                    Label3.Visible = true;
                    Label3.Text = "UPLOAD SUCCESSFULLY";
                    Label3.ForeColor = System.Drawing.Color.Green;

                    TextBox1.Text = "";
                    TextBox2.Text = "";
                    FillGridView();
                }

            }
        }

        protected void GridView1_DataBound(object sender, EventArgs e)
        {
        }
    }
}
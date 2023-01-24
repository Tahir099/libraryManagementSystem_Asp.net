using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
namespace libraryManagementSystem
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        SqlConnection con;
        int b;
        protected void Page_Load(object sender, EventArgs e)
        {
            con = new SqlConnection(ConfigurationManager.ConnectionStrings["Myconnection"].ConnectionString);
            b = int.Parse(Session["user_id"].ToString());
            if (!IsPostBack)
            {
                FillGridView();
            }
        }
        protected void FillGridView()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("getBooksWithId", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", b);
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
            int bookId = Convert.ToInt32(GridView1.Rows[rowindex].Cells[1].Text);
            con.Open();
            SqlCommand cmd = new SqlCommand("deleteRecords", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@user_id", b);
            cmd.Parameters.AddWithValue("@book_id", bookId);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            con.Close();
            FillGridView();
            
        }
        
    }
}
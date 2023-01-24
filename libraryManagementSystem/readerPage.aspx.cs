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
    public partial class WebForm2 : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        int b;
        protected void Page_Load(object sender, EventArgs e)
        {
        con = new SqlConnection(ConfigurationManager.ConnectionStrings["Myconnection"].ConnectionString);
            if (!IsPostBack)
            {
                getDr();
            }
        }
        protected void getDr()
        {
            String sqlcmd = "exec dbo.getDrData";
            cmd = new SqlCommand(sqlcmd,con);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            DropDownList1.DataSource = dr;
            DropDownList1.DataTextField = "items";
            DropDownList1.DataValueField = "id";
            DropDownList1.DataBind();
            DropDownList1.Items.Insert(0, new ListItem("-Select-" , "0"));
            con.Close();
        }
        public void getBooks()
        {
            
            if (Convert.ToInt32(DropDownList1.SelectedValue) == 1)
            {
                string con_ = ConfigurationManager.ConnectionStrings["Myconnection"].ConnectionString;

                using (SqlConnection con = new SqlConnection(con_))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter("exec dbo.selectForAuthor '" + TextBox1.Text.ToString()+ "'", con))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        gvImages.DataSource = dt;
                        gvImages.DataBind(); 
                    }
                }
            }
            if (Convert.ToInt32(DropDownList1.SelectedValue) == 2)
            {
                string con_ = ConfigurationManager.ConnectionStrings["Myconnection"].ConnectionString;

                using (SqlConnection con = new SqlConnection(con_))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter("exec dbo.selectForBookName '" + TextBox1.Text.ToString() + "'", con))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        gvImages.DataSource = dt;
                        gvImages.DataBind();
                    }
                }

            }
        }

        
        protected void Button1_Click(object sender, EventArgs e)
        {
            getBooks();
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        protected void rsp(object sender, EventArgs e)
        {
            int rowindex = ((GridViewRow)(sender as Control).NamingContainer).RowIndex;
            int bookId = Convert.ToInt32(gvImages.Rows[rowindex].Cells[1].Text);
            Response.Redirect(@"~/BooksDetail.aspx?id=" + bookId);
        }

        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView dr = (DataRowView)e.Row.DataItem;
                string imageUrl = "data:image/jpg;base64," + Convert.ToBase64String((byte[])dr["imagedata"]);
                (e.Row.FindControl("Image1") as Image).ImageUrl = imageUrl;
            }
        }

        protected void gvImages_SelectedIndexChanged(object sender, EventArgs e)
        {
            Response.Redirect("BooksDetail.aspx");
        }

        protected void gvImages_DataBound(object sender, EventArgs e)
        {
            gvImages.Columns[1].Visible = false;
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("readerBooks.aspx");
        }
    }
}
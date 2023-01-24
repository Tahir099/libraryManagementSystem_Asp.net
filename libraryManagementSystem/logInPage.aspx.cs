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
    public partial class WebForm1 : System.Web.UI.Page
    {
        SqlConnection con = null;
        int ret,id = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            con = new SqlConnection(ConfigurationManager.ConnectionStrings["Myconnection"].ConnectionString);
            Label3.Visible = false;

           
        }
        
        protected void Button1_Click(object sender, EventArgs e)
        {
            string con_ = ConfigurationManager.ConnectionStrings["Myconnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(con_))
            {
                SqlCommand cmd = new SqlCommand("check_log_in", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@username", SqlDbType.NVarChar).Value = Convert.ToString(TextBox1.Text);
                cmd.Parameters.Add("@password", SqlDbType.NVarChar).Value = Convert.ToString(TextBox2.Text);
                cmd.Parameters.Add("@checkInfo", SqlDbType.Int).Direction = ParameterDirection.ReturnValue;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                ret = int.Parse(cmd.Parameters["@checkInfo"].Value.ToString());
            }
            if(ret == 1)
            {
                find_user_id();
                Response.Redirect("workerPage.aspx");
            }
            else if(ret == 2)
            {
                find_user_id();
                Response.Redirect("readerPage.aspx");
            }
            else
            {
                Label3.Visible = true;
                Label3.ForeColor = System.Drawing.Color.Red;
                Label3.Text = "INCORRECT";

            }
        }

        protected void find_user_id()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("find_user_id", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@username", TextBox1.Text);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            con.Close();
            foreach (DataRow row in dt.Rows)
            {
                id = int.Parse(row["id"].ToString());
                Session["user_id"] = id;

            }
        }


    }
}
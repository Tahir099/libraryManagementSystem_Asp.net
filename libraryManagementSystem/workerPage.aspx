<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="workerPage.aspx.cs" Inherits="libraryManagementSystem.workerPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Author"></asp:Label>
&nbsp;&nbsp; :&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        </div>
        <p>
            <asp:Label ID="Label2" runat="server" Text="Book name"></asp:Label>
            :
            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:FileUpload ID="FileUpload1" runat="server" Width="266px" />
        </p>
        <p>
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Upload" style="height: 29px" />
        </p>
        <p>
            <asp:Label ID="Label3" runat="server"></asp:Label>
        </p>
        <asp:GridView ID="GridView1" runat="server" OnDataBound="GridView1_DataBound" >
            <Columns>
                <asp:TemplateField HeaderText ="Delete">
                    <ItemTemplate>
                        <asp:Button ID="DeleteBook" runat="server" Text="Delete"  OnClick="deleteBtn"  OnClientClick ="return confirm('Are you sure?')"/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText ="Update">
                    <ItemTemplate>
                        <asp:Button ID="Update" runat="server" Text="Update"  OnClick="UpdateBtn"/>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>

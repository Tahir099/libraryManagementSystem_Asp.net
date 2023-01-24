<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="readerPage.aspx.cs" Inherits="libraryManagementSystem.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 1678px;
            height: 732px;
        }
        </style>
</head>
<body>
    <form id="form1" runat="server" class="auto-style1">
        <div>
            <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
            </asp:DropDownList>
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
&nbsp;
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Search" />
            &nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button2" runat="server" Text="My books" OnClick="Button2_Click" />
            <br />
            <br />
            <br />
        </div>

<asp:GridView ID="gvImages" runat="server" AutoGenerateColumns="False" OnRowDataBound="OnRowDataBound" DataKeyNames="id" OnDataBound="gvImages_DataBound" >
    <Columns>
          <asp:TemplateField HeaderText="select">
            <ItemTemplate>
               <asp:LinkButton runat="server" OnClick="rsp" Text="Click" />
            </ItemTemplate>

        </asp:TemplateField>

        <asp:BoundField DataField="id" HeaderText="id"  />
        <asp:TemplateField HeaderText="Image" ControlStyle-Height ="200px">
            <ItemTemplate>
                <asp:Image ID="Image1" runat="server" />
            </ItemTemplate>
<ControlStyle Height="200px"></ControlStyle>
        </asp:TemplateField>
    </Columns>
</asp:GridView>




    </form>
</body>
</html>

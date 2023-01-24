<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdatePage.aspx.cs" Inherits="libraryManagementSystem.WebForm4" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            margin-top: 0px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Label ID="Label1" runat="server" Text="Book name: "></asp:Label>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <p>
            <asp:Label ID="Label2" runat="server" Text="Author: "></asp:Label>
            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:FileUpload ID="FileUpload1" runat="server" />
            <asp:Button ID="Button2" runat="server" Text="Change" CssClass="auto-style1" Height="24px" OnClick="Button2_Click" />
        </p>
        <p>
            <asp:Image ID="Image1" runat="server" Width ="150" Height ="200"/>
        </p>
        <p>
            <asp:Button ID="Button1" runat="server" Text="Update" OnClick="Button1_Click" />
        </p>
        <p>
            &nbsp;</p>
    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BooksDetail.aspx.cs" Inherits="libraryManagementSystem.BooksDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Image ID="Image1" runat="server" Height="188px" Width="157px" />
        <div>
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        </div>
        <p>
            <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
        </p>
        <p>
            <asp:Button ID="Button1" runat="server" Text="GET BOOK" OnClick="Button1_Click" />
        </p>
    </form>
</body>
</html>

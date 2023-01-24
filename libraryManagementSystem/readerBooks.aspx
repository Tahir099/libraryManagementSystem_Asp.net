<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="readerBooks.aspx.cs" Inherits="libraryManagementSystem.WebForm3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">&nbsp;<asp:GridView ID="GridView1" runat="server">
            <Columns>
               <asp:TemplateField HeaderText ="Delete">
                   <ItemTemplate>
                       <asp:Button ID="deleteReaderBook" runat="server" OnClick="deleteBtn" Text="Delete" OnClientClick ="return confirm('are you sure?')"/>
                   </ItemTemplate>
               </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <div>
        </div>
    </form>
</body>
</html>

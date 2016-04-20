﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CS.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title></title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"
type = "text/javascript"></script> 
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"
type = "text/javascript"></script> 
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css"
rel = "Stylesheet" type="text/css" /> 
<script type="text/javascript">
    $(document).ready(function () {
        $("#<%=txtSearch.ClientID %>").autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: '<%=ResolveUrl("~/Service.asmx/GetCustomers") %>',
                    data: "{ 'prefix': '" + request.term + "'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        response($.map(data.d, function (item) {
                            return {
                                label: item.split('-')[0],
                                val: item.split('-')[1]
                            }
                        }))
                    },
                    error: function (response) {
                        alert(response.responseText);
                    },
                    failure: function (response) {
                        alert(response.responseText);
                    }
                });
            },
            select: function (e, i) {
                $("#<%=hfCustomerId.ClientID %>").val(i.item.val);
            },
            minLength: 1
        });

    }); 
</script> 
</head>
<body>
    <form id="form1" runat="server">
    <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
    <asp:HiddenField ID="hfCustomerId" runat="server" />
    <br />
    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick = "Submit" />
    </form>
</body>
</html>

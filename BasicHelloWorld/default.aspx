<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="mammerla.YamSamples.BasicHelloWorld._default" %>
<%@ Assembly Name="BasicHelloWorld" %>
<%@ Register TagPrefix="yammer" Assembly="mammerla.YammerIntegration" Namespace="mammerla.YammerIntegration.WebForms" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>

<body>
    <form id="form1" runat="server">
    <div>
       <yammer:MessageList runat="server" />
       <yammer:MessagePoster runat="server" />
    </div>
    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="activity.aspx.cs" Inherits="mammerla.YamSamples.BasicHelloWorld._activity" %>
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
       <yammer:ActivityPoster runat="server" />
    </div>
    </form>
</body>
</html>

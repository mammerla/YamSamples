<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PartPage.aspx.cs" Inherits="mammerla.YamSamples.DocumentDiscussions.Pages.PartPage" %>
<%@ Register TagPrefix="yammer" Assembly="mammerla.YammerIntegration" Namespace="mammerla.YammerIntegration.WebForms" %>

<!doctype html>

<html>
<head runat="server">
    <title></title>
    <meta http-equiv="x-ua-compatible" content="IE=9">

    <link rel="stylesheet" type="text/css" href="../resources/yamspint.css" />
    
    <script type="text/javascript" src="../scripts/MicrosoftAjax.debug.js"></script>
    <script type="text/javascript" src="../scripts/jquery-1.7.1.js"></script>
    <script type="text/javascript" data-app-id="yourappclientid" src="https://assets.yammer.com/platform/yam.js"></script>
 
    <script language="javascript">

        var _context;
        var _web;
        var _webEventReceivers;

        var hostweburl;
        var appweburl;

        $(document).ready(
            function ()
            {
                //Get the URI decoded URLs.
                hostweburl = decodeURIComponent(getQueryStringParameter("SPHostUrl"));
                appweburl = decodeURIComponent(getQueryStringParameter("SPAppWebUrl"));

                yam.connect.embedFeed
                (
                    {
                        container: '#embedded-feed',
                        network: "contosofoods.onmicrosoft.com",
                        objectProperties: {
                            url: hostweburl,
                            type: "page",
                        },
                        config: {
                            header: false
                        },
                        feedType: 'open-graph'
                    }
                );
            }
        );

        // Function to retrieve a query string value.
        // For production purposes you may want to use
        //  a library to handle the query string.
        function getQueryStringParameter(paramToRetrieve)
        {
            var params = document.URL.split("?")[1].split("&");
            var strParams = "";
            for (var i = 0; i < params.length; i = i + 1)
            {
                var singleParam = params[i].split("=");
                if (singleParam[0] == paramToRetrieve)
                {
                    return singleParam[1];
                }
            }
        }

    </script>
</head>
<body>
    <form runat="server">
        <div>
            <div id="hostwebtitle"></div>
            <div id="header"></div>
            <yammer:BasicAuthenticator runat="server" />
            <div id="embedded-feed"></div>
        </div>
    </form>
</body>
</html>

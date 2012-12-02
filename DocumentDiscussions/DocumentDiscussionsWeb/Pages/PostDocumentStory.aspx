<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PostDocumentStory.aspx.cs" Inherits="mammerla.YamSamples.DocumentDiscussions.Pages.Default" %>
<%@ Register TagPrefix="yammer" Assembly="mammerla.YammerIntegration" Namespace="mammerla.YammerIntegration.WebForms" %>

<!doctype html>

<html>
<head runat="server">
    <title></title>
      <meta http-equiv="x-ua-compatible" content="IE=9">
        <script type="text/javascript" src="../scripts/jquery-1.7.1.js"></script>

    <script type="text/javascript" data-app-id="yourappclientid" src="https://assets.yammer.com/platform/yam.js"></script>
 
    <script language="javascript">

        var _context;
        var _web;
        var _user;
        var _webEventReceivers;

        var hostweburl;
        var appweburl;
        var itemurl;

        // Load the required SharePoint libraries
        $(document).ready(function ()
        {

            //Get the URI decoded URLs.
            hostweburl = decodeURIComponent(getQueryStringParameter("HostUrl"));
            appweburl = decodeURIComponent(getQueryStringParameter("SPAppWebUrl"));

            itemurl = getQueryStringParameter("ItemUrl");

            if (itemurl != null)
            {
                itemurl = decodeURIComponent(itemurl);
            }

            // resources are in URLs in the form:
            // web_url/_layouts/15/resource
            var scriptbase = hostweburl + "/_layouts/15/";

            var firstSlash = hostweburl.indexOf("/", 9);

            var fullAbsoluteUrl = null;

            if (firstSlash > 0 && itemurl != null)
            {
                fullAbsoluteUrl = hostweburl.substring(0, firstSlash) + itemurl;

                fullAbsoluteUrl = fullAbsoluteUrl.toLowerCase();

                yam.connect.embedFeed
                    (
                        {
                            container: '#embedded-feed',
                            network: "contosofoods.onmicrosoft.com",
                            objectProperties: {
                                url: fullAbsoluteUrl,
                                type: "page",
                            },
                            config: {
                                header: false
                            },
                            feedType: 'open-graph', // can be 'group', 'topic', or 'user'
                        }
                    );

            }
        });

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
                    return singleParam[1];
            }
        }

        
    </script>
</head>
<body>
    <form runat="server">
        <div>
            <div id="status"></div>
            <div id="header"></div>
            <div id="user"></div>
            <div id="embedded-feed"></div>
        </div>
    </form>
</body>
</html>

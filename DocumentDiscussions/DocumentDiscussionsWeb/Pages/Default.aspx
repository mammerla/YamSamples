<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="mammerla.YamSamples.DocumentDiscussions.Pages.Default" %>
<%@ Register TagPrefix="sharepoint" Assembly="mammerla.SharePointIntegration" Namespace="mammerla.SharePointIntegration.WebForms" %>
<%@ Register TagPrefix="yammer" Assembly="mammerla.YammerIntegration" Namespace="mammerla.YammerIntegration.WebForms" %>

<!doctype html>

<html>
<head runat="server">
    <title></title>
    <meta http-equiv="x-ua-compatible" content="IE=9">

    <link rel="stylesheet" type="text/css" href="../resources/yamspint.css" />

    <script type="text/javascript" src="../scripts/MicrosoftAjax.debug.js"></script>
    <script type="text/javascript" src="../scripts/jquery-1.7.1.js"></script>
    <script type="text/javascript" src="../scripts/sp.runtime.debug.js"></script>
    <script type="text/javascript" src="../scripts/sp.core.debug.js"></script>
    <script type="text/javascript" src="../scripts/sp.debug.js"></script>

    <script type="text/javascript">
        var hostweburl;


    // Function to prepare the options and render the control.
    function renderChrome() {

        // The Help, Account, and Contact pages receive the 
        // same query string parameters as the main page.
        var options = {
            "appIconUrl": "/resources/my_documents_2.png",
            "appTitle": "Document Discussions",
            "appHelpPageUrl": "Help.html?"
                + document.URL.split("?")[1],
            "settingsLinks": [
                {
                    "linkUrl": "Account.html?"
                        + document.URL.split("?")[1],
                    "displayName": "Account settings"
                },
                {
                    "linkUrl": "Contact.html?"
                        + document.URL.split("?")[1],
                    "displayName": "Contact us"
                }
            ]
        };

        var nav = new SP.UI.Controls.Navigation(
                                "chrome_ctrl_placeholder",
                                options
                          );
        nav.setVisible(true);
    }

        // Function to retrieve a query string value.
        // For production purposes you may want to use
        // a library to handle the query string.
        function getQueryStringParameter(paramToRetrieve) {
        var params =
            document.URL.split("?")[1].split("&");
        var strParams = "";
        for (var i = 0; i < params.length; i = i + 1) {
            var singleParam = params[i].split("=");
            if (singleParam[0] == paramToRetrieve)
                return singleParam[1];
        }
    }
    </script>
    <script type="text/javascript" data-app-id="O9M8RnYp2POlCAbnF4FOzw" src="https://assets.yammer.com/platform/yam.js"></script>
 
    <script language="javascript">

        var _context;
        var _web;
        var _webEventReceivers;

        var hostweburl;
        var appweburl;

        // Load the required SharePoint libraries
        $(document).ready(function ()
        {
            //Get the URI decoded URLs.
            hostweburl = decodeURIComponent(getQueryStringParameter("SPHostUrl"));
            appweburl = decodeURIComponent(getQueryStringParameter("SPAppWebUrl"));

            if (hostweburl != null)
            {
                
                yam.connect.embedFeed
                    (
                        {
                            container: '#embedded-feed',
                            network: "contosofoods.onmicrosoft.com",
                            objectProperties:
                            {
                                url: hostweburl,
                                type: "page",
                            },
                            config: {
                                header: false
                            },
                            feedType: 'open-graph', // can be 'group', 'topic', or 'user'
                        }
                    );
            }

            var scriptbase = hostweburl + "/_layouts/15/";
            execCrossDomainRequest();


            // Get the URI decoded app web URL.
            hostweburl =
                decodeURIComponent(
                    getQueryStringParameter("SPHostUrl")
            );

            // The SharePoint js files URL are in the form:// web_url/_layouts/15/resource.jsvar scriptbase = hostweburl + "/_layouts/15/";

            // Load the js file and continue to the //   success handler.
            $.getScript(scriptbase + "SP.UI.Controls.js", renderChrome);
        });

        // Function to prepare and issue the request to get
        //  SharePoint data
        function execCrossDomainRequest()
        {
            var factory;
            var appContextSite;

            _context = new SP.ClientContext(hostweburl);
            _context.set_viaUrl("/_vti_bin/client.svx");

            _web = _context.get_web();
            _context.load(_web);

            _webEventReceivers = _web.get_eventReceivers();
            _context.load(_webEventReceivers);

            _context.executeQueryAsync(ensureEvent, errorHandler);
        }

        // Function to handle the error event.
        // Prints the error message to the page.
        function errorHandler(data, errorCode, errorMessage)
        {
            document.getElementById("hostwebtitle").innerText = "Could not complete cross-domain call: " + errorMessage;
        }

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

        function returnToPreviousSite()
        {
            history.go(-1);
        }

   
        function ensureEvent()
        {
            for (var i = 0; i < _webEventReceivers.get_count() ; i++)
            {
                var erd = _webEventReceivers.get_item(i);

                if (erd.get_receiverName() == "yammonitor3")
                {
                    return;
                }
            }

            var baseUrl = "your URL here";  

            var erdi = new SP.EventReceiverDefinitionCreationInformation();
            erdi.set_receiverUrl(baseUrl + "documenteventreceiver.svc");
            erdi.set_receiverName("yammonitor3");
            erdi.set_eventType(SP.EventReceiverType.itemUpdated);

            _webEventReceivers.add(erdi);

            erdi = new SP.EventReceiverDefinitionCreationInformation();
            erdi.set_receiverUrl(baseUrl + "documenteventreceiver.svc");
            erdi.set_receiverName("yammonitor3a");
            erdi.set_eventType(SP.EventReceiverType.itemAdded);

            _webEventReceivers.add(erdi);

            _context.executeQueryAsync(eventReceiverDone, errorHandler);
        }

        function eventReceiverDone()
        {

        }
    </script>
</head>
<body>
    <form runat="server">
        <div>
            <div id="chrome_ctrl_placeholder"></div>
            <div id="hostwebtitle">Welcome to Document Discussions.  You can discuss specific documents via the Ribbon or dropdown menu for those documents.  Also, as documents get updated in your site, those actions will flow back to Yammer.</div>
            <sharepoint:SharePointContext runat="server" />
             <yammer:BasicAuthenticator runat="server" />
            <div id="embedded-feed"></div>
        </div>
    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <meta http-equiv="x-ua-compatible" content="IE=9">

    <link rel="stylesheet" type="text/css" href="yamspint.css" />
    <script type="text/javascript" data-app-id="yourclientidhere" src="https://assets.yammer.com/platform/yam.js"></script>
    <script src="office/1.0/office.debug.js"></script>
    
    <input type="button" onclick="loadFeed()"></input>

    <script>
        Office.initialize = function (reason)
        {
            var sUrl = Office.context.document.url;

            if (isWebUrl(sUrl))
            {
                loadFeed();
            }
            else
            {
                document.getElementById("embedFeed").innerHTML = "<div style='padding:10px'>Please save this document to a web site to discuss on Yammer.</div>";
            }
        };

        function loadFeed()
        {
            var sUrl = Office.context.document.url;

            yam.connect.embedFeed({
                container: '#embedFeed',
                network: "contoso.com",
                objectProperties: {
                    url: sUrl,
                    type: "document"
                },
                config: {
                    header: false
                },
                feedType: "open-graph"
            });
        }

        function isWebUrl(sUrl)
        {
            sUrl = sUrl.toLowerCase();

            if (sUrl.indexOf("http://") == 0 || sUrl.indexOf("https://") == 0)
            {
                return true;
            }

            return false;
        }
    </script>
</head>

<body><div id="embedFeed" style="height:100%"></div></body>
</html>

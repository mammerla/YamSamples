/*
Copyright (c) Microsoft Corporation
All rights reserved.
Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the 
License at http://www.apache.org/licenses/LICENSE-2.0 
    
THIS CODE IS PROVIDED *AS IS* BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING 
WITHOUT LIMITATION ANY IMPLIED WARRANTIES OR CONDITIONS OF TITLE, FITNESS FOR A PARTICULAR PURPOSE, MERCHANTABLITY OR NON-INFRINGEMENT. 

See the Apache Version 2.0 License for specific language governing permissions and limitations under the License.
*/

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using mammerla.YammerIntegration.WebForms;
using mammerla.YammerIntegration.Yammer;

namespace DocumentDiscussionsWeb
{
    public partial class EventTest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            YammerStandaloneContext yammerContext = new YammerStandaloneContext();
            yammerContext.UserId = String.Empty;
            yammerContext.LoadAuthenticationResponseToken(String.Empty);

            Activity a = new Activity();
            a.Action = "update";
            a.Message = "test update";

            a.Actor.Name = "Mike Ammerlaan";
            a.Actor.EMail = "emailaddress";

            a.Object.Url = "https://yourserverURLhere/sites/dev/Shared%20Documents/test.docx";
            a.Object.Title = "Test Document";
            a.Object.Type = "document";

            a.Private = false;

            yammerContext.PostActivity(a);
        }
    }
}
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

namespace DocumentDiscussionsWeb.Pages
{
    public partial class Default : System.Web.UI.Page
    {
        public String ContextToken
        {
            get
            {
                return this.Session["SPToken"] as String;
            }

            set
            {
                this.Session["SPToken"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // The following code gets the client context and Title property by using TokenHelper.
            // To access other properties, you may need to request permissions on the host web.

            if (ContextToken == null)
            {
                String contextToken = TokenHelper.GetContextTokenFromRequest(Page.Request);

                this.ContextToken = contextToken;
            }
        }
    }
}
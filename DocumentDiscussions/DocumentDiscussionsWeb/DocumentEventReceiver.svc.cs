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
using System.Text;
using Microsoft.SharePoint.Client;
using Microsoft.SharePoint.Client.EventReceivers;
using mammerla.YammerIntegration.WebForms;
using mammerla.YammerIntegration.Yammer;
using mammerla.SharePointIntegration;

namespace DocumentDiscussionsWeb
{
    public class DocumentEventReceiver : IRemoteEventService
    {
        public SPRemoteEventResult ProcessEvent(SPRemoteEventProperties properties)
        {
            SPRemoteEventResult result = new SPRemoteEventResult();

   
            return result;
        }

        public void ProcessOneWayEvent(SPRemoteEventProperties properties)
        {
            YammerStandaloneContext yammerContext = new YammerStandaloneContext();
            yammerContext.UserId = String.Empty;
            yammerContext.LoadAuthenticationResponseToken(String.Empty);

            String message = string.Empty;

            if (properties == null || properties.ItemEventProperties == null)
            {
                yammerContext.PostMessage("Error: properties or item event properties was not specified.");
                return;
            }
          
            try
            {
                Web web;
                Microsoft.SharePoint.Client.User user;
                List list;
                ListItem li;
      
                using (ClientContext clientContext = TokenHelper.CreateRemoteEventReceiverClientContext(properties))
                 {
            
                    if (clientContext == null)
                    {
                        yammerContext.PostMessage("Error: could not create a client context within an event.");
                        return;
                    }  

                    web = clientContext.Web;
                    clientContext.Load(web);

                    user = clientContext.Web.CurrentUser;
                    clientContext.Load(user);

                    list = web.Lists.GetById(properties.ItemEventProperties.ListId);
                    clientContext.Load(list);
                    

                    li = list.GetItemById(properties.ItemEventProperties.ListItemId);
                    clientContext.Load(li, listItem => listItem.DisplayName);

                    clientContext.ExecuteQuery();
                 }

                Activity a = new Activity();
                a.Action = "update";
                a.Actor.Name = properties.ItemEventProperties.UserDisplayName;
                a.Actor.EMail = user.Email;

                if (properties.EventType == SPRemoteEventType.ItemUpdated || properties.EventType == SPRemoteEventType.ItemUpdating)
                {
                    a.Message = "An item was updated.";
                }
                else if (properties.EventType == SPRemoteEventType.ItemAdded || properties.EventType == SPRemoteEventType.ItemAdding)
                {
                    a.Message = "An item was added.";
                }
                else if (properties.EventType == SPRemoteEventType.ItemDeleted || properties.EventType == SPRemoteEventType.ItemDeleting)
                {
                    a.Message = "An item was deleted.";
                }

                a.Object.Url =  UrlUtilities.EnsurePathEndsWithSlash(properties.ItemEventProperties.WebUrl) + properties.ItemEventProperties.AfterUrl;
                a.Object.Title = li.DisplayName;
                a.Object.Type = "document";

                a.Private = false;
          
                //message += a.Actor.Name + "|" + a.Actor.EMail + "|" + a.Object.Url + "|" + a.Object.Title + "|";

                //yammerContext.PostMessage(message);

                yammerContext.PostActivity(a);
            }
            catch (Exception e)
            {
                yammerContext.PostMessage("An error occurred while posting a message." + e.Message);
            }
            
        }

        private String GetEmailFromLoginName(String loginName, String webUrl)
        {
            int lastChar = loginName.LastIndexOf("\\");

            if (lastChar >= 0)
            {
                loginName = loginName.Substring(lastChar + 1);
            }

            lastChar = loginName.LastIndexOf("|");

            if (lastChar >= 0)
            {
                loginName = loginName.Substring(lastChar + 1);
            }

            if (loginName.IndexOf("@") <= 0)
            {
                Uri uri = new Uri(webUrl);

                String host = uri.Host;
                
                host = host.ToLower();
                host = host.Replace("sharepoint.com", "onmicrosoft.com");

                loginName += "@" + host;
            }

            return loginName;
        }

        private String GetUrlForItem(SPRemoteItemEventProperties itemEventProperties)
        {
            if (itemEventProperties.AfterUrl != null)
            {
                return itemEventProperties.AfterUrl;
            }

            // note: this algorithm is really not right.  should look to retrieve the list item for real and generate the URL from there.  
            return itemEventProperties.WebUrl + itemEventProperties + "/lists/" + itemEventProperties.ListTitle + "/dispform.aspx?Id=" + itemEventProperties.ListItemId;
        }
    }
}

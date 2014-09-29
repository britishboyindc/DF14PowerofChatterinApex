public with sharing class ChatterInputDemoController2 {
    
    private final Project_Member__c projectmember;
    Public Boolean bPosted {get;set;} //enable refresh when executed via Chatter Action
    public Attachment a {get;set;} //Capture Blob
    public String sText {get;set;} //Description for File Attachment
    @testvisible private ConnectApi.FeedElement fpm;

    public ChatterInputDemoController2 (ApexPages.StandardController stdController) {
        this.projectmember = (Project_Member__c)stdController.getRecord();
        a = new Attachment();
        bPosted = FALSE;
        sText = 'Resume Upload ' + userinfo.getFirstName() + ' ' + userinfo.getLastName();
    }
    
    public pagereference insertfile() {
    
        //Attach file to PM Feed
        insertchatterfile();

        //Create new Feed Item Input and then post to Feed in Target Object  
        ConnectApi.FeedItemInput input = new ConnectApi.FeedItemInput();
        
        //Create new Feed Item Input for Project Post and then post to Project Feed  
        input.feedElementType =  ConnectApi.FeedElementType.FeedItem;
        input.SubjectId = projectmember.Project__c;
        
        input.capabilities = new ConnectAPI.FeedElementCapabilitiesInput();
        input.capabilities.content = new ConnectApi.ContentCapabilityInput();
        
        //Share File from First Post with Project 
        input.capabilities.content.contentDocumentId =  fpm.capabilities.content.Id;
        
        ConnectApi.FeedElement fp = ConnectApi.ChatterFeeds.postFeedElement(null, input, null);

        bPosted = TRUE;
        a = null;
        return null;
    }
 
private void insertchatterfile() {    
       
        
        ConnectApi.MessageBodyInput messageInput = new ConnectApi.MessageBodyInput();
        messageInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();
         
        ConnectApi.TextSegmentInput textSegment = new ConnectApi.TextSegmentInput();
        textSegment.text = sText;
        messageInput.messageSegments.add(textSegment);

        //Create new Feed Item Input and then post to Feed in Target Object  
        ConnectApi.FeedItemInput input = new ConnectApi.FeedItemInput();
        input.body = messageInput;
        
        //Create new Feed Item Input and then post to Feed in Target Object  
        input.feedElementType =  ConnectApi.FeedElementType.FeedItem;
        input.SubjectId = projectmember.Id;
        input.body = messageInput;
        
        //Add Content Details
        input.capabilities = new ConnectAPI.FeedElementCapabilitiesInput();
        input.capabilities.content = new ConnectApi.ContentCapabilityInput();
        input.capabilities.content.Title = sText;
        input.capabilities.content.Description = 'Demonstrating Sharing a Chatter File';
    
        //Finally, create Binary Input
        String sFileName = 'Resume Upload ' + userinfo.getFirstName() + ' ' + userinfo.getLastName() + '.doc';
        
        system.debug(a);

        ConnectApi.BinaryInput bi = new ConnectApi.BinaryInput(a.body, a.ContentType, sFileName);  
        
        //But we add actually Binary Input as part of method
        fpm = ConnectApi.ChatterFeeds.postFeedElement(null, input, bi);

}

/*
    
        //Create new Feed Item Input and then post to Feed in Target Object  
        ConnectApi.FeedItemInput input = new ConnectApi.FeedItemInput();
        
        //Create new Feed Item Input and then post to Feed in Target Object  
        input.feedElementType =  ConnectApi.FeedElementType.FeedItem;
        input.SubjectId = 'a00B0000001eNdk';
        
        input.capabilities = new ConnectAPI.FeedElementCapabilitiesInput();
        input.capabilities.link = new ConnectApi.LinkCapabilityInput();
        input.capabilities.link.url = 'http://www.abc27.com/story/26548786/salesforcecom-foundation-expands-salesforce1-for-nonprofits-with-launch-of-ngo-connect'; 
        input.capabilities.link.urlname = 'Test URL';

        ConnectApi.FeedElement fi = ConnectApi.ChatterFeeds.postFeedElement(null, input, null);
*/


}
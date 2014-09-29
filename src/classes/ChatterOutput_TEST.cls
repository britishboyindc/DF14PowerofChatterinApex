@isTest
private class ChatterOutput_TEST {
    /*Be careful of API versions! */
    
    @IsTest(SeeAllData=true)
    static void test_method_one() {
    
    Project__c testp = new Project__c(Name = 'Test');
    insert testp;
    
    ConnectApi.FeedElementPage testpage = new ConnectApi.FeedElementPage();
    List<ConnectApi.FeedElement> testItemList = new List<ConnectApi.FeedElement>();
    
        testItemList.add(createTestElement(testp.Id, TRUE));
        testItemList.add(createTestElement(testp.Id, FALSE));
        testItemList.add(new ConnectAPI.FeedItem());
        
        testpage.elements = testItemList;
    
    ConnectAPI.ChatterFeeds.setTestSearchFeedElementsInFeed(null, ConnectApi.FeedType.Record, testp.Id, 'resume', testpage);
    
    test.startTest();
    
    ChatterOutputDemoController codc = new ChatterOutputDemoController(new ApexPages.StandardController(testp));
    codc.qSearch = 'resume';
    codc.getChatterOutputbySearch();
        
    test.stopTest();
    
    system.assertequals(3, codc.fiw.size());
    
    //Check there is content capability
    system.assertnotequals(NULL, codc.fiw[0].sourceca);
        
    //Check there is content capability
    system.assertequals(NULL, codc.fiw[1].sourceca);
    
    
     
}


private static ConnectApi.FeedElement createTestElement(Id testpId, Boolean bCreateFile) {
ConnectApi.FeedItemInput input = new ConnectApi.FeedItemInput();

ConnectApi.MessageBodyInput messageInput = new ConnectApi.MessageBodyInput();
messageInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();

ConnectApi.TextSegmentInput textSegment = new ConnectApi.TextSegmentInput();
textSegment.text = 'Test resume 1';
messageInput.messageSegments.add(textSegment);

//Create new Feed Item Input and then post to Feed in Target Object  
input.body = messageInput;

//Create new Feed Item Input and then post to Feed in Target Object  
input.feedElementType =  ConnectApi.FeedElementType.FeedItem;
input.SubjectId = testpId;
input.body = messageInput;

ConnectApi.BinaryInput bi;   

if (bCreateFile) {
String s = 'Test Blob';
Blob testbinary = blob.valueof(s);
String sFileName = 'Resume Upload ' + userinfo.getFirstName() + ' ' + userinfo.getLastName() + '.doc';

bi = new ConnectApi.BinaryInput(testbinary, 'application/doc', sFileName);
//Add Content Details
input.capabilities = new ConnectAPI.FeedElementCapabilitiesInput();
input.capabilities.content = new ConnectApi.ContentCapabilityInput();
input.capabilities.content.Title = 'Test Resume';
input.capabilities.content.Description = 'Demonstrating Sharing a Chatter File';
return ConnectApi.ChatterFeeds.postFeedElement(null, input, bi);
}
else {
return ConnectApi.ChatterFeeds.postFeedElement(null, input, null);
}


}

}